import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/splash_screen.dart';
import 'features/language/language_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDqmnjokk7Q-zKcmq7FWd7MJgHnhS_HHXQ',
    appId: '1:783996806068:android:7e91cf60683ca8d558c8e1',
    messagingSenderId: '783996806068',
    projectId: 'y-spot-e84ca',
    databaseURL: 'https://y-spot-e84ca-default-rtdb.firebaseio.com',
    storageBucket: 'y-spot-e84ca.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const SplashScreen(child: LanguageScreen()),
    );
  }
}

