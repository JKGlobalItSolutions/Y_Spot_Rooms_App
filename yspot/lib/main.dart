import 'package:flutter/material.dart';
import 'package:yspot/screens/language_screen.dart';
import 'package:yspot/screens/splash_screen.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(child: LanguageScreen()),
    );
  }
}
