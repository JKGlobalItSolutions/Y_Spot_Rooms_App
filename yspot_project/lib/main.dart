import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/authentication/login_screen.dart';
import 'package:yspot_project/features/authentication/otp_screen.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';
import 'package:yspot_project/features/booking/billing_screen.dart';
import 'package:yspot_project/features/bottom%20navbar/home_page.dart';
import 'package:yspot_project/features/hotels/hotel%20list/hotel_list.dart';
import 'package:yspot_project/features/bottom%20navbar/home_screen.dart';
import 'package:yspot_project/firebase_options.dart';
import 'package:yspot_project/splash_screen.dart';

import 'features/hotels/hotel details/hotel_details.dart';
import 'features/language/language_screen.dart';

void main() {
  //Todo: Add Widgets Binding
  //Todo: Init Local Storage
  //Todo: Init Payment Methods
  //Todo: Initialize Firebase
  //Todo: Initialize Authentication
  //Todo: Init GoogleMap methods

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
