import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:merocanteen/app/widget/no_data_widget.dart';
import 'package:merocanteen/app/modules/user_module/add_order/view/product_gridview.dart';
import 'package:merocanteen/app/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homepagecontroller = Get.put(ProductController());
  final loginController = Get.put(LoginController());

  Future<void> _refreshData() async {
    homepagecontroller
        .fetchProducts(); // Fetch data based on the selected category
    loginController.fetchUserData();
  }

  String dat = '';

  @override
  void initState() {
    super.initState();
    checkTimeAndSetDate();
  }

  void checkTimeAndSetDate() {
    DateTime currentDate = DateTime.now();
    NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(currentDate);
    int currentHour = currentDate.hour;
    setState(() {
      dat = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
    });

    if ((currentHour >= 15 && currentHour <= 23) ||
        (currentHour >= 0 && currentHour < 1)) {
      // After 4 pm but not after 1 am (next day)
      NepaliDateTime tomorrow = nepaliDateTime.add(Duration(days: 1));
      setState(() {
        dat = DateFormat('dd/MM/yyyy\'', 'en').format(tomorrow);
      });
    } else if (currentHour >= 1) {
      // 1 am or later
      setState(() {
        dat = DateFormat('dd/MM/yyyy\'', 'en').format(nepaliDateTime);
      });
    } else {
      // Handle other cases if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginController().fetchUserData();
    return Scaffold(
      backgroundColor:
          AppColors.backgroundColor, // Make scaffold background transparent
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Obx(() {
            if (homepagecontroller.isLoading.value) {
              return LoadingScreen();
            } else {
              return homepagecontroller.allProductResponse.value == null
                  ? NoDataWidget(
                      message: "There is no items",
                      iconData: Icons.error_outline)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomTopBar(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70.w,
                                  child: Text(
                                    "Popular Food Items",
                                    style: AppStyles.appbar,
                                  ),
                                ),
                                ProductGrid(
                                  dat: dat,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }
          }),
        ),
      ),
    );
  }
}
