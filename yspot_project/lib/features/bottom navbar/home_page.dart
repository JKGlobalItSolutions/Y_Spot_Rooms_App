import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:yspot_project/features/bottom%20navbar/user_page.dart';
import 'package:yspot_project/features/bottom%20navbar/home_screen.dart';
import 'Favourite_page.dart';
import 'Notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required User user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const FavouritePage(),
    const NotificationPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white, // Adjust the height here
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingNavbar(
          margin: const EdgeInsets.only(bottom: 0),
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: "Home"),
            FloatingNavbarItem(icon: Icons.favorite, title: "Favorites"),
            FloatingNavbarItem(icon: Icons.notifications, title: "Wishlist"),
            FloatingNavbarItem(icon: Icons.person, title: "Profile"),
          ],
          elevation: 3,
          backgroundColor: const Color(0xFFFF1717),
          selectedBackgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
