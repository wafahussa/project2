from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from io import BytesIO
import numpy as np
import cv2
from ultralytics import YOLO
import base64
from pyngrok import ngrok
import os

app = FastAPI()
model = YOLO(r'C:\Users\HP\Downloads\Graduation project\flutter_application_2\model\best.pt')

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

class ImagePayload(BaseModel):
    base_file: str
    location: str

@app.post('/detect')
async def detect_object(payload: ImagePayload):
    try:
        # Decode base64 string to bytes
        image_data = base64.b64decode(payload.base_file)
        # print(image_data)
        
        # Convert bytes to numpy array
        nparr = np.frombuffer(image_data, np.uint8)
        
        # Decode image
        image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        results = model.predict(image)

        names = results[0].names
        class_names = [names[int(x)] for x in results[0].boxes.cls.tolist()]

        crack_count = class_names.count('crack')
        faded_lanes_count = class_names.count('faded lanes')
        pothole_count = class_names.count('pothole')

        # Get image with boxes drawn
        image_with_boxes = results[0].plot()

        # Encode the image with boxes to base64
        _, img_encoded = cv2.imencode('.png', image_with_boxes)
        img_byte_arr = base64.b64encode(img_encoded).decode('utf-8')

        return {
            'message': 'Detection Successful',
            'image_with_boxes': img_byte_arr,
            'detected_classes': f"You have: {crack_count} crack(s), {faded_lanes_count} faded lane(s), {pothole_count} pothole(s)",
            'location': payload.location
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
def start_ngrok():
    # Get the port from environment variable or use default
    port = int(os.environ.get("PORT", 8000))
    
    # Set up ngrok
    # If you have an auth token, uncomment and use the next line
    ngrok.set_auth_token('2kcheT9Pzcv21qbNEugpiSrpGiY_7T9MM3k6MmnCypt5CqqEE')
    
    # Create ngrok tunnel
    public_url = ngrok.connect(port).public_url
    print(f"\nNgrok tunnel created: {public_url}")
    print(f"Local URL: http://localhost:{port}")
    return public_url

if __name__ == "__main__":
    import uvicorn
    public_url = start_ngrok()
    uvicorn.run(app, host="127.0.0.1", port=8000)