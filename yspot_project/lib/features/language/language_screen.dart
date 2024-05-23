import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../authentication/login_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF1717),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
                child: const Text("Welcome"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white,
                ),
                child: const Text("Select your Language"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 5),
              child: DefaultTextStyle(
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
                child: const Text(
                  "you can also change language in App settings after signing in",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 360,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF1717)),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: RadioListTile(
                          title: const Text("English"),
                          value: 'English',
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          }
                      )
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF1717)),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: RadioListTile(
                          title: const Text("தமிழ்"),
                          value: 'Tamil',
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          }
                      )
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF1717)),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: RadioListTile(
                          title: const Text("हिन्दी"),
                          value: 'Hindi',
                          groupValue: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value!;
                            });
                          }
                      )
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF1717),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        child: const Text("Continue"),
                      ),
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

//
//
