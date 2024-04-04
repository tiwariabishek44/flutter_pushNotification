import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 50.0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ordered Succesfull ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
