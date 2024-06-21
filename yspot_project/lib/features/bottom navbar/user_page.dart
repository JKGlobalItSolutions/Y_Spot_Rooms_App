import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yspot_project/features/authentication/login_screen.dart';
import 'package:yspot_project/features/bottom%20navbar/my_bookings.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35),
            onPressed: () {},
          ),
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
              Text(
                "User Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFF1717),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          color: Colors.white,
          shadowColor: Colors.black, // Shadow color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTextRow(
                    icon: Icons.manage_accounts_outlined,
                    text: "Manage your account",
                    onTap: () {}),
                IconTextRow(
                    icon: Icons.star_outline_outlined,
                    text: "Reviews",
                    onTap: () {}),
                IconTextRow(
                    icon: Icons.question_mark_outlined,
                    text: "Questions to properties",
                    onTap: () {}),
                IconTextRow(
                    icon: Icons.cases_outlined,
                    text: "My Bookings",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBookings(),
                          ));
                    }),
                IconTextRow(
                    icon: Icons.favorite_outline_outlined,
                    text: "Wishlist",
                    onTap: () {}),
                IconTextRow(
                    icon: Icons.settings_outlined,
                    text: "Settings",
                    onTap: () {}),
                IconTextRow(
                    icon: Icons.exit_to_app,
                    text: "Logout",
                    onTap: () {
                      _logout(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }
}

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const IconTextRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(
              width: 10,
            ),
            Text(text, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
