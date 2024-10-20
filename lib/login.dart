import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.08, // ضبط المسافة بناءً على نسبة من الشاشة
                ),
                Image.asset(
                  'assets/logo.png',
                  width: width * 0.7, // ضبط حجم الصورة بناءً على عرض الشاشة
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Login to your account',
                  style: TextStyle(
                      fontSize: height * 0.03), // حجم النص نسبي لطول الشاشة
                ),
                SizedBox(
                  height: height * 0.08, // مسافة بين النص وحقول الإدخال
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03),
                  height:
                      height * 0.08, // جعل الحقل متجاوب بناءً على طول الشاشة
                  width: width * 0.9, // عرض الحقل بناءً على عرض الشاشة
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 3),
                          color: Colors.grey)
                    ],
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '  Email',
                      hintStyle: TextStyle(
                        fontSize: height * 0.025, // حجم النص نسبي لطول الشاشة
                        color: Colors.grey[600],
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        size: height * 0.04, // حجم الأيقونة نسبي لطول الشاشة
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03),
                  height:
                      height * 0.08, // جعل الحقل متجاوب بناءً على طول الشاشة
                  width: width * 0.9, // عرض الحقل بناءً على عرض الشاشة
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 3),
                          color: Colors.grey)
                    ],
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '  Password',
                      hintStyle: TextStyle(
                        fontSize: height * 0.025, // حجم النص نسبي لطول الشاشة
                        color: Colors.grey[600],
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: height * 0.04, // حجم الأيقونة نسبي لطول الشاشة
                        color: Colors.grey[600],
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.3,
                    vertical: height * 0.02,
                  ),
                  onPressed: () {
                    signIn();
                    Navigator.of(context).pushReplacementNamed('BottomNavBar');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: height * 0.035, // حجم النص نسبي لطول الشاشة
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
