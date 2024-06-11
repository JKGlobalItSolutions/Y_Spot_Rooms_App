import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/hotels/hotel%20details/hotel_images.dart';

import '../Booking_details.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFFF1717),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingDetails(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {
                // Define your favorite button action here
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Define your share button action here
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Main big image
                  Container(
                    height: 230,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://source.unsplash.com/random/800x600/?hotel,view',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Small images row
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildSmallImage(
                              'https://source.unsplash.com/random/700x600/?hotel,view'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildSmallImage(
                              'https://source.unsplash.com/random/500x600/?hotel,view'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HotelImages()),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://source.unsplash.com/random/400x600/?hotel,view',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'More',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
          DraggableScrollableSheet(
            initialChildSize: 0.53,
            minChildSize: 0.53,
            maxChildSize: 0.70,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              "Ramana Towers",
                              style: TextStyle(
                                color: Color(0xFFFF1717),
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 15),
                                width: 31,
                                height: 27,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF1717),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Center(
                                  child: Text(
                                    "5.2",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Good",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFFFF1717),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Text(
                                      "480 reviews",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 50),
                                child: Image.asset(
                                  "assets/icons/location.png",
                                  height: 20,
                                  width: 22,
                                  color: const Color(0xFFFF1717),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 2),
                                child: const Text(
                                  "Opp to Ramana ashram",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 40,
                            indent: 30,
                            endIndent: 30,
                            color: Colors.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text(
                                  "Travel Schedule",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 6, left: 15),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Check In-Check out",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 30, top: 3),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF1717),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 2, left: 20),
                                      child: const Text(
                                        "Guests",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFF1717),
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: const BorderSide(
                                            color: Color(0xFFFF1717),
                                          ),
                                        ),
                                      ),
                                      child: DefaultTextStyle(
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            SizedBox(width: 8),
                                            Text("28 May - 29 May"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30,),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFF1717),
                                        shadowColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: const BorderSide(
                                            color: Color(0xFFFF1717),
                                          ),
                                        ),
                                      ),
                                      child: DefaultTextStyle(
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            SizedBox(width: 8),
                                            Text("2 Guests/1 room"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 20),
                                child: const Text(
                                  "Price for 1 night, 2 adults",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 20),
                                child: const Text(
                                  "₹1874",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, left: 20),
                                child: const Text(
                                  "+468 Taxes & Fees",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 40,
                                indent: 30,
                                endIndent: 30,
                                color: Colors.grey,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: const Text(
                                      "Property Location",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 210,
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/location.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, left: 20),
                                    child: const Text(
                                      "10/J,chengam Road 4th street opp to Ramana Ashram,606603 Thiruvannamalai,Tamilnadu,India.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 40,
                                    indent: 30,
                                    endIndent: 30,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: const Text(
                                      "Guest reviews",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 5, left: 15),
                                        width: 31,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF1717),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "5.2",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top:3,left: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Good",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Color(0xFFFF1717),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            child: const Text(
                                              "See all 480 reviews",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin:const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,left: 15),
                                          child: const Text(
                                            "Staff members",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,),
                                          child: const Text(
                                            "7.2",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15, top: 5),
                                    width: 270,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF1717),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  Container(
                                    margin:const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,left: 15),
                                          child: const Text(
                                            "Luxury",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,),
                                          child: const Text(
                                            "6.8",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15, top: 5),
                                    width: 220,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF1717),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  Container(
                                    margin:const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,left: 15),
                                          child: const Text(
                                            "Fair price",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,),
                                          child: const Text(
                                            "8.4",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15, top: 5),
                                    width: 330,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF1717),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  Container(
                                    margin:const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,left: 15),
                                          child: const Text(
                                            "Staff members",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5,),
                                          child: const Text(
                                            "5.4",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15, top: 5),
                                    width: 180,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF1717),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 40,
                                    indent: 30,
                                    endIndent: 30,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text(
                                  "Most Requested facilities",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 15,left: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.room_service_outlined,),
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              child: const Text("Room service",style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.family_restroom,),
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              child: const Text("Family Rooms",style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.soup_kitchen,),
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              child: const Text("Restaurant",style: TextStyle(
                                                fontSize: 15,
                                              ),),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 18),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.pool,),
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              child: const Text("Swimming pool",style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.smoke_free_outlined,),
                                            Container(
                                              margin: const EdgeInsets.only(left: 4),
                                              child: const Text("Non-smoking rooms",style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top:12,left: 16),
                                        child: const Text("see all facilities",style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF1717)
                                        ),),
                                      ),

                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    height: 40,
                                    indent: 30,
                                    endIndent: 30,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text(
                                  "Surrounding Environment",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    const Icon(Icons.assistant_direction_outlined,),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: const Text("Non-smoking rooms",style: TextStyle(
                                        fontSize: 15,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    const Text(".",style: TextStyle(
                                      fontSize: 15,
                                    ),),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      child: const Text("",style: TextStyle(
                                        fontSize: 15,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5000,)// Add other content here if needed
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingDetails(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF1717),
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                color: Color(0xFFFF1717),
                              ),
                            ),
                          ),
                          child: DefaultTextStyle(
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            child: const Text("Confirm"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //Small image widget

  Widget _buildSmallImage(String url) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
