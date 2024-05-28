import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';
import 'otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1717),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            labelStyle: GoogleFonts.urbanist(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            labelText: "Enter Email",
                            labelStyle: GoogleFonts.urbanist(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.numbers),
                            labelText: "Enter Phone Number",
                            labelStyle: GoogleFonts.urbanist(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_rounded),
                            labelText: "Enter Password",
                            labelStyle: GoogleFonts.urbanist(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_rounded),
                            labelText: "Confirm Password",
                            labelStyle: GoogleFonts.urbanist(),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF1717)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OtpScreen()));
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
