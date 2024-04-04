import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Myprofile extends StatelessWidget {
  final String image;

  Myprofile({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: CachedNetworkImage(
                              imageUrl: image ??
                                  '', // Use a default empty string if URL is null
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  size: 40), // Placeholder icon for error
                            ),
                          ),

                          // Add detailed description
                          // ... other product details and add to cart button
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "name", // Replace with actual product name
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Text(
                              "Rs.{product.price}",
                              style: TextStyle(
                                  color: Colors.red.shade200,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ), // Replace with actual price
                            SizedBox(
                              height: 20,
                            ),

                            Text(
                              "Product Details", // Replace with actual product name
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),

                            Text("description"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: 8.h,
                  color: const Color.fromARGB(255, 249, 249, 249),
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200, // 4/10 of the screen width
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GestureDetector(
                      onTap: () {
                        // Handle add to cart functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(
                              width: 8), // Add some space between icon and text
                          Text('Add to Cart'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
