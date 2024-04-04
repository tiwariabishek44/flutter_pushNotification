import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final IconData iconData;

  const NoDataWidget({Key? key, required this.message, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
