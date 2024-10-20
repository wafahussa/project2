import 'package:flutter/material.dart';
import 'dart:io'; // لاستيراد فئة File

class Uploadimages extends StatelessWidget {
  final File image; // تأكد من تعريف المعامل كـ required

  const Uploadimages({Key? key, required this.image})
      : super(key: key); // تمرير الصورة كـ required

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
            Image.file(
              image, // عرض الصورة الممررة
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: () {
                // تنفيذ العمليات المطلوبة عند الضغط على زر 'Detect'
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
