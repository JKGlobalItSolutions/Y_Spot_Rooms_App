import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../maps/access_location_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  // final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  String _selectedCountryCode = '+91';
  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    // Initialize country code to +91
    _selectedCountryCode = '+91';
  }

  Future<void> emailSignup(BuildContext context) async {
    try {
      String password = _passwordController.text;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      User user = userCredential.user!;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccessLocationScreen(
              user: user,
            ),
          ));
    } catch (e) {
      if (e is FirebaseAuthException && e.code == "email-already-in-use") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Already Registered'),
              content: Text('The provided email address is already in use.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      } else {
        print("Error: $e");
      }
    }
  }

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    String phoneNumberWithCountryCode =
        _selectedCountryCode + _phoneNumberController.text;
    String phoneNumber = _phoneNumberController.text;
    if (phoneNumber.isNotEmpty) {
      _verifyPhoneNumberProcess(phoneNumber, context);
    } else {
      // Show error message if phone number is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your phone number.'),
        ),
      );
    }
  }

  Future<void> _verifyPhoneNumberProcess(
      String phoneNumber, BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign in using the completed credential
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Failed to verify phone number: ${e.message}');
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to verify phone number: ${e.message}'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification ID and show the OTP field
          setState(() {
            _verificationId = verificationId;
          });
          // Navigate to the OTP verification screen
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         VerificationScreen(verificationId: verificationId),
          //   ),
          // );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout here
          print('Verification timed out: $verificationId');
        },
        timeout: Duration(seconds: 60),
        // Timeout duration
        // Force sending SMS code when automatic code resolution fails
        forceResendingToken: null,
      );
    } catch (e) {
      print('Error verifying phone number: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying phone number: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 300,
                ),
                child: DefaultTextStyle(
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  child: const Text("Sign up"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                width: 500,
                height: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        left: 60,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        child: const Text("User name"),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 38,
                      margin: const EdgeInsets.only(top: 10, left: 60),
                      child: const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 60,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        child: const Text("Email"),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 38,
                      margin: const EdgeInsets.only(top: 10, left: 60),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 60,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        child: const Text("Phone number"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 55),
                      height: 50,
                      width: 300,
                      child: Expanded(
                        child: IntlPhoneField(
                          style: TextStyle(fontSize: 15),
                          disableAutoFillHints: true,
                          disableLengthCheck: true,
                          initialCountryCode: 'IN',
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          onChanged: (phone) {
                            setState(() {
                              _phoneNumberController.text =
                                  phone.completeNumber;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 60,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        child: const Text("Password"),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 38,
                      margin: const EdgeInsets.only(top: 10, left: 60),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint_outlined),
                          suffixIcon: Icon(Icons.remove_red_eye_rounded),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 60,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                        child: const Text("Confirm Password"),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 38,
                      margin: const EdgeInsets.only(top: 10, left: 60),
                      child: TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: Icon(Icons.remove_red_eye_rounded),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 130),
                      child: ElevatedButton(
                        onPressed: () {
                          emailSignup(context);
                          _verifyPhoneNumber(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: DefaultTextStyle(
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                            child: const Text("Sign Up"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
