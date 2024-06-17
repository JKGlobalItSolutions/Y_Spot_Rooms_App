import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HotelImages extends StatelessWidget {
  final String hotelId; // Add this to take the selected hotel's ID

  const HotelImages({super.key, required this.hotelId});

  Future<List<String>> _fetchImages() async {
    // Check if hotelId is non-empty
    if (hotelId.isEmpty) {
      print('Error: hotelId is empty');
      return [];
    }

    try {
      // Fetch the document for the selected hotel
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Hotels")
          .doc(hotelId)
          .get();

      // Check if document exists
      if (!snapshot.exists) {
        print('Document does not exist');
        return [];
      }

      // Cast snapshot data to Map<String, dynamic>
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      // Check if 'Property Images' field exists and is a list
      if (data == null || !data.containsKey('Property Images')) {
        print("'Property Images' field does not exist");
        return [];
      }

      var propertyImages = data['Property Images'];
      if (propertyImages is! List) {
        print("'Property Images' is not a list");
        return [];
      }

      List<String> imageUrls = List<String>.from(propertyImages);
      print('Fetched ${imageUrls.length} images');
      return imageUrls;
    } catch (e) {
      // Log any errors that occur
      print('Error fetching images: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFFFF1717),
          title: const Text(
            'All Images',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<List<String>>(
          future: _fetchImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No images found'));
            } else {
              List<String> imageUrls = snapshot.data!;
              return Container(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Implement navigation or functionality for tapping individual images
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
