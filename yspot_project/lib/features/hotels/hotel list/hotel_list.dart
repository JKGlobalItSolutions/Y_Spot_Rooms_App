import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bottom navbar/home_screen.dart';
import 'hotel_details.dart';

class HotelList extends StatefulWidget {
  const HotelList({Key? key}) : super(key: key);

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  final String mapUrl =
      'https://www.google.co.in/maps/place/Tiruvannamalai,+Tamil+Nadu/@12.2408537,79.0280527,13z/data=!3m1!4b1!4m6!3m5!1s0x3bacc0852cd3d6cd:0x74002b16e5bac856!8m2!3d12.2252841!4d79.0746957!16s%2Fg%2F11bc5bwkxl?entry=ttu';

  void _launchMapUrl() async {
    if (await canLaunchUrl(mapUrl as Uri)) {
      await launchUrl(mapUrl as Uri);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  Map<String, bool> checkboxState = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 90,
              color: const Color(0xFFFF1717),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeScreen();
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Thiruvannamalai / 21 may - 22 may",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFF1717)),
                          ),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF1717),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(spreadRadius: 1, color: Color(0xFFFF1717)),
                ],
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFFF1717))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListTile(
                      onTap: () {
                        _showSortBottomSheet(context);
                      },
                      leading: Image.asset(
                        "assets/icons/swap.png",
                        color: const Color(0xFFFF1717),
                        height: 20,
                        width: 20,
                      ),
                      title: const Text(
                        "Sort",
                        style: TextStyle(
                          color: Color(0xFFFF1717),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      onTap: () {
                        _showFilterBottomSheet(context);
                      },
                      leading: Image.asset(
                        "assets/icons/filter.png",
                        color: const Color(0xFFFF1717),
                        height: 20,
                        width: 20,
                      ),
                      title: const Text(
                        "Filter",
                        style: TextStyle(
                          color: Color(0xFFFF1717),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      onTap: _launchMapUrl,
                      leading: Image.asset(
                        "assets/icons/maps-and-flags.png",
                        color: const Color(0xFFFF1717),
                        height: 20,
                        width: 20,
                      ),
                      title: const Text(
                        "Map",
                        style: TextStyle(
                          color: Color(0xFFFF1717),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Hotels').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return buildHotelCard(snapshot.data?.docs[index]
                          as DocumentSnapshot<Object?>);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* --------->Hotel Card Widget<------------ */

  Widget buildHotelCard(DocumentSnapshot hotelSnapshot) {
    if (!hotelSnapshot.exists) {
      // Handle the case where the document snapshot doesn't exist
      return SizedBox(); // Or any other fallback widget or null if appropriate
    }
    Map<String, dynamic>? hotelData =
        hotelSnapshot.data() as Map<String, dynamic>?;

    if (hotelData == null) {
      // Handle the case where hotelData is null
      return SizedBox(); // Or any other fallback widget or null if appropriate
    }
    String hotelId = hotelSnapshot.id;
    String roomId = hotelData['roomId'] ?? '';
    double ratings = hotelData.containsKey('Ratings')
        ? hotelData['Ratings']?.toDouble() ?? 0.0
        : 0.0;

    // Get the first image from the Property Images list or string
    String firstImageUrl = '';
    if (hotelData['Property Images'] is List) {
      List<dynamic> propertyImages = hotelData['Property Images'];
      firstImageUrl = propertyImages.isNotEmpty ? propertyImages[0] : '';
    } else if (hotelData['Property Images'] is String) {
      firstImageUrl = hotelData['Property Images'];
    }

    return InkWell(
      onTap: () {
        print("hotelId: $hotelId");
        print("roomId: $roomId");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetails(
              hotelId: hotelId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  firstImageUrl,
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
                      hotelData['Hotel Name'] ?? '',
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
                          height: 15,
                          width: 15,
                          color: const Color(0xFFFF1717),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            hotelData['Hotel Address'] ?? '',
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
                          height: 15,
                          width: 15,
                          color: const Color(0xFFFF1717),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            hotelData['Accommodation Facilities'] ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/rupee.png",
                          height: 18,
                          width: 18,
                          color: const Color(0xFFFF1717),
                        ),
                        const SizedBox(width: 5),
                        Text(hotelData['Room Price'] ?? ''),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 20,
                        width: 100,
                        color: const Color(0xFFFF1717),
                        alignment: Alignment.center,
                        child: const Text(
                          "See Availability",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
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
                      ratings.toStringAsFixed(1),
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

  /* --------->Sorting Widget<------------ */

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        bool isChecked1 = false;
        bool isChecked2 = false;
        bool isChecked3 = false;
        bool isChecked4 = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    checkColor: const Color(0xFFFF1717),
                    activeColor: Colors.transparent,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Color(0xFFFF1717),
                      ),
                    ),
                    title: const Text("Distance from city centre"),
                    value: isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    checkColor: const Color(0xFFFF1717),
                    activeColor: Colors.transparent,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Color(0xFFFF1717),
                      ),
                    ),
                    title: const Text("Property rating(high to low)"),
                    value: isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    checkColor: const Color(0xFFFF1717),
                    activeColor: Colors.transparent,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Color(0xFFFF1717),
                      ),
                    ),
                    title: const Text("Property rating(low to high)"),
                    value: isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked3 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    checkColor: const Color(0xFFFF1717),
                    activeColor: Colors.transparent,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Color(0xFFFF1717),
                      ),
                    ),
                    title: const Text("Guest review score"),
                    value: isChecked4,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked4 = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF1717),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      child: DefaultTextStyle(
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        child: const Text("Confirm"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /* --------->Filters Widget<------------ */

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle("Price per night"),
                              _buildCheckboxList([
                                "₹0 - ₹2000",
                                "₹2000 - ₹3000",
                                "₹3000 - ₹6000",
                                "₹6000 - ₹9000",
                                "₹9000 - ₹12000",
                                "₹12000 - ₹15000"
                              ], 'Price per night', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle('Recommended for you'),
                              _buildCheckboxList([
                                "Air conditioning",
                                "Breakfast included",
                                "Parking",
                                "Swimming Pool",
                                "Balcony",
                                "Free cancellation"
                              ], 'Recommended for you', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Meals"),
                              _buildCheckboxList(
                                  ["Self catering", "Breakfast included"],
                                  'Meals',
                                  setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Facilities"),
                              _buildCheckboxList([
                                "Free WiFi",
                                "Non-smoking rooms",
                                "Family rooms",
                                "Swimming pool"
                              ], 'Facilities', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Property Type"),
                              _buildCheckboxList([
                                "Homestays",
                                "Entire homes & apartments",
                                "Hotels",
                                "Villas",
                                "Lodges"
                              ], 'Property Type', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Bed preference"),
                              _buildCheckboxList(["Twin beds", "Double bed"],
                                  'Bed preference', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("User Rating"),
                              _buildCheckboxList([
                                "Excellent:4.2+",
                                "Very Good:3.5+",
                                "Good:3+"
                              ], 'User Rating', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Room Views"),
                              _buildCheckboxList(
                                  ["City View", "Garden View", "Mountain View"],
                                  'Room Views',
                                  setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Room facilities"),
                              _buildCheckboxList([
                                "Air conditioning",
                                "Balcony",
                                "Private Bathroom",
                                "Kitchen/kitchenette",
                                "Private pool",
                                "Bath",
                                "Refrigerator",
                                "TV",
                                "Washing machine",
                                "Shower"
                              ], 'Room facilities', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Property Rating"),
                              _buildCheckboxList([
                                "3 stars",
                                "3.5 stars",
                                "4 stars",
                                "4.5 stars",
                                "Unrated"
                              ], 'Property Rating', setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle("Reservation policy"),
                              _buildCheckboxList(
                                  ["Book without credit card", "No prepayment"],
                                  'Reservation policy',
                                  setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                              _buildSectionTitle(
                                  "Distance from centre of Thiruvannamalai"),
                              _buildCheckboxList(
                                  ["Less than 3km", "Less than 5km"],
                                  'Distance from centre of Thiruvannamalai',
                                  setState),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFFF1717),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _seeResults,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF1717),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: DefaultTextStyle(
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                child: const Text("See Results"),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                checkboxState.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF1717),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: DefaultTextStyle(
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                child: const Text("Reset"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _seeResults() {
    // Handle See Results button action
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCheckboxList(
      List<String> options, String section, StateSetter setState) {
    return Column(
      children: options.map((option) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(option),
          checkColor: const Color(0xFFFF1717),
          activeColor: Colors.transparent,
          side: const BorderSide(
            color: Color(0xFFFF1717),
          ),
          value: checkboxState['$section-$option'] ?? false,
          onChanged: (value) {
            setState(() {
              checkboxState['$section-$option'] = value!;
            });
          },
        );
      }).toList(),
    );
  }
  /* --------->Map Widget<------------ */
}
