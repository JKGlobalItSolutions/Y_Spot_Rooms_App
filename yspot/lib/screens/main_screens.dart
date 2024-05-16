import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yspot/screens/select_categories.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(bottom: 30),
        child: CurvedNavigationBar(
            backgroundColor: Colors.black,
            color: Colors.red,
            buttonBackgroundColor: Colors.white,
            height: 40,

            index: _selectedIndex,
            animationDuration: const Duration(milliseconds: 400),
            items: const [
              Icon(
                Icons.home,
                size: 30,
              ),
              Icon(
                Icons.thumb_up_rounded,
                size: 30,
              ),
              Icon(
                Icons.notifications,
                size: 30,
              ),
              Icon(
                Icons.settings,
                size: 30,
              ),
            ]),
      ),
      appBar: AppBar(
        title: const Text(
          "Yspot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.menu,
                      size: 30,
                    )),
                Container(
                  child: Container(
                    margin: const EdgeInsets.only(left: 270, top: 20),
                    child: const CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/user.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    )),
                const Text(
                  "Thiruvannamalai",
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 180),
                child: const Text(
                  "Good Morning",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                )),
            Container(
                margin: const EdgeInsets.only(right: 190),
                child: const Text(
                  "Balakrishnan",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
            Container(
                margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Stack(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Discover new adventures",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 290, top: 20),
                      child: const Icon(Icons.search),
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(right: 220, top: 20),
              child: const Text(
                "Recommend",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(25),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          const Image(image: AssetImage("assets/hotel1.jpg")),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 150, right: 240),
                          child: const Text(
                            "Boulevard",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 5),
                              child: const Text(
                                "4.2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            RatingBar.builder(
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                }),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, right: 170),
                          child: const Text(
                            "4 Star hotel near phonix mall",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SelectCategories()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  "Select Categories",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400),
                                ),
                              )),
                        ),
                      ],

                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
