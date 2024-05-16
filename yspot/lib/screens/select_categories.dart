import 'package:flutter/material.dart';

class SelectCategories extends StatefulWidget {
  const SelectCategories({super.key});

  @override
  State<SelectCategories> createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yspot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15,right: 220,top: 20),
            child: const Text(
              "Select Categories",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
          //Select Categories
          Container(
            margin: const EdgeInsets.only(
                left: 15, right: 15, top: 15, bottom: 0),
            child: Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15, top: 15, bottom: 15, right: 200),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/hotel3.jpg",
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 15, right: 15, top: 15, bottom: 0),
            child: Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15, top: 15, bottom: 15, right: 200),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/hotel1.jpg",
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 15, right: 15, top: 15, bottom: 0),
            child: Card(
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15, top: 15, bottom: 15, right: 200),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/hotel2.webp",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
