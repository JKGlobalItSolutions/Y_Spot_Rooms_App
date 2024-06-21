import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yspot_project/features/booking/billing_screen.dart';

import '../../bottom navbar/home_screen.dart';
import 'hotel_images.dart';

class HotelDetails extends StatefulWidget {
  final String hotelId;
  final User userId;
  final String roomId; // Add this line to include roomId

  const HotelDetails({
    Key? key,
    required this.hotelId,
    required this.userId,
    required this.roomId, // Add this line to initialize roomId
  }) : super(key: key);

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  late Future<DocumentSnapshot> hotelDetailsFuture;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> roomDetailsFuture;
  List<String> imageUrls = [];
  String placeholderText = "";
  String roomCount = "";
  String guestCount = "";
  String count = "";
  double staffMembersRating = 0.0;
  double luxuryRating = 0.0;
  double fairPriceRating = 0.0;
  double wifiRating = 0.0;
  double totalRating = 0.0;
  String? selectedRoomId;
  bool showReserveButton = false;

  void handleReserve(String roomId, roomType) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BillingScreen(
        hotelId: widget.hotelId,
        guestsCount: guestCount,
        roomsCount: roomCount,
        bookDate: placeholderText,
        userId: widget.userId,
        roomId: roomId,
        roomType: roomType,
      ),
    ));
  }

  String getRatingText(double rating) {
    if (rating >= 8.0) {
      return "Very Good";
    } else if (rating >= 5.0) {
      return "Good";
    } else {
      return "Average";
    }
  }

  @override
  void initState() {
    super.initState();
    hotelDetailsFuture = fetchHotelDetails(widget.hotelId);
    roomDetailsFuture = fetchRoomDetails();
    placeholderText = " ${HomeScreen.formattedDate}";
    roomCount = HomeScreen.roomCount;
    guestCount = HomeScreen.guestCount;
    count = "${HomeScreen.guestCount} / ${HomeScreen.roomCount} Rooms";
    staffMembersRating = Random().nextDouble() * 5.0 + 5.0;
    luxuryRating = Random().nextDouble() * 5.0 + 5.0;
    fairPriceRating = Random().nextDouble() * 5.0 + 5.0;
    wifiRating = Random().nextDouble() * 5.0 + 5.0;
    totalRating =
        (staffMembersRating + luxuryRating + fairPriceRating + wifiRating) / 4;
  }

  Future<DocumentSnapshot> fetchHotelDetails(String hotelId) async {
    try {
      DocumentSnapshot hotelSnapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hotelId)
          .get();
      if (!hotelSnapshot.exists) {
        throw Exception('Hotel document does not exist.');
      }
      // Check if ratings exist in Firestore
      Map<String, dynamic>? data =
          hotelSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('ratings')) {
        var ratingsData = data['ratings'] as Map<String, dynamic>?;

        if (ratingsData != null) {
          staffMembersRating = ratingsData['staffMembers'] ?? 0.0;
          luxuryRating = ratingsData['luxury'] ?? 0.0;
          fairPriceRating = ratingsData['fairPrice'] ?? 0.0;
          wifiRating = ratingsData['wifi'] ?? 0.0;
          totalRating = ratingsData['rating'] ?? 0.0;
        }
      } else {
        // Generate random ratings if not found
        staffMembersRating = Random().nextDouble() * 5.0 + 5.0;
        luxuryRating = Random().nextDouble() * 5.0 + 5.0;
        fairPriceRating = Random().nextDouble() * 5.0 + 5.0;
        wifiRating = Random().nextDouble() * 5.0 + 5.0;

        // Save ratings to Firestore
        await FirebaseFirestore.instance.collection('Hotels').doc(hotelId).set({
          'ratings': {
            'staffMembers': staffMembersRating,
            'luxury': luxuryRating,
            'fairPrice': fairPriceRating,
            'wifi': wifiRating,
            'rating': totalRating,
          }
        }, SetOptions(merge: true));
      }

      totalRating =
          (staffMembersRating + luxuryRating + fairPriceRating + wifiRating) /
              4.0;
      imageUrls = List<String>.from(data?['Property Images'] ?? []);
      return hotelSnapshot;
    } catch (e) {
      throw Exception('Error fetching hotel details: $e');
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      fetchRoomDetails() async {
    try {
      QuerySnapshot<Map<String, dynamic>> roomSnapshot = await FirebaseFirestore
          .instance
          .collection("Hotels")
          .doc(widget.hotelId)
          .collection("Rooms")
          .get();
      if (roomSnapshot.size == 0) {
        throw Exception('No rooms found for this hotel.');
      }
      return roomSnapshot.docs;
    } catch (e) {
      throw Exception('Error fetching room details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: const Color(0xFFFF1717),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: hotelDetailsFuture,
          builder: (context, hotelSnapshot) {
            if (hotelSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (hotelSnapshot.hasError) {
              print('Hotel Snapshot error: ${hotelSnapshot.error}');
              return Center(child: Text('Error loading hotel details.'));
            } else if (!hotelSnapshot.hasData || !hotelSnapshot.data!.exists) {
              return Center(child: Text('Hotel not found'));
            }
            var hotelData = hotelSnapshot.data!.data() as Map<String, dynamic>;
            return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
              future: roomDetailsFuture,
              builder: (context, roomSnapshot) {
                if (roomSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (roomSnapshot.hasError) {
                  print('Room Snapshot error: ${roomSnapshot.error}');
                  return Center(child: Text('Error loading room details.'));
                } else if (roomSnapshot.data == null ||
                    roomSnapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No rooms available for this hotel.'));
                }
                return buildHotelDetails(hotelData, roomSnapshot.data!);
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildHotelDetails(Map<String, dynamic> hotelData,
      List<DocumentSnapshot<Map<String, dynamic>>> roomSnapshots) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                // Main big image
                if (imageUrls.isNotEmpty)
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
                        imageUrls[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Small images row
                if (imageUrls.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 1; i < imageUrls.length && i < 3; i++)
                          Expanded(
                            child: _buildSmallImage(imageUrls[i]),
                          ),
                        if (imageUrls.length > 3)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelImages(
                                      hotelId: widget.hotelId,
                                      imageUrls: [],
                                    ),
                                  ),
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
                                        imageUrls[3],
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
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
                            child: Text(
                              hotelData['Hotel Name'] ?? 'Hotel Name',
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
                                child: Center(
                                  child: Text(
                                    totalRating.toStringAsFixed(1),
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
                                    child: Text(
                                      '${hotelData['Reviews'] ?? 0} Reviews',
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
                                margin:
                                    const EdgeInsets.only(top: 10, left: 50),
                                child: Image.asset(
                                  "assets/icons/location.png",
                                  height: 20,
                                  color: const Color(0xFFFF1717),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 2),
                                  child: Text(
                                    hotelData['Hotel Address'] ??
                                        'Hotel Address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 20,
                            indent: 30,
                            endIndent: 30,
                            color: Colors.grey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 15, top: 10),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: const Row(
                                  children: [
                                    Text(
                                      "Check In-Check out",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                    Text(
                                      "Guests",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF1717),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Color(0xFFFF1717)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: Colors.white, size: 17),
                                        SizedBox(width: 8),
                                        Text(
                                          placeholderText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF1717),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Color(0xFFFF1717)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person,
                                            color: Colors.white, size: 17),
                                        SizedBox(width: 8),
                                        Text(
                                          count,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 15, left: 20),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price for 1 night",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "₹1874",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "+468 Taxes & Fees",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 20,
                                indent: 30,
                                endIndent: 30,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTotalRating(totalRating),
                              const SizedBox(height: 20),
                              _buildRating("Staff Members", staffMembersRating),
                              _buildRating("Luxury", luxuryRating),
                              _buildRating("Fair Price", fairPriceRating),
                              _buildRating("Wifi", wifiRating),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 20,
                            indent: 30,
                            endIndent: 30,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select your room",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: roomSnapshots.length,
                                    itemBuilder: (context, index) {
                                      var roomData =
                                          roomSnapshots[index].data();
                                      var roomId = roomSnapshots[index].id;
                                      var roomType =
                                          roomData?['roomType'] ?? 'Unknown';
                                      return RoomCard(
                                        roomData: roomData,
                                        date: placeholderText,
                                        guestCount: guestCount,
                                        roomCount: roomCount,
                                        onReserve: () {
                                          handleReserve(roomId, roomType);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _buildTotalRating(double totalRating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Guest Reviews",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 31,
              height: 27,
              decoration: BoxDecoration(
                color: const Color(0xFFFF1717),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  totalRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              getRatingText(totalRating),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21,
                color: Color(0xFFFF1717),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRating(String title, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            _buildRatingBar(rating),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRatingBar(double rating) {
    return Container(
      width: 250,
      height: 6,
      child: LinearProgressIndicator(
        value: rating / 10.0, // assuming rating is out of 10
        backgroundColor: Colors.grey[300],
        valueColor:
            const AlwaysStoppedAnimation<Color>(const Color(0xFFFF1717)),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Map<String, dynamic>? roomData;
  final String date;
  final String guestCount;
  final String roomCount;
  final VoidCallback onReserve;

  RoomCard({
    required this.roomData,
    required this.date,
    required this.guestCount,
    required this.onReserve,
    required this.roomCount,
  });

  @override
  Widget build(BuildContext context) {
    if (roomData == null) {
      return Container();
    }
    var roomPrice = roomData!['roomPrice'] ?? 'N/A';
    var amenities = roomData!['amenities'] ?? 'N/A';
    var roomType = roomData!['roomType'] ?? 'N/A';

    return Card(
      borderOnForeground: true,
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Room Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text("RoomType :$roomType"),
            Text("Amenities: $amenities"),
            Text("Date: $date"),
            Text("Guests: $guestCount"),
            Text("Room Count : $roomCount"),
            Text("Price: $roomPrice"),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onReserve,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF1717),
                ),
                child: Text(
                  "Reserve",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
