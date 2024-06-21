import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/features/bottom%20navbar/home_screen.dart';

import 'booking_screen.dart';

class BillingScreen extends StatefulWidget {
  final String hotelId;
  final String guestsCount;
  final String roomsCount;
  final User userId;
  final String roomId;
  final String roomType;
  const BillingScreen(
      {super.key,
      required this.hotelId,
      required this.guestsCount,
      required this.roomsCount,
      required String bookDate,
      required this.userId,
      required this.roomType,
      required this.roomId});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  String checkinDate = '';
  String checkoutDate = '';
  @override
  void initState() {
    super.initState();
    checkinDate = HomeScreen.checkinDate;
    checkoutDate = HomeScreen.checkoutDate;
    hotelDetailsFuture = getHotelDetails('hotelId');
  }

  Future<void> saveGuestDetails() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _pinCodeController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _mobileNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }
    Map<String, dynamic> guestDetails = {
      'Full Name': _fullNameController.text,
      'Email Address': _emailController.text,
      'Address': _addressController.text,
      'City': _cityController.text,
      'Pin Code': _pinCodeController.text,
      'Country': _countryController.text,
      'Phone Number': _mobileNumberController.text,
      'No. Of Guests': widget.guestsCount,
      'Rooms Count': widget.roomsCount,
      'hotelId': widget.hotelId,
      'roomId': widget.roomId,
      'Check-In Time & Date': checkinDate,
      'Check-Out Time & Date': checkoutDate,
      'Room Type': widget.roomType
    };
    try {
      await _firestore
          .collection('Hotels')
          .doc(widget.hotelId)
          .collection("Guest Details")
          .doc(widget.userId.uid)
          .set(guestDetails);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Guest details saved successfully!')),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingScreen(
                userId: widget.userId,
                hotelId: widget.hotelId,
                roomId: widget.roomId),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save guest details: $e')),
      );
    }
  }

  late Future<Map<String, dynamic>?> hotelDetailsFuture;

  Future<Map<String, dynamic>?> getHotelDetails(String hotelId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(widget.hotelId)
          .get();
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching hotel details: $e');
      return null;
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
                onPressed: () {},
              ),
            ),
            backgroundColor: const Color(0xFFFF1717),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: hotelDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No Data Found'));
              } else {
                var hotel = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Check Reservation",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF1717),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel['Hotel Name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF1717),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/location.png",
                                      height: 20,
                                      width: 20,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        hotel['Hotel Address'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF1717),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          hotel['Ratings'].toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Good",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color(0xFFFF1717),
                                            ),
                                          ),
                                          Text(
                                            "480 reviews",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 110,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Room Type",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget.roomType,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFFF1717)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Check In",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          checkinDate,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFFF1717)),
                                        ),
                                        Text(
                                          "12am",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Check Out",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          checkoutDate,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFFF1717)),
                                        ),
                                        Text(
                                          "12am",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Guests",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${widget.guestsCount} Guests | ${widget.roomsCount} room",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFFF1717)),
                                        ),
                                        Text(
                                          "1 Night",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total cost Overview",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF1717),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Standard Price (1 room x 1 night)",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "₹5,500",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Discount",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "-₹1,375",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFFF1717)),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Color(0xFFFF1717), thickness: 1),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Price After Reduction",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "₹4,125",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tax and Charges",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "₹495",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Color(0xFFFF1717), thickness: 1),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Amount Payable",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "₹4,620",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Personal Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        _buildLabel("Full name"),
                        _buildTextField(_fullNameController),
                        const SizedBox(height: 5),
                        _buildLabel("Email address"),
                        _buildTextField(_emailController),
                        const Text(
                          "The confirmation email is sent to this address.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        _buildLabel("Address"),
                        _buildTextField(_addressController),
                        const SizedBox(height: 5),
                        _buildLabel("City"),
                        _buildTextField(_cityController),
                        const SizedBox(height: 5),
                        _buildLabel("Pin Code"),
                        _buildTextField(_pinCodeController),
                        const SizedBox(height: 5),
                        _buildLabel("Country/region"),
                        _buildTextField(_countryController),
                        const SizedBox(height: 5),
                        _buildLabel("Mobile number"),
                        _buildTextField(_mobileNumberController),
                        const Text(
                          "So the accommodation can reach you",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "+Add Guest",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF1717),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Payment method",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                _buildPaymentOption(
                                  context,
                                  icon: Icons.stars_outlined,
                                  title: "Reservation",
                                  subtitle: "Pay when you check-in",
                                  onTap: () {
                                    saveGuestDetails();
                                  },
                                ),
                                _buildDivider(),
                                _buildPaymentOption(context,
                                    icon: Icons.paypal_outlined,
                                    title: "UPI options",
                                    subtitle:
                                        "Visa, Mastercard, Amex, Rupay and more",
                                    trailing: () {
                                  Text("Availble Soon");
                                }),
                                _buildDivider(),
                                _buildPaymentOption(context,
                                    icon: Icons.payment_outlined,
                                    title: "Credit/Debit/ATM card",
                                    subtitle:
                                        "Visa, Mastercard, Amex, Rupay and more",
                                    trailing: () {
                                  Text("Availble Soon");
                                }),
                                _buildDivider(),
                                _buildPaymentOption(context,
                                    icon: Icons.account_balance_outlined,
                                    title: "Net Banking",
                                    subtitle: "All Major Banks Available",
                                    trailing: () {
                                  Text("Availble Soon");
                                }),
                                _buildDivider(),
                                _buildPaymentOption(context,
                                    icon: Icons.account_balance_wallet_outlined,
                                    title: "Mobile Wallet",
                                    subtitle: "Amazonpay, Mobiwik",
                                    trailing: () {
                                  Text("Availble Soon");
                                }),
                                _buildDivider(),
                                _buildPaymentOption(context,
                                    icon: Icons.percent_sharp,
                                    title: "EMI",
                                    subtitle: "Credit/Debit card EMI available",
                                    trailing: () {
                                  Text("Availble Soon");
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color(0xFFFF1717),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_sharp,
            size: 25,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
      indent: 15,
      endIndent: 15,
    );
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Text(
          "*",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFF1717),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.urbanist(color: Colors.black),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF1717)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF1717)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF1717)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
