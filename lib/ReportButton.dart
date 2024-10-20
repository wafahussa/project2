import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime time = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(time);
String formattedTime = DateFormat('HH:mm').format(time);

class Reportbutton extends StatelessWidget {
  final IconData icon;
  final String street;
  final VoidCallback onPressed;

  const Reportbutton({
    required this.icon,
    required this.street,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: height * 0.02, // الحشوة بناءً على ارتفاع الشاشة
        horizontal: width * 0.05, // الحشوة بناءً على عرض الشاشة
      ),
      child: ListTile(
        leading: Icon(icon, size: height * 0.05, color: Colors.blue),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              street,
              style: TextStyle(fontSize: height * 0.02),
            ),
            Text(
              'Date:$formattedDate Time:$formattedTime',
              style: TextStyle(fontSize: height * 0.015),
            ),
          ],
        ),
        trailing:
            Icon(Icons.arrow_forward, size: height * 0.04, color: Colors.blue),
        onTap: onPressed,
      ),
    );
  }
}
