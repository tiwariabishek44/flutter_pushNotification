import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  final Color color; // Changed the type to Color

  const CustomListTile({
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    required this.color, // Updated the parameter name
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          child: Material(
            color:
                Color.fromARGB(255, 255, 255, 255), // Shadow color and opacity
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color, // Use the provided color
                  child: Icon(
                    leadingIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
