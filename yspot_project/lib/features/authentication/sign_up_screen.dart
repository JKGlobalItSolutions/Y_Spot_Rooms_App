import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yspot_project/features/bottom%20navbar/home_page.dart';

import 'login_screen.dart';
import 'otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

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
              builder: (context) => OtpScreen(
                    initialVerificationId: '',
                  )));
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                initialVerificationId: '',
              ),
            ),
          );
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

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFF1717),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 200,
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    width: 500,
                    height: 520,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            labelText: "Enter Username",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.black),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            counterText: '',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            labelText: "Enter Email",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.black),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            counterText: '',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            child: IntlPhoneField(
                              style: TextStyle(fontSize: 15),
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
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            labelText: "Enter Password",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.black),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            counterText: '',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            labelText: "Confirm Password",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.black),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            counterText: '',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 2),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            emailSignup(context);
                            _verifyPhoneNumber(context);
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
                              child: const Text("Sign up"),
                            ),
                          ),
                        ),
                      ],
                    ),
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
