import 'package:flutter/widgets.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListTileContainer extends StatelessWidget {
  final String name;
  final int quantit;
  const ListTileContainer(
      {super.key, required this.name, required this.quantit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Container(
        height: 9.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppStyles.listTileTitle,
              ),
              Text(
                "$quantit-plate",
                style: AppStyles.titleStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
