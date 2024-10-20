// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Auth.dart';
import 'package:flutter_application_2/BottomNavBar.dart';
import 'package:flutter_application_2/Home.dart';
import 'package:flutter_application_2/Map.dart';
import 'package:flutter_application_2/SplachScreen.dart';
import 'package:flutter_application_2/Start.dart';
import 'package:flutter_application_2/listofreports.dart';
import 'package:flutter_application_2/login.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_collection_literals
      home: SplashScreen(),
      routes: {
        'SplashScreen': (context) => SplashScreen(),
        'Start': (context) => Start(),
        'login': (context) => Login(),
        'Home': (context) => Home(),
        'Listofreports': (context) => Listofreports(),
        'Map': (context) => MapL(),
        'BottomNavBar': (context) => BottomNavBar(),
        'Auth': (context) => Auth(),
      },
    );
  }
}
