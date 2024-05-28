import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'hotel_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController roomcount = TextEditingController();
  late PickerDateRange _selectedRange;

  List<String> locations = ["Thiruvannamalai"];
  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedRange = PickerDateRange(
      now.subtract(const Duration(days: 1)),
      now.add(const Duration(days: 1)),
    );
    locationController.addListener(() {
      filterLocations();
    });
  }

  void filterLocations() {
    List<String> tempLocations = [];
    tempLocations.addAll(locations);
    if (locationController.text.isNotEmpty) {
      tempLocations.retainWhere((location) => location
          .toLowerCase()
          .contains(locationController.text.toLowerCase()));
    }
    setState(() {
      filteredLocations = tempLocations;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    PickerDateRange? pickedRange;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SfDateRangePicker(
              headerStyle: const DateRangePickerHeaderStyle(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: _selectedRange,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  _selectedRange = args.value ?? _selectedRange;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                pickedRange = _selectedRange;
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    if (pickedRange != null) {
      setState(() {
        _selectedRange = pickedRange!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.redAccent.shade400,
                child: Image.asset(
                  "assets/LOGO.png",
                  height: screenHeight * 0.10,
                  width: screenWidth,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: screenWidth,
                color: Colors.redAccent.shade400,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildChip('Stay', Icons.bed, context),
                      const SizedBox(width: 10),
                      _buildChip('Bus', Icons.bus_alert_outlined, context),
                      const SizedBox(width: 10),
                      _buildChip('Flight+Hotel', Icons.flight, context),
                      const SizedBox(width: 10),
                      _buildChip('Car Rental', Icons.car_rental, context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                height: 300,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade400,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSearchBarList(locationController,
                        "Where are you going?", Icons.bed_outlined),
                    InkWell(
                      onTap: () {
                        _selectDateRange(context);
                      },
                      child: Container(
                        width: screenWidth * 0.85,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            _selectedRange.startDate != null &&
                                _selectedRange.endDate != null
                                ? '${DateFormat('dd/MM/yyyy').format(_selectedRange.startDate!)} - ${DateFormat('dd/MM/yyyy').format(_selectedRange.endDate!)}'
                                : 'Select date range',
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                    _buildTextField(
                        roomcount, "2 adult/0 child(1 room)", Icons.person),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const hotellist(),
                            ));
                      },
                      child: Container(
                        height: 50,
                        width: screenWidth * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius:
                          const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Center(
                          child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Your Recent Search",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildRecentSearch(),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Offers",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text("Deals and special offer for you"),
              ),
              const SizedBox(height: 5),
              _buildOffers(),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Travelers Searching In India Also Booked These",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(5)),
                          child: Image.asset(
                            "assets/KODAIKANAL.jpg",
                            fit: BoxFit.fill,
                            height: 100,
                            width: 180,
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                "Bangalore",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                      ]),
                      const SizedBox(
                        width: 5,
                      ),
                      Stack(children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            child: Image.asset(
                              "assets/isha.jpeg",
                              fit: BoxFit.fill,
                              height: 100,
                              width: 180,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                "Bangalore",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(5)),
                          child: Image.asset(
                            "assets/bangalore.jpg",
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                "Bangalore",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                      ]),
                      const SizedBox(
                        width: 5,
                      ),
                      Stack(children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            child: Image.asset(
                              "assets/mysore.jpg",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                "Mysore",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                      ]),
                      const SizedBox(
                        width: 5,
                      ),
                      Stack(children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(5)),
                          child: Container(
                            child: Image.asset(
                              "assets/mumbai.jpg",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: const Text(
                                "Mumbai",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Explore India",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "These Popular Destination have lot to offer",
                    style: TextStyle(
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/Goa.webp",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Goa")),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("4,231 Properties"))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/mumbai.jpg",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Mumbai")),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("4,231 Properties"))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/ooty.jpg",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Ooty")),
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("4,231 Properties"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Discover your property type",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/apartments.webp",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Text("Apartments"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/hotels.jpg",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Text("Hotels"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/villa.webp",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Text("VIllas"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/resort.webp",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Text("Resort"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              child: Image.asset(
                                "assets/cabins.jpeg",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          const Text("Cabins"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon, BuildContext context) {
    return InkWell(
      onTap: () {
        print("$label clicked");
      },
      child: Chip(
        elevation: 4,
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        side: const BorderSide(
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent.shade400,
        avatar: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchBarList(
      TextEditingController controller, String hint, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon),
            title: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          if (filteredLocations.isNotEmpty)
            SizedBox(
              height: 50,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredLocations[index]),
                      onTap: () {
                        setState(() {
                          controller.text = filteredLocations[index];
                          filteredLocations = [];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(
          icon,
          color: Colors.brown,
        ),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearch() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Image.asset(
                    "assets/Goa.webp",
                    fit: BoxFit.cover,
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Goa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                    ),
                    Text("21 April - 21 May, 4 People"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffers() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Image.asset(
                    "assets/park.webp",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "We Have Family Special Theme Park For You..",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Divider(
                        color: Colors.redAccent.shade400,
                        thickness: 1,
                        indent: 10,
                        endIndent: 200,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 20,
                          width: 90,
                          color: Colors.redAccent.shade400,
                          child: const Center(
                            child: Text(
                              "Explore now",
                              style: TextStyle(color: Colors.white),
                            ),
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
      ),
    );
  }
}
