import 'package:flutter/material.dart';
import 'package:flutter_application_2/Generatepdf.dart';
import 'package:flutter_application_2/WaveClipper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'UploadImages.dart'; // تأكد من استيراد صفحة UploadImage

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? file;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageGallery != null) {
      file = File(imageGallery.path);

      // الانتقال إلى صفحة Uploadimages وتمرير مسار الصورة
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Uploadimages(image: file!), // تمرير الصورة
        ),
      );
    }
  }

  int selected = 0;

  List<Widget> name = [];

  @override
  void initState() {
    super.initState();

    name = [
      Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.1, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      await getImage(); // استدعاء التقاط الصورة
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'Detect Defect',
                          style: TextStyle(
                            fontSize: height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(height * 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('Map');
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.map,
                          size: height * 0.1,
                          color: Colors.blue,
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Map',
                          style: TextStyle(
                            fontSize: height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(
                          height * 0.09), // تكبير الحشوة لجعل الأزرار أكبر
                      backgroundColor: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      ClassName.reprts();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.description,
                          size: height * 0.1,
                          color: Colors.blue,
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Report',
                          style: TextStyle(
                            fontSize: height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: height * 0.35,
                  color: Colors.blue[200],
                  alignment: Alignment.center,
                  child: Text(
                    'RoadEye',
                    style: TextStyle(
                      fontSize: height * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(width * 0.05),
              child: name.elementAt(selected),
            ),
          ),
        ],
      ),
    );
  }
}
