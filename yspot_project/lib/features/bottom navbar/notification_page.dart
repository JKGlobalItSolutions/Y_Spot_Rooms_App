import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130.0),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {},
              ),
              flexibleSpace: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Icon(
                    Icons.notifications,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    "Wishlist",
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFF1717),
                      width: 2.0,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildHotelCard(
                  "assets/sample assets/villa.webp",
                  "Lakshmi residensy A/C",
                  "Indra Nagar,Rameshwaram Post 1.5km drive to Arunachaleshwara temple",
                  "24-Room Service",
                  "₹4,264",
                  "5.2",
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 40,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFF1717),
                      width: 2.0,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Past',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    'No Past Bookings',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildHotelCard(String imagePath, String title, String location,
      String service, String price, String rating) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(6),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFFFF1717),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/location.png",
                          height: 13,
                          width: 13,
                          color: const Color(0xFFFF1717),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/check-mark.png",
                          height: 13,
                          width: 13,
                          color: const Color(0xFFFF1717),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            service,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  const Text(
                    "Good",
                    style: TextStyle(color: Color(0xFFFF1717)),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF1717),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      rating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
