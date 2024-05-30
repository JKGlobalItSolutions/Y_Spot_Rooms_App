import 'package:flutter/material.dart';

import 'Booking_details.dart';

class roomsdetails extends StatefulWidget {
  const roomsdetails({super.key});

  @override
  State<roomsdetails> createState() => _roomsdetailsState();
}

class _roomsdetailsState extends State<roomsdetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomAppBar(
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingDetails(),
                ));
          },
          child: Container(
            width: 300,
            color: Colors.red,
            child: const Center(
                child: Text("Confirm Booking",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor:const Color(0xFFFF1717),
        // actions: [Image.asset("assets/top logo.jpg")],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Suite Room",
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 300,
              width: 300,
              child: Image.asset(
                'assets/sample assets/hotel1.jpg',
              ),
            ),
            const SizedBox(height: 5),
            const Column(
              children: [
                Text(textAlign: TextAlign.left,
                  "Buddha Elite Residency",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(textAlign: TextAlign.left,
                  "Description",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Near vijaya Nagar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Text("Did you know what that we've got 2.5 Crore booking "
                    "since "),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
