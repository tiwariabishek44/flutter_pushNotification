import 'package:merocanteen/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merocanteen/app/config/style.dart';
import 'package:merocanteen/app/widget/customized_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmationDialog extends StatelessWidget {
  final String heading;
  final String subheading;
  final String firstbutton;
  final String secondbutton;
  final VoidCallback onConfirm;
  final bool isbutton;

  const ConfirmationDialog(
      {required this.heading,
      required this.subheading,
      required this.isbutton,
      required this.firstbutton,
      required this.secondbutton,
      required this.onConfirm,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0.h),
                child: Column(
                  children: [
                    Text(heading,
                        style: TextStyle(
                            fontSize: 27.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            subheading,
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 119, 116, 116)),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isbutton
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            text: firstbutton,
                            onPressed: onConfirm,
                            isLoading: false),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 5.5.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 235, 235),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              secondbutton,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        )
                      ],
                    )
                  : Container(),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
