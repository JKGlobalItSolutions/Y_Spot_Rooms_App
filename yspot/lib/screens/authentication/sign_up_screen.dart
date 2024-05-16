

import 'package:flutter/material.dart';
import 'package:yspot/screens/authentication/verification_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin:
            const EdgeInsets.only( bottom: 20, top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            width: 500,
            height: 500,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20, right: 200),
                    child: const Text(
                      "User name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  width: 300,
                  height: 38,
                  margin: const EdgeInsets.only(top: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, right: 100),
                    child: const Text(
                      "Email or Phone number",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  width: 300,
                  height: 38,
                  margin: const EdgeInsets.only(top: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, right: 200),
                    child: const Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  width: 300,
                  height: 38,
                  margin: const EdgeInsets.only(top: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, right: 135),
                    child: const Text(
                      "Confirm Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )),
                Container(
                  width: 300,
                  height: 38,
                  margin: const EdgeInsets.only(top: 10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const VerificationScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(7.0),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
                      ),
                    )),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
