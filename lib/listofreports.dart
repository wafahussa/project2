// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/ReportButton.dart';
import 'package:flutter_application_2/pdf_creator.dart';

class Listofreports extends StatelessWidget {
  const Listofreports({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Report',
          style: TextStyle(fontSize: height * 0.03, color: Colors.blue),
          // حجم النص بناءً على طول الشاشة
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(width * 0.05), // الحشوة بناءً على عرض الشاشة
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.02), // مسافة فارغة بناءً على طول الشاشة
              Reportbutton(
                street: 'Quraish Street & Hira Street',
                icon: Icons.description,
                onPressed: () async {
                  await PdfCreator.GenerateAndSavePDF(
                      // يمكن إضافة معلومات التقرير هنا
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
