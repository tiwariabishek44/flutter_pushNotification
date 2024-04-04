import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:merocanteen/app/modules/common/login/login_controller.dart';
import 'package:merocanteen/app/modules/user_module/order_history/order_history_controller.dart';
import 'package:merocanteen/app/modules/user_module/orders/orders_controller.dart';
import 'package:merocanteen/app/widget/custom_loging_widget.dart';
import 'package:merocanteen/app/widget/empty_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/widget/loading_screen.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderHistoryPage extends StatelessWidget {
  final historyController = Get.put(HistoryController());
  final storage = GetStorage();
  final logincontroller = Get.put(LoginController());

  Future<void> _refreshData() async {
    historyController.fetchGroupHistoryOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order History',
          style: AppStyles.appbar,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
                onTap: _refreshData, child: Icon(Icons.refresh)),
          )
        ],
      ),
      body: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: buildGroupOrderTab(context),
      ),
    );
  }

  Widget buildGroupOrderTab(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          if (historyController.isLoading.value) {
            return LoadingWidget();
          } else {
            if (!historyController.isdata.value) {
              return EmptyCartPage(
                onClick: _refreshData,
              );
            } else {
              // Sort orders by date in descending order
              List<OrderResponse> allOrders =
                  historyController.orderHistoryResponse.value.response!;
              allOrders.sort((a, b) => b.date.compareTo(a.date));

              // Group orders by date
              Map<String, List<OrderResponse>> groupedOrders = {};
              allOrders.forEach((order) {
                String date = order.date; // Assuming date is a string
                if (!groupedOrders.containsKey(date)) {
                  groupedOrders[date] = [];
                }
                groupedOrders[date]!.add(order);
              });

              // Extract unique dates and sort them
              List<String> dates = groupedOrders.keys.toList();
              dates.sort((a, b) => b.compareTo(a));

              // Build the ListView with date headers
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  String date = dates[index];
                  List<OrderResponse> orders = groupedOrders[date]!;

                  // Build date header and order items for each date
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date header
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          date,
                          style: AppStyles.listTileTitle,
                        ),
                      ),
                      // Order items
                      ...orders.map((order) => buildItemWidget(order)).toList(),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Divider(
                        height: 0.3,
                        thickness: 0.1,
                        color: AppColors.iconColors,
                      )
                    ],
                  );
                },
              );
            }
          }
        }),
      ),
    );
  }

  Widget buildItemWidget(OrderResponse item) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h),
      child: Container(
        height: 17.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white, // Add a background color
              ),
              height: 15.h,
              width: 30.w,
              child: ClipRRect(
                // Use ClipRRect to ensure that the curved corners are applied
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                  imageUrl: item.productImage ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline, size: 40),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.listTileTitle,
                  ),
                  Text(
                    'Rs.${item.price.toStringAsFixed(2)}',
                    style: AppStyles.listTilesubTitle,
                  ),
                  Text('${item.customer}', style: AppStyles.listTilesubTitle),
                  Text(
                    '${item.date}',
                    style: AppStyles.listTilesubTitle,
                  ),
                  Text('${item.mealtime}', style: AppStyles.listTilesubTitle),
                  item.holdDate != '' || item.holdDate.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.1.h, horizontal: 2.w),
                            child: Text("Hold:${item.holdDate}",
                                style: AppStyles.listTilesubTitle),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 216, 188, 27),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.1.h, horizontal: 2.w),
                            child: Text(
                              "Regular",
                              style: AppStyles.listTilesubTitle,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
