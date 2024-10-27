// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io'; // لاستيراد فئة File

class Uploadimages extends StatefulWidget {
  File image;

  Uploadimages({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<Uploadimages> createState() => _UploadimagesState();
}

class _UploadimagesState extends State<Uploadimages> {
  // تأكد من تعريف المعامل كـ required
  final String location = 'cairo';
  Uint8List? finalimage;
  String? responcelocation;
  String? detectedcalsses;

  int? lol;

//converting the image to base64
  Future<String> convertImageToBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(
        "image was converted to base64======================================================");

    return base64Image;
  }

//=================================
//sending the image to the api
  Future<void> sendImageToApi(String base64Image, String location) async {
    String apiUrl = 'https://589f-151-255-13-245.ngrok-free.app/detect';

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'base_file': base64Image,
        'location': location, // assuming location is required
      }),
    );
    print("got data passed the data to the api ==============================");
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print(
          "The data was successfully modified ===================================");

      if (response.statusCode == 200) {
        print(
            "The data was successfully modified ===================================");

        // Decode the response body (no need for await)
        var jsonResponse = jsonDecode(response.body);

        // Check if 'modifiedImage' exists and is not null
        if (jsonResponse != null && jsonResponse['image_with_boxes'] != null) {
          String modifiedBase64Image = jsonResponse['image_with_boxes'];

          // Decode the base64 image to Uint8List (no need for await)
          Uint8List imageBytes = base64Decode(modifiedBase64Image);

          // At this point, you have the decoded imageBytes
          print('Image decoded successfully');

          // Update the UI and replace the image with the new one
          setState(() {
            detectedcalsses = jsonResponse['detected_classes'];
            responcelocation = jsonResponse['location'];
            finalimage = imageBytes;
            // Write the imageBytes to the original file
            widget.image.writeAsBytesSync(
                imageBytes); // Use writeAsBytesSync to write synchronously

            // Update any other state, e.g., setting a variable to confirm the change
            lol = 27;
          });
        } else {
          print('Error: "modifiedImage" key is missing or null');
        }
      } else {
        print(
            'Failed to modify the image. Status code: ${response.statusCode}');
      }
    }

    // Assuming this is the response key
  }

//=========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RoadEye',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            finalimage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.memory(
                      finalimage!,
                      width: 380,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.file(
                      widget.image, // عرض الصورة الممررة
                      width: 380,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
            SizedBox(height: 20),
            Container(
              child: Text(
                  "location : ${responcelocation != null ? responcelocation : "un known"}"),
            ),
            Container(
              child: Text(
                  "detected calsses :${detectedcalsses != null ? detectedcalsses : 'un known'}"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: () async {
                //convert the image function
                String base64Image = await convertImageToBase64(widget.image);
                //send the data to the api

                sendImageToApi(base64Image, location);
              },
              child: Text(
                'Detect',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
