import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // إنشاء AnimationController والتحكم في مدة الحركة
    _controller = AnimationController(
      duration: Duration(seconds: 2), // مدة الحركة
      vsync: this,
    );

    // Tween لتمرير حجم الصورة بين قيمتين (تصغير وتكبير)
    _animation = Tween<double>(begin: 0.9, end: 1.5).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

    // بدء الحركة بشكل مستمر (ذهاب وإياب)
    _controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    // التخلص من AnimationController لتجنب تسرب الذاكرة
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.17, // تحديد الحجم بناءً على نسبة من الشاشة
            ),
            // استخدام ScaleTransition لتطبيق الأنيميشن
            ScaleTransition(
              scale: _animation!,
              child: Image.asset(
                'assets/logo.png',
                width: width * 0.5, // جعل عرض الصورة نسبيًا لحجم الشاشة
              ), // ضع مسار الشعار الخاص بك هنا
            ),
            SizedBox(
              height: height * 0.3, // تحديد المسافة بناءً على نسبة من الشاشة
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(
                horizontal:
                    width * 0.3, // جعل الحشوة عرضية بناءً على عرض الشاشة
                vertical:
                    height * 0.02, // جعل الحشوة الطولية بناءً على طول الشاشة
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('login');
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: height * 0.03, // جعل حجم الخط نسبيًا لطول الشاشة
                  color: Colors.white,
                ),
              ),
              color: Colors.blue[400],
            ),
          ],
        ),
      ),
    );
  }
}
