import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';

import 'verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1717),
      body: SingleChildScrollView(
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
                child: const Text("Login"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: 500,
              height: 470,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 50),
                    child: DefaultTextStyle(
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      child: const Text("Email or Phone number"),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 38,
                    margin: const EdgeInsets.only(top: 20),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20),
                    alignment: Alignment.centerLeft,
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
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFF1717)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 200),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    color: Colors.blueAccent,
                                    child: ListTile(
                                      leading: const Icon(Icons.email,
                                          color: Colors.white),
                                      title: Text(
                                        'Verify with Email',
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Card(
                                    color: Colors.green,
                                    child: ListTile(
                                      leading: const Icon(Icons.phone,
                                          color: Colors.white),
                                      title: Text(
                                        'Verify with Phone Number',
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VerificationScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF1717),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: DefaultTextStyle(
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: const Text(
                      "or",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: const Divider(
                      color: Colors.red,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child:
                              Image.asset("assets/button assets/fb_icon.png"),
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child: Image.asset(
                              "assets/button assets/google_icon.png"),
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child: Image.asset(
                              "assets/button assets/apple_icon.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
