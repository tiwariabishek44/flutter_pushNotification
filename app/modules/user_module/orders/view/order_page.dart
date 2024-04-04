import 'package:get_storage/get_storage.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/modules/user_module/group/group_controller.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/modules/user_module/orders/view/order_product_list.dart';
import 'package:merocanteen/app/widget/custom_app_bar.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderPage extends StatelessWidget {
  final orderContorller = Get.put(OrderController());
  final groupController = Get.put(GroupController());

  Future<void> _refreshData() async {
    orderContorller.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          title: "Orders",
        ),
        body: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Obx(() {
                  if (orderContorller.isLoading.value) {
                    return LoadingScreen();
                  } else {
                    if (orderContorller.orderResponse.value.response!.isEmpty) {
                      return EmptyCartPage(
                        onClick: () {
                          _refreshData();
                        },
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "GroupCode : ${groupController.groupResponse.value.response!.first.groupCode}",
                              style: AppStyles.titleStyle,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            OrderPRoductList(),
                          ],
                        ),
                      );
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
