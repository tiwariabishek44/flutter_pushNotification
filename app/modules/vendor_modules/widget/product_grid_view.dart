import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/modules/user_module/home/product_controller.dart';
import 'package:merocanteen/app/modules/vendor_modules/menue/view/price_update.dart';

// Define the reusable product grid widget
class VendorProductGrid extends StatelessWidget {
  VendorProductGrid({
    Key? key,
  }) : super(key: key);

  // State to maintain quantities of each product
  final productContorller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 20.0, // spacing between rows
          crossAxisSpacing: 20.0, // spacing between columns
          childAspectRatio: 0.72),
      itemCount: productContorller
          .allProductResponse.value.response!.length, // total number of items
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.lightColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 6,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SpinKitFadingCircle(
                      color: AppColors.secondaryColor,
                    ),
                    imageUrl: productContorller
                            .allProductResponse.value.response![index].image ??
                        '',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline, size: 40),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${productContorller.allProductResponse.value.response![index].name}",
                              style: AppStyles.listTileTitle),
                          Text(
                              "Rs ${productContorller.allProductResponse.value.response![index].price.toInt()}/plate",
                              style: AppStyles.listTilesubTitle),
                        ]),
                  ))
            ]),
          ),
        );
      },
    );
  }
}
