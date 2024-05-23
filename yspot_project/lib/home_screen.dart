

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1717),
      appBar: AppBar(
        title: const Text("Yspot"),
      ),
      body: const Center(
        child: Text("Home Screen of Yspot project"),
      ),
    );
  }
}
