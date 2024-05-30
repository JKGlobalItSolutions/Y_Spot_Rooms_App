import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/authentication/sign_up_screen.dart';
import '../../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Forgot Password:", style: GoogleFonts.urbanist(color: Colors.black,fontSize: 20)),
          content: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.urbanist(),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF1717)),
              ),
            ),
            style: GoogleFonts.urbanist(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",
                  style: GoogleFonts.urbanist(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Reset",
                  style: GoogleFonts.urbanist(color: const Color(0xFFFF1717))),
              onPressed: () {
                String email = _emailController.text;
                // Implement the logic to send the reset password email
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    elevation: 4,
                    behavior: SnackBarBehavior.fixed,
                    backgroundColor: Colors.white,
                    content: Text('Password reset email sent to $email',
                    style: GoogleFonts.urbanist(color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
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
              margin: const EdgeInsets.only(top: 300),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.white,
                ),
                child: const Text("Login"),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: "Enter Email or Phone number",
                        labelStyle: GoogleFonts.urbanist(color: Colors.black),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFFF1717)),
                        ),
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
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_rounded,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        labelText: "Password",
                        labelStyle: GoogleFonts.urbanist(color: Colors.black),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFFF1717)),
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
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _showForgotPasswordDialog(context),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF1717),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 100, right: 100),
                        child: DefaultTextStyle(
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6, left: 155, right: 155),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/button assets/google_icon.png",
                            height: 24,
                            width: 24,
                          ),
                          label: const Text("Sign in"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/button assets/apple_icon.png",
                            height: 24,
                            width: 24,
                          ),
                          label: const Text("Sign in"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "New User?",
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 2,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign up",
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
