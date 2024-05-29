import 'package:flutter/material.dart';
import 'package:yspot_project/rooms_details.dart';

class hotellist extends StatefulWidget {
  const hotellist({Key? key}) : super(key: key);

  @override
  State<hotellist> createState() => _hotellistState();
}

class _hotellistState extends State<hotellist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              color: Colors.redAccent.shade400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Thiruvannamalai / 21 may - 22 may",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(spreadRadius: 1, color: Colors.grey.shade400),
                ],
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        "assets/icons/swap.png",
                        color: Colors.redAccent.shade400,
                        height: 20,
                        width: 20,
                      ),
                      title: Text(
                        "Sort",
                        style: TextStyle(
                          color: Colors.redAccent.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        "assets/icons/filter.png",
                        color: Colors.redAccent.shade400,
                        height: 20,
                        width: 20,
                      ),
                      title: Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.redAccent.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        "assets/icons/maps-and-flags.png",
                        color: Colors.redAccent.shade400,
                        height: 20,
                        width: 20,
                      ),
                      title: Text(
                        "Map",
                        style: TextStyle(
                          color: Colors.redAccent.shade400,
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
              child: ListView(
                children: [
                  buildHotelCard(
                    "assets/sample assets/hotel1.jpg",
                    "Ramana Towers",
                    "Opp to Ramana",
                    "24-Room Service",
                    "2,131",
                    "4.2",
                  ),
                  buildHotelCard(
                    "assets/sample assets/cabins.jpeg",
                    "MPS Saai Residency",
                    "Opp to Ramana",
                    "24-Room Service",
                    "2,131",
                    "4.2",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHotelCard(String imagePath, String title, String location,
      String service, String price, String rating) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const roomsdetails(),
            ));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
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
                      title,
                      style: TextStyle(
                        color: Colors.redAccent.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/location.png",
                          height: 20,
                          width: 20,
                          color: Colors.redAccent.shade400,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            location,
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
                          height: 20,
                          width: 20,
                          color: Colors.redAccent.shade400,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            service,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(price),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 20,
                        width: 80,
                        color: Colors.redAccent.shade400,
                        alignment: Alignment.center,
                        child: const Text(
                          "See Availability",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
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
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      rating,
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
}
