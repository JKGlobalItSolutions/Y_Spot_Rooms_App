
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/authentication/login_screen.dart';
import 'package:yspot_project/features/authentication/otp_screen.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';
import 'package:yspot_project/features/bottom%20navbar/home_page.dart';
import 'package:yspot_project/features/hotels/Booking_details.dart';
import 'package:yspot_project/features/hotels/hotel_list.dart';
import 'package:yspot_project/features/bottom%20navbar/home_screen.dart';
import 'package:yspot_project/splash_screen.dart';

import 'features/hotels/hotel_details.dart';
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
        textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const SplashScreen(child: HomePage()),
    );
  }
}

//SplashScreen(child: LanguageScreen()

