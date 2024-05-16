import 'package:flutter/material.dart';
import 'package:yspot/screens/authentication/access_location_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: const Text(
                "Verification Code",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: 500,
              height: 330,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20, right: 30),
                      child: const Text(
                        "Enter otp code sent to 96********",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )),
                  Container(
                    width: 300,
                    height: 38,
                    margin: const EdgeInsets.only(top: 20),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: const Text(
                        "00:52",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )),
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 35, left: 30),
                          child: const Text(
                            "Don't receive otp code?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 35, left: 4),
                          child: const Text(
                            "resend code",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccessLocation()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Verify & Proceed",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      )),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top:30,left: 60,right: 10,),
                child: const Text(
                  "Security at your fingertips.Enter to safeguard your bookings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
