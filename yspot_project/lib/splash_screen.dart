

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {

  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child),
              (route) => false);
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Center(child: Container(
            margin: EdgeInsets.only(top: 500),
            child: Image.asset("assets/logo assets/yspot_logo.png"),width: 160,height: 160,)),
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
              ),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText("Hello, traveler! let's find you the perfect room for your next adventure!!"),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
