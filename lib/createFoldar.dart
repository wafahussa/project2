// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pdf_creator.dart';

class Foldar extends StatelessWidget {
  final String TripNo;
  final VoidCallback onPressed;

  const Foldar({
    required this.TripNo,
    required this.onPressed,
    required tripDate,
    required tripTime,
  });

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02, // الحشوة الرأسية بناءً على طول الشاشة
        horizontal: width * 0.05, // الحشوة الأفقية بناءً على عرض الشاشة
      ),
      child: ListTile(
        trailing: Icon(
          Icons.arrow_forward,
          size: height * 0.04, // حجم الأيقونة بناءً على طول الشاشة
          color: Colors.blue,
        ),
        onTap: onPressed,
        leading: Icon(
          Icons.create_new_folder,
          size: height * 0.05, // حجم الأيقونة بناءً على طول الشاشة
          color: Colors.blue,
        ),
        title: Text(
          TripNo,
          style: TextStyle(
            fontSize: height * 0.03, // حجم النص بناءً على طول الشاشة
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Date: $formattedDate  Time:$formattedTime',
          style: TextStyle(
            fontSize: height * 0.02,
          ),
        ),
      ),
    );
  }
}
