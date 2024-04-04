import 'package:flutter/material.dart';

class EmptyCartPage extends StatelessWidget {
  final Function onClick;

  EmptyCartPage({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onClick(); // Call the function passed to the constructor
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/cart.png', // Replace with your image asset path
                width: 200, // Adjust image width as needed
                height: 200, // Adjust image height as needed
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 8),
            child: Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
