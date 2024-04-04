import 'dart:ui';
import 'package:merocanteen/app/config/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        // Loading indicator
        Center(
            child: SpinKitFadingCircle(
          color: AppColors.primaryColor,
        )),
      ],
    );
  }
}
