import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hotels/hotel list/hotel_list.dart';

class HomeScreen extends StatefulWidget {
  //Static variables to called globally
  static late String formattedDate = "";
  static const String defaultLocation = "Thiruvannamalai";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PickerDateRange? _selectedRange;

  int _adults = 0;
  int _children = 0;
  int _rooms = 0;
  String _dropdownValue = 'Select Guests';

  void _incrementCount(int type) {
    setState(() {
      if (type == 0) {
        _adults++;
      } else if (type == 1) {
        _children++;
      } else if (type == 2) {
        _rooms++;
      }
    });
  }

  void _decrementCount(int type) {
    setState(() {
      if (type == 0 && _adults > 0) {
        _adults--;
      } else if (type == 1 && _children > 0) {
        _children--;
      } else if (type == 2 && _rooms > 0) {
        _rooms--;
      }
    });
  }

  void _updateDropdownValue() {
    setState(() {
      _dropdownValue = 'Adults: $_adults, Children: $_children, Rooms: $_rooms';
    });
  }

  Widget _buildIncrementDecrementBox(
      String title, int count, int type, VoidCallback callback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove,
                size: 18,
              ),
              onPressed: () {
                _decrementCount(type);
                callback();
              },
            ),
            const SizedBox(width: 10),
            Text('$count'),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 18,
              ),
              onPressed: () {
                _incrementCount(type);
                callback();
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showGuestSelectorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Guests'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIncrementDecrementBox('Adults', _adults, 0, () {
                    setState(() {});
                  }),
                  _buildIncrementDecrementBox('Children', _children, 1, () {
                    setState(() {});
                  }),
                  _buildIncrementDecrementBox('Rooms', _rooms, 2, () {
                    setState(() {});
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _updateDropdownValue();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Set _selectedRange to null initially
    _selectedRange = null;
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
                backgroundColor: Colors.transparent,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: _selectedRange,
              minDate: DateTime.now(), // Set minimum date
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
        HomeScreen.formattedDate =
        '${DateFormat('dd/MM/yyyy').format(_selectedRange!.startDate!)} - ${DateFormat('dd/MM/yyyy').format(_selectedRange!.endDate!)}';
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
                color: const Color(0xFFFF1717),
                child: Image.asset(
                  "assets/logo assets/yspot_logo.png",
                  height: screenHeight * 0.10,
                  width: screenWidth,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                width: screenWidth,
                color: const Color(0xFFFF1717),
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
              Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 280,
                  width: screenWidth * 0.90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF1717),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: screenWidth * 0.85,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: const ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text(HomeScreen.defaultLocation),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDateRange(context);
                        },
                        child: Container(
                          width: screenWidth * 0.85,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: Text(
                              _selectedRange?.startDate != null &&
                                  _selectedRange?.endDate != null
                                  ? '${DateFormat('dd/MM/yyyy').format(_selectedRange!.startDate!)} - ${DateFormat('dd/MM/yyyy').format(_selectedRange!.endDate!)}'
                                  : 'Select date range',
                            ),
                            trailing: const Icon(Icons.arrow_drop_down),
                            // Adding the hint text property
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          InkWell(
                            onTap: _showGuestSelectorDialog,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                hintText: 'Select Guests',
                                hintStyle: TextStyle(color: Colors.black,fontSize: 18),
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_dropdownValue),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HotelList(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: screenWidth * 0.85,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                            BorderRadius.all(Radius.circular(6)),
                          ),
                          child: const Center(
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
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
        backgroundColor: const Color(0xFFFF1717),
        avatar: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
