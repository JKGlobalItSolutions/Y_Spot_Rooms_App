import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/home_screen.dart';

import '../maps/access_location_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String verificationId;

  const VerificationScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _otpFocusNodes;
  late Timer _otpTimer;
  int _otpTimeoutSeconds = 60;
  bool _isTimeout = false;

  @override
  void initState() {
    super.initState();
    // Initialize OTP controllers and focus nodes
    _otpControllers = List.generate(6, (index) => TextEditingController());
    _otpFocusNodes = List.generate(6, (index) => FocusNode());
    // Start OTP timer
    _startOtpTimer();
  }

  @override
  void dispose() {
    // Dispose OTP controllers and focus nodes
    _otpControllers.forEach((controller) => controller.dispose());
    _otpFocusNodes.forEach((focusNode) => focusNode.dispose());
    _otpTimer.cancel();
    super.dispose();
  }

  // Method to start the OTP timer
  void _startOtpTimer() {
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpTimeoutSeconds > 0) {
          _otpTimeoutSeconds--;
        } else {
          // Resend OTP functionality can be called here after timeout
          // For demonstration, let's print a message
          // print('Resend OTP');
          // Reset the timer
          // _otpTimeoutSeconds = 30;
          _isTimeout = true;
        }
      });
    });
  }

  void _verifyOTP(BuildContext context) async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AccessLocationScreen(user: FirebaseAuth.instance.currentUser!),
          ),
        );
      } catch (e) {
        print('Error verifying OTP: $e');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error verifying OTP: $e'),
          ),
        );
      }
    } else {
      // Show error message if OTP is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter OTP.'),
        ),
      );
    }
  }

  void _resendOTP() {
    // Add logic to resend OTP here
    print('Resend OTP');
    // Reset the timer
    setState(() {
      _otpTimeoutSeconds = 60;
      _isTimeout = false;
    });
    _startOtpTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 250),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  color: Colors.white,
                ),
                child: const Text("Verification code"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 500,
              height: 330,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                          (index) => SizedBox(
                        width: 45,
                        height: 38,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          controller: _otpControllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          focusNode: _otpFocusNodes[index],
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          onChanged: (value) {
                            // If the current value is not empty
                            if (value.isNotEmpty) {
                              // Focus on the next OTP container
                              if (index < _otpControllers.length - 1) {
                                FocusScope.of(context)
                                    .requestFocus(_otpFocusNodes[index + 1]);
                              } else {
                                // Remove focus from the current OTP container
                                _otpFocusNodes[index].unfocus();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    " 00 : $_otpTimeoutSeconds",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive OTP code? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      _isTimeout
                          ? InkWell(
                        onTap: _resendOTP,
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      )
                          : Text(
                        " Resend OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF1717),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        child: const Text("Verify & proceed"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(25),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Colors.white,
                ),
                child: const Text(
                  "Security at your fingertips, Enter to safeguard your bookings.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
