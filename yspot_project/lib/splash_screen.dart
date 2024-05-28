import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
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
      backgroundColor: const Color(0xFFFF1717),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Image.asset(
                  "assets/logo assets/yspot_logo.png",
                  alignment: Alignment.center,
                ),
              ),
            ),
            const SizedBox(height: 280), // Add some space between the image and the text
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: DefaultTextStyle(
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        "Hello, traveler! let's find you the perfect room for your next adventure!!",
                        duration: const Duration(seconds: 3),
                        textStyle: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

