import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';

import '../maps/access_location_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
      
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future<void> _loginuser(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      User user = userCredential.user!;

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccessLocationScreen(user: user),
          ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  Future<void> signinWithGoogle(BuildContext context) async {
    try {
      // Sign out from Google to ensure a fresh sign-in
      await GoogleSignIn().signOut();

      // Attempt Google sign-in
      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

      // If sign-in is successful, proceed with Firebase authentication
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credentials
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        // Ensure that the user is successfully signed in
        if (user != null) {
          // Navigate to the next screen upon successful authentication
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccessLocationScreen(user: user),
            ),
          );
        } else {
          print("User is null after sign-in");
        }
      } else {
        print("Google sign-in failed");
      }
    } catch (e) {
      // Print any errors that occur during the sign-in process
      print("Error during Google sign-in: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
              height: 450,
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
                    child: TextField(
                      controller: _emailcontroller,
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
                        fontWeight: FontWeight.w300,
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
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outlined),
                        suffixIcon: Icon(Icons.remove_red_eye_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 200),
                    child: DefaultTextStyle(
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _loginuser(context);
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.redAccent.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
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
                    padding: const EdgeInsets.only(left: 50, right: 50),
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
                          onPressed: () {
                            signinWithGoogle(context);
                          },
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
