import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/widget/product_grid_view.dart';
import 'package:merocanteen/app/widget/custom_app_bar.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:merocanteen/app/widget/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VHomePage extends StatelessWidget {
  final homepagecontroller = Get.put(ProductController());

  final logincontroller = Get.put(LoginController());

  Future<void> _refreshData() async {
    homepagecontroller
        .fetchProducts(); // Fetch data based on the selected category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: CustomAppBar(title: "Canteen Menue"),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: Stack(
          children: [
            Container(
              height: 30.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/screen2.png"), // Replace "assets/background_image.jpg" with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: null, // No need for child when using background image
            ),
            Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: Center(
                child: Obx(() {
                  if (homepagecontroller.isLoading.value) {
                    return LoadingScreen();
                  } else {
                    return homepagecontroller.allProductResponse.value == null
                        ? NoDataWidget(
                            message: "There is no items",
                            iconData: Icons.error_outline)
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: VendorProductGrid(),
                                ),
                              ],
                            ),
                          );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
