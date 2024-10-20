// ignore_for_file: unused_local_variable, unused_import, prefer_interpolation_to_compose_strings, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ClassName {
  static Future<void> reprts() async {
    final pdf = pw.Document();
    // final DateTime time = DateTime.now();
    // final String formattedDate = '${time.day}/${time.month}/${time.year}';
    // final String formattedTime = '${time.hour}:${time.minute}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.legal,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child:
                    pw.Text('Street Name', style: pw.TextStyle(fontSize: 35)),
              ),
              pw.SizedBox(height: 25),
              pw.Text('Image:', style: pw.TextStyle(fontSize: 35)),
              pw.SizedBox(height: 300),
              pw.Text('Date:                   Time: ',
                  style: pw.TextStyle(fontSize: 30)),
              pw.SizedBox(height: 60),
              pw.Text('Road Defect detected: ',
                  style: pw.TextStyle(fontSize: 40)),
              pw.SizedBox(height: 25),
              pw.Text('-Pothole:', style: pw.TextStyle(fontSize: 30)),
              pw.Text('-Cracks:  ', style: pw.TextStyle(fontSize: 30)),
              pw.Text('-Damaged Lane Markings: ',
                  style: pw.TextStyle(fontSize: 30)),
              pw.SizedBox(height: 40),
              pw.Text('Location: ', style: pw.TextStyle(fontSize: 40)),
            ],
          ); // محتوى الصفحة
        },
      ),
    );
    // الحصول على مسار الحفظ
    final output = await getTemporaryDirectory();
    var file = File("${output.path}/Report.pdf");

    // حفظ ملف PDF
    await file.writeAsBytes(await pdf.save());

    // فتح الملف بعد الحفظ
    OpenFile.open(file.path);
  }
}
