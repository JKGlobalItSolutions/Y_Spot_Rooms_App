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
          borderRadius: BorderRadius.all(Radius.circular(15)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetails(),
                ));
          },
          child: Container(
            width: 300,
            color: Colors.red,
            child: Center(
                child: Text("Confirm Booking",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        // actions: [Image.asset("assets/top logo.jpg")],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Suite Room",
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 300,
              width: 300,
              child: Image.asset(
                'assets/hotel1.jpg',
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Column(
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

                  Container(
                    child: Row(
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

                  ),
                  Text("Did you know what that we've got 2.5 Crore booking "
                      "since "),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
