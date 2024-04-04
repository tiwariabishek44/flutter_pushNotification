import 'package:flutter/material.dart';

class NoOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/noordeer.jpg', // Replace with your image asset path
                width: 200, // Adjust image width as needed
                height: 200, // Adjust image height as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 8),
              child: Text(
                'Enter the  Student Group Code.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
