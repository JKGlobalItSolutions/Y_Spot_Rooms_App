import 'package:flutter/material.dart';
import 'package:yspot/screens/authentication/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phonenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Login",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: 500,
            height: 400,
            child: Column(
              children: [
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
                        child: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.g_mobiledata,
                          color: Colors.blue,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.camera,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
