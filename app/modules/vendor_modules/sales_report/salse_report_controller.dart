import 'package:carousel_slider/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:merocanteen/app/models/order_response.dart';
import 'package:nepali_utils/nepali_utils.dart';

class SalsesReportController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxList<OrderResponse> orderss =
      <OrderResponse>[].obs; // RxList to make it reactive
  RxDouble grandTotal = 0.0.obs; // RxDouble for the grand total

  void calculateGrandTotal() {
    grandTotal.value = 0.0;
    grandTotal.value = orderss.fold<double>(
        0.0, (previousValue, order) => previousValue + order.price);
  }

//--------------fetching the remaning orders---------------------//
  RxMap<String, List<OrderResponse>> salesOrder =
      <String, List<OrderResponse>>{}.obs;
  RxMap<String, int> totalSalesPerOrders = <String, int>{}.obs;

  Future<void> fetchSalesORders(String date) async {
    try {
      isLoading(true);

      QuerySnapshot ordersSnapshot = await _firestore
          .collection('orders')
          .where('date', isEqualTo: date)
          .where('checkout', isEqualTo: 'true')
          .where('orderType', isEqualTo: 'regular')
          .get();

      salesOrder.clear();

      ordersSnapshot.docs.forEach((DocumentSnapshot document) {
        OrderResponse item =
            OrderResponse.fromJson(document.data() as Map<String, dynamic>);

        if (!salesOrder.containsKey(item.productName)) {
          salesOrder[item.productName] = [item];
        } else {
          salesOrder[item.productName]?.add(item);
        }
      });

      calculateRemaningQuantity();
      isLoading(false);
    } catch (e) {
      isLoading(false);

      // Handle errors
      print("Error fetching orders: $e");
    }
  }

  // Calculate total quantity for all products
  void calculateRemaningQuantity() {
    totalSalesPerOrders.clear();
    salesOrder.forEach((productName, productOrders) {
      int totalQuantity = productOrders.fold(
        0,
        (sum, order) => sum + order.quantity,
      );
      totalSalesPerOrders[productName] = totalQuantity;
    });
  }
}
