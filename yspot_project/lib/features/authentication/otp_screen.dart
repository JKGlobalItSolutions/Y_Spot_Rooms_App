import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/bottom%20navbar/home_page.dart';

class OtpScreen extends StatefulWidget {
  final String initialVerificationId;

  const OtpScreen({
    Key? key,
    required this.initialVerificationId,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String _verificationId;
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _otpFocusNodes;
  Timer? _otpTimer;
  int _otpTimeoutSeconds = 60;
  bool _isTimeout = false;

  @override
  void initState() {
    super.initState();
    // Initialize verificationId with the value passed in from the widget
    _verificationId = widget.initialVerificationId;
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
    _otpTimer?.cancel();
    super.dispose();
  }

  // Method to start the OTP timer
  void _startOtpTimer() {
    _otpTimer?.cancel(); // Cancel any existing timer
    _otpTimeoutSeconds = 60;
    _isTimeout = false;
    _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpTimeoutSeconds > 0) {
          _otpTimeoutSeconds--;
        } else {
          _isTimeout = true;
          _otpTimer?.cancel(); // Cancel timer when it reaches zero
        }
      });
    });
  }

  void _verifyOTP(BuildContext context) async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(user: FirebaseAuth.instance.currentUser!),
          ),
        );
      } catch (e) {
        print('Error verifying OTP: $e');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error verifying OTP'),
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

  void _resendOTP() async {
    try {
      _startOtpTimer(); // Restart the timer
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error resending OTP: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF1717),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            controller: _otpControllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            focusNode: _otpFocusNodes[index],
                            decoration: InputDecoration(
                              fillColor: Color(0xFFFF1717),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF1717),
                                ),
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
                                    color: Color(0xFFFF1717),
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
                        // _verifyOTP(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                  user: FirebaseAuth.instance.currentUser!),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF1717),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Verify & Proceed",
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
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
      ),
    );
  }
}
