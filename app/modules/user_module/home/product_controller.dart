import 'dart:developer';

import 'package:get/get.dart';
import 'package:merocanteen/app/models/product_model.dart';
import 'package:merocanteen/app/repository/all_product_respository.dart';
import 'package:merocanteen/app/service/api_client.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  final AllProductRepository allProductRepository = AllProductRepository();
  final Rx<ApiResponse<Product>> allProductResponse =
      ApiResponse<Product>.initial().obs;
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      allProductResponse.value = ApiResponse<Product>.loading();
      final allProductResult = await allProductRepository.getallproducts();
      if (allProductResult.status == ApiStatus.SUCCESS) {
        allProductResponse.value =
            ApiResponse<Product>.completed(allProductResult.response);

        log("this is the all product response" +
            allProductResponse.value.response!.length.toString());
      }
    } catch (e) {
      isLoading(false);

      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }
}
