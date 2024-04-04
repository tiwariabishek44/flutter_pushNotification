import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:merocanteen/app/config/style.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeHeading extends StatelessWidget {
  final String mainHeading;
  final String subHeading;

  WelcomeHeading({
    required this.mainHeading,
    required this.subHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // Takes full screen width
          alignment: Alignment.center, // Aligns child text to the center
          child: Column(
            children: [
              Text(
                mainHeading,
                textAlign:
                    TextAlign.center, // Centers text within the container
                style: AppStyles.appbar,
              ),
              Text(
                subHeading,
                style: AppStyles.titleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
