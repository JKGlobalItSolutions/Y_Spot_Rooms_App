import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bottom navbar/home_page.dart';

class BookingScreen extends StatefulWidget {
  final User userId;
  final String hotelId;
  const BookingScreen({
    super.key,
    required this.userId,
    required this.hotelId,
    required String roomId,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Future<Map<String, dynamic>?> bookingDetailsFuture;

  @override
  void initState() {
    super.initState();
    bookingDetailsFuture = getBookingDetails();
  }

  Future<Map<String, dynamic>?> getBookingDetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('User is not authenticated');
        return null;
      }
      String userId = currentUser.uid;

      // Fetch hotel details
      DocumentSnapshot hotelSnapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(widget.hotelId)
          .get();

      if (!hotelSnapshot.exists) {
        print('Hotel document does not exist');
        return null;
      }

      // Fetch guest details
      DocumentSnapshot guestSnapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(widget.hotelId)
          .collection("Guest Details")
          .doc(widget.userId.uid)
          .get();

      if (!guestSnapshot.exists) {
        print('Guest document does not exist for user ID: $userId');
        return null;
      }

      Map<String, dynamic> hotelData =
          hotelSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> guestData =
          guestSnapshot.data() as Map<String, dynamic>;

      // Merge the two maps
      return {
        ...hotelData,
        ...guestData,
      };
    } catch (e) {
      print('Error fetching booking details: $e');
      return null;
    }
  }

  Future<void> saveBookingDetails(Map<String, dynamic> bookingDetails) async {
    try {
      QuerySnapshot existingBookingSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId.uid)
          .collection('Bookings')
          .where('hotelId', isEqualTo: widget.hotelId)
          .limit(1)
          .get();

      if (existingBookingSnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.userId.uid)
            .collection('Bookings')
            .add(bookingDetails);
        print('Booking details saved successfully.');
      }
    } catch (e) {
      print('Error saving booking details: $e');
    }
  }

  Future<void> cancelBooking() async {
    try {
      // Find the booking document ID
      QuerySnapshot bookingSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId.uid)
          .collection('Bookings')
          .where('hotelId', isEqualTo: widget.hotelId)
          .limit(1)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        String bookingDocId = bookingSnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.userId.uid)
            .collection('Bookings')
            .doc(bookingDocId)
            .update({'status': 'cancelled'});
        print('Booking cancelled successfully.');
      } else {
        print('No booking document found to cancel.');
      }

      setState(() {
        // Update the UI by re-fetching the booking details
        bookingDetailsFuture = getBookingDetails();
      });
    } catch (e) {
      print('Error cancelling booking: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          leading: Container(
            margin: const EdgeInsets.only(top: 10),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: const Color(0xFFFF1717),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: bookingDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No booking details found.'));
          } else {
            final data = snapshot.data!;
            String firstImageUrl = '';
            if (data['Property Images'] is List) {
              List<dynamic> propertyImages = data['Property Images'];
              firstImageUrl =
                  propertyImages.isNotEmpty ? propertyImages[0] : '';
            } else if (data['Property Images'] is String) {
              firstImageUrl = data['Property Images'];
            }

            // Save booking details
            saveBookingDetails(data);

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['Hotel Name'] ?? 'Hotel Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF1717),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/location.png",
                                height: 15,
                                width: 15,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  data['Hotel Address'] ?? 'Hotel Address',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Entire Stay duration",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Check In",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              data['Check-In Time & Date'] ??
                                                  'Check In Date',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xFFFF1717),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Check Out",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              data['Check-Out Time & Date'] ??
                                                  'Check Out Date',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xFFFF1717),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "Room Type",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          data['Room Type'] ?? 'N/A',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Color(0xFFFF1717),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    firstImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Price",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color(0xFFFF1717),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Goods & service Tax",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "₹${data['Price'] ?? 'N/A'}/-",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: Color(0xFFFF1717),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Booking Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color(0xFFFF1717),
                            ),
                          ),
                          Text(
                            data['status'] ?? 'N/A',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            user: FirebaseAuth.instance.currentUser!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF1717),
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
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
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      child: const Text("Back to Home"),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await cancelBooking();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            user: FirebaseAuth.instance.currentUser!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: DefaultTextStyle(
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      child: const Text("Cancel Booking"),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
