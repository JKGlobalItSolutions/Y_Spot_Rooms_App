import 'package:flutter/material.dart';
import 'package:yspot/screens/main_screens.dart';

class AccessLocation extends StatefulWidget {
  const AccessLocation({super.key});

  @override
  State<AccessLocation> createState() => _AccessLocationState();
}

class _AccessLocationState extends State<AccessLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Text(
              "Select your location",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            width: 500,
            height: 500,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child:
                        const Image(image: AssetImage("assets/location.jpg"))),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 60,right: 60,top: 10,bottom: 10),
                    child: const Text(
                      "Use current location",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 90,right: 90,top: 10,bottom: 10),
                    child: const Text(
                      "Enter location",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  "Enter your favorite location",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
