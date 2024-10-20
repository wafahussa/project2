// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

final DateTime time = DateTime.now();
final String formattedDate = '${time.day}/${time.month}/${time.year}';
final String formattedTime = '${time.hour}:${time.minute}';

class PdfCreator {
  static Future<void> GenerateAndSavePDF() async {
    final pdf = pw.Document();

    // تحميل الصور لكل صفحة (مثال على 5 صور مختلفة)
    final ByteData imageData1 = await rootBundle.load('assets/8.jpg');
    final ByteData imageData2 = await rootBundle.load('assets/OIP.jpg');
    final ByteData imageData3 = await rootBundle.load('assets/4.jpg');
    final ByteData imageData4 = await rootBundle.load('assets/3.jpg');
    final ByteData imageData5 = await rootBundle.load('assets/OIP.jpg');

    List<Uint8List> images = [
      imageData1.buffer.asUint8List(),
      imageData2.buffer.asUint8List(),
      imageData3.buffer.asUint8List(),
      imageData4.buffer.asUint8List(),
      imageData5.buffer.asUint8List(),
    ];

    // بيانات مخصصة لكل صفحة
    // List<String> titles = [
    //   'Report 001',
    //   'Report 002',
    //   'Report 003',
    //   'Report 004',
    //   'Report 005'
    // ];

    List<String> street = [
      'Quraish Street',
      'Quraish Street',
      'Hira Street',
      'Hira Street',
      'Hira Street',
    ];

    // الروابط المخصصة لكل صفحة
    List<String> googleMapsUrls = [
      'https://goo.gl/maps/6BeeT9o9GtGZqH7K9',
      'https://maps.app.goo.gl/wFSyD1rF93KniW9J7',
      'https://maps.app.goo.gl/CH9LnMx6SUt21HxE8',
      'https://maps.app.goo.gl/KgRp5EW5zGAAbK5t8',
      'https://maps.app.goo.gl/CH9LnMx6SUt21HxE8',
    ];

    List<String> potholes = ['3', '1', '0', '1', '1'];
    List<String> cracks = ['4', '0', '3', '1', '0'];
    List<String> lanes = ['0', '0', '1', '0', '0'];

    // إنشاء 5 صفحات مخصصة
    for (int i = 0; i < 5; i++) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.legal,
          build: (pw.Context context) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // عنوان التقرير لكل صفحة
                // pw.Center(
                //   child: pw.Text(
                //     titles[i],
                //     style: pw.TextStyle(
                //         fontSize: 40, fontWeight: pw.FontWeight.bold),
                //   ),
                // ),
                // التاريخ لكل صفحة
                pw.Center(
                  child: pw.Text(
                    '${street[i]}',
                    style: pw.TextStyle(fontSize: 35),
                  ),
                ),
                pw.SizedBox(height: 25),

                // الصورة المخصصة لكل صفحة
                pw.Text('Image:', style: pw.TextStyle(fontSize: 35)),
                pw.SizedBox(height: 10),
                pw.Image(pw.MemoryImage(images[i])),

                pw.SizedBox(height: 25),
                pw.Text('Date: $formattedDate  Time:$formattedTime',
                    style: pw.TextStyle(fontSize: 30)),
                pw.SizedBox(height: 25),
                // البيانات الخاصة بالحفر والشقوق والمسارات
                pw.Text('Road Defect detected:',
                    style: pw.TextStyle(fontSize: 40)),
                pw.SizedBox(height: 25),
                pw.Text('- Pothole: ${potholes[i]}',
                    style: pw.TextStyle(fontSize: 30)),
                pw.Text('- Cracks: ${cracks[i]}',
                    style: pw.TextStyle(fontSize: 30)),
                pw.Text('- Damaged Lane Markings: ${lanes[i]}',
                    style: pw.TextStyle(fontSize: 30)),
                pw.SizedBox(height: 25),
                // الرابط المخصص لكل صفحة
                pw.UrlLink(
                  destination: googleMapsUrls[i],
                  child: pw.Text(
                    'Location',
                    style: pw.TextStyle(
                      fontSize: 30,
                      color: PdfColors.blue,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // حفظ الـ PDF في ذاكرة الجهاز
    final output = await getTemporaryDirectory();
    var file = File("${output.path}/Report.pdf");

    // حفظ ملف PDF
    await file.writeAsBytes(await pdf.save());

    // فتح الملف بعد الحفظ
    OpenFile.open(file.path);
  }
}
