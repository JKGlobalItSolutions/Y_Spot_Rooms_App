import 'package:flutter/material.dart';
import 'home_page.dart';

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
      body: Center(
        child: Padding(
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
                      icon: Icons.account_balance_wallet_outlined,
                      text: "Rewards & Wallet",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.cases_outlined,
                      text: "My Trips",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.favorite_outline_outlined,
                      text: "Wishlist",
                      onTap: () {}),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  IconTextRow(
                      icon: Icons.local_activity_outlined,
                      text: "My cash",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.card_giftcard_outlined,
                      text: "My Gift Cards",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.credit_card,
                      text: "Saved Cards",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.settings_outlined,
                      text: "Settings",
                      onTap: () {}),
                  IconTextRow(
                      icon: Icons.exit_to_app, text: "Logout", onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
