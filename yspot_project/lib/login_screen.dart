

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10,left: 100),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white,
                ),
                child: const Text("Login"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              width: 500,
              height: 425,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10,left: 100),
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10,left: 100),
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
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, left: 200),
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
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
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: const Divider(
                      color: Colors.red,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
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
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/button assets/fb_icon.png"),
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/button assets/google_icon.png"),
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Image.asset("assets/button assets/apple_icon.png"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
