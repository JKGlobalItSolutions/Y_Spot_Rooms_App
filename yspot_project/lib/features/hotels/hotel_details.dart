import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yspot_project/features/booking/booking_screen.dart';
import 'hotel_images.dart';

class HotelDetails extends StatefulWidget {
  final String hotelId;

  const HotelDetails({
    super.key,
    required this.hotelId,
  });

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  late Future<DocumentSnapshot> hotelDetailsFuture;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    hotelDetailsFuture = fetchHotelDetails(widget.hotelId);
  }

  Future<DocumentSnapshot> fetchHotelDetails(String hotelId) async {
    if (hotelId.isEmpty) {
      print('Error: Hotel ID cannot be empty.');
      throw ArgumentError('Hotel ID cannot be empty.');
    }
    try {
      print('Fetching hotel details for hotelId: $hotelId');
      DocumentSnapshot hotelSnapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(widget.hotelId)
          .get();

      if (!hotelSnapshot.exists) {
        print('Error: Hotel document does not exist.');
        throw Exception('Hotel document does not exist.');
      }

      // Extract image URLs from the document
      if (hotelSnapshot.data() != null) {
        var data = hotelSnapshot.data() as Map<String, dynamic>;
        imageUrls = List<String>.from(data['Property Images'] ?? []);
      }

      return hotelSnapshot;
    } catch (e) {
      print('Error fetching hotel details: $e');
      throw Exception('Error fetching hotel details: $e');
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
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingScreen(),
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
        body: FutureBuilder<DocumentSnapshot>(
          future: hotelDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Snapshot error: ${snapshot.error}');
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              print('Snapshot has no data or does not exist.');
              return const Center(child: Text('Hotel not found'));
            }
            var hotelData = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
                child: Stack(children: [
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
                                          hotelId: widget
                                              .hotelId, // Pass hotelId here
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'More',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        child: Stack(children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: Text(
                                      hotelData['Hotel Name'] ?? 'Hotel Name',
                                      style: TextStyle(
                                        color: Color(0xFFFF1717),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 15),
                                      width: 31,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF1717),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          hotelData['Ratings'] != null
                                              ? hotelData['Ratings'].toString()
                                              : '0.0',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
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
                                          margin:
                                              const EdgeInsets.only(left: 5),
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
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 50),
                                      child: Image.asset(
                                        "assets/icons/location.png",
                                        height: 20,
                                        width: 22,
                                        color: const Color(0xFFFF1717),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 2),
                                      child: Text(
                                        hotelData['Hotel Address'] ??
                                            'Hotel Address',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const Divider(
                                    thickness: 1,
                                    height: 40,
                                    indent: 30,
                                    endIndent: 30,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    children: [
                                      _buildSectionTitle("Travel Schedule"),
                                      _buildPriceInfo(
                                          "₹1874", "+468 Taxes & Fees"),
                                      const Divider(
                                        thickness: 1,
                                        height: 40,
                                        indent: 30,
                                        endIndent: 30,
                                        color: Colors.grey,
                                      ),

                                      // Property Location Section
                                      _buildSectionTitle("Property Location"),
                                      _buildLocationImage(
                                          "assets/location.jpg"),
                                      _buildLocationText(
                                          "10/J,chengam Road 4th street opp to Ramana Ashram,606603 Thiruvannamalai,Tamilnadu,India."),
                                    ],
                                  )
                                ]),
                          )
                        ]));
                  })
            ]));
          },
        ),
      ),
    );
  }

  Widget _buildSmallImage(String imageUrl) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCheckInOutRow(String dateRange) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 6),
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
          SizedBox(width: 30),
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
    );
  }

  Widget _buildGuestsRow(String guestsInfo) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 5),
      child: ElevatedButton(
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
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 17,
              ),
              SizedBox(width: 8),
              Text(guestsInfo),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceInfo(String price, String taxesAndFees) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Price for 1 night, 2 adults",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            taxesAndFees,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoButton(IconData icon, String text) {
    return ElevatedButton(
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
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 17,
            ),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationImage(String imagePath) {
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLocationText(String location) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 5),
      child: Text(
        location,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
