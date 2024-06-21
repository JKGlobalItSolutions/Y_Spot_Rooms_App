import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.favorite,
                size: 50,
                color: Colors.white,
              ),
              Text(
                "Favorites",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFF1717),
          centerTitle: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHotelCard(
            "assets/sample assets/cabins.jpeg",
            "Vijay Balaji A/C",
            "Kanji road,Girivalam pathai 1.5km drive to Arunachaleshwara temple",
            "24-Room Service",
            "₹3,264",
            "9.4",
          ),
        ],
      ),
    );
  }

  Widget buildHotelCard(String imagePath, String title, String location,
      String service, String price, String rating) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(6),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
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
                          height: 13,
                          width: 13,
                          color: const Color(0xFFFF1717),
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
                          height: 13,
                          width: 13,
                          color: const Color(0xFFFF1717),
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
