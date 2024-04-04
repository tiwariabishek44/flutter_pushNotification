import 'package:flutter/material.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundColor,
      title: Text(
        title,
        style: AppStyles.appbar,
      ),
    );
  }
}
