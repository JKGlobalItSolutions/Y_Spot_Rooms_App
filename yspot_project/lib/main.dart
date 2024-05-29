
import 'package:flutter/material.dart';
import 'package:yspot_project/features/authentication/login_screen.dart';
import 'package:yspot_project/features/authentication/otp_screen.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';
import 'package:yspot_project/home_screen.dart';
import 'package:yspot_project/splash_screen.dart';

import 'features/language/language_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(child: LanguageScreen()),
    );
  }
}

//SplashScreen(child: LanguageScreen()

