import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login_screen.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LinatyApp());
}

class LinatyApp extends StatelessWidget {
  const LinatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoKufi'),
      debugShowCheckedModeBanner: false,
      title: 'Linaty',

      // أول صفحة تظهر حالياً هي صفحة تسجيل الدخول
      home: const LoginScreen(),
    );
  }
}