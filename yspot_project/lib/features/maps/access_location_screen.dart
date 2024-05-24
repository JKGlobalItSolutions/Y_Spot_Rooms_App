import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yspot_project/home_screen.dart';


class AccessLocationScreen extends StatefulWidget {
  const AccessLocationScreen({
    Key? key,
    required User user,
  }) : super(key: key);

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  late TextEditingController _manualLocationTextController;
  late String _currentLocation = '';
  late bool _isLoading = false;
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    _manualLocationTextController = TextEditingController();
  }

  @override
  void dispose() {
    _manualLocationTextController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Location services are disabled",
              style: GoogleFonts.urbanist(),
            ),
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Location permission permanently denied, we cannot request permission.",
            ),
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Using Geocoding to get the address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Extracting the area name from the placemark
      String areaName =
      placemarks.isNotEmpty ? placemarks[0].locality ?? '' : '';

      setState(() {
        _currentLocation = areaName;
        _isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } catch (e) {
      print("Error fetching location: $e"); // Print the error for debugging
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to fetch location. Please try again later.",
          ),
        ),
      );
    }
  }

  void _setManualLocation() {
    setState(() {
      _currentLocation = _manualLocationTextController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title Text
          DefaultTextStyle(
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.white,
            ),
            child: const Text("Select your location"),
          ),
          // Location Container
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(30),
              ),
            ),
            width: 500,
            height: 500,
            child: Column(
              children: [
                // Image Placeholder
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Image(
                    image: AssetImage("assets/location.jpg"),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // Button to Use Current Location
                ElevatedButton(
                  onPressed: _isLoading ? null : _getCurrentLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: DefaultTextStyle(
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Text("Use current location"),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Button to Enter Location Manually
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Enter Location Manually'),
                          content: TextField(
                            controller: _manualLocationTextController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Location',
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                                _setManualLocation();
                              },
                              child: const Text('Set Location'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: DefaultTextStyle(
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      child: const Text("Enter location"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Display Current Location
                DefaultTextStyle(
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  child: Text(
                    "Current Location: $_currentLocation",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter Your Favourite Location",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
