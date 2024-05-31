import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/hotels/hotel_images.dart';

import 'Booking_details.dart';

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
                    Container(
                      margin: const EdgeInsets.only(top: 10,left: 10),
                      child: const Column(
                        children: [
                          Text(
                            "Ramana Towers",
                            style: TextStyle(
                              color: Color(0xFFFF1717),
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // Add other content here if needed
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20, // Adjust as necessary
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
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                color: Color(0xFFFF1717), // Border color
                              ),
                            ),
                          ),
                          child: DefaultTextStyle(
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: const Color(0xFFFF1717),
                            ),
                            child: const Text("Confirm Booking"),
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
