import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1717),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 150),
                child: Text(
                  "Verification Code",
                  style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    width: 500,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Enter otp code sent to number",
                          style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 6; i++)
                                const SizedBox(
                                  width: 45,
                                  height: 40,
                                  child: TextField(
                                    maxLength:
                                    1, // Allow only one character input
                                    keyboardType: TextInputType
                                        .number, // Set keyboard type to number
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFFF1717)),
                                      ),
                                      counterText: '',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF1717),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF1717),
                                        ),
                                      ),),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            "00:52",
                            style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                margin:
                                const EdgeInsets.only(top: 15, left: 30),
                                child: Text(
                                  "Don't receive otp code?",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(top: 15, left: 4),
                                child: Text(
                                  "resend code",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
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
                              child: const Text("Verify & Proceed"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 550,
                margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                child: Text(
                  "Security at your fingertips.Enter to safeguard your bookings",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
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