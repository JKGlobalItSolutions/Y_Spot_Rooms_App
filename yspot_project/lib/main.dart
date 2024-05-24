import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yspot_project/features/language/language_screen.dart';
import 'package:yspot_project/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAWa2tYSJbhZt3FvGocZv_D79bU1bcBc8k',
        appId: '1:457489218074:android:1c3dfdad59afce22a82fa3',
        messagingSenderId: '457489218074',
        projectId: 'yspot-54882',
        databaseURL:
        'https://yspot-54882-default-rtdb.asia-southeast1.firebasedatabase.app',
        storageBucket: 'yspot-54882.appspot.com',
      ));


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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(child: LanguageScreen()),
    );
  }
}

//SplashScreen(child: LanguageScreen()

