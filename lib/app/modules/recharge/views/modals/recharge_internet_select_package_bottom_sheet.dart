import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';
import 'recharge_internet_otp_bottom_sheet.dart';

class RechargeInternetSelectPackageBottomSheet {
  static void showBottomSheetSelectPackage() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
        Container(
          height: 80.h,
          width: 100.w,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    "INTERNET".toUpperCase(),
                    style: TextStyle(
                      color: Colors.orange[500],
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Obx(
                    () => controller.selectedOption.value == "For myself"
                        ? Text(
                            "Please select a package.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            "Please select a package.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FluTextField(
                    inputController: controller.amountTextField,
                    hint: "Package name", // "Enter amount",
                    hintStyle: TextStyle(fontSize: 11.sp),
                    textStyle: TextStyle(fontSize: 11.sp),
                    height: 50,
                    cornerRadius: 15,
                    // keyboardType: TextInputType.number,
                    fillColor: const Color(0xFFf4f5fa),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    FluLine(
                      width: 30.w,
                      color: const Color(0xFFfb6708),
                    ),
                    CircleAvatar(
                      radius: 1.w,
                      backgroundColor: const Color(0xFFfb6708),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "All";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            height: 8.h,
                            width: 13.w,
                            decoration: BoxDecoration(
                              color:
                                  controller.internetProductType.value == "All"
                                      ? const Color(0xFFe7edfc)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(child: Text("All")),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Eco";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            height: 8.h,
                            width: 13.w,
                            decoration: BoxDecoration(
                              color:
                                  controller.internetProductType.value == "Eco"
                                      ? const Color(0xFFe7edfc)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(child: Text("Eco")),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Intense";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            height: 8.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: controller.internetProductType.value ==
                                      "Intense"
                                  ? const Color(0xFFe7edfc)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(child: Text("Intense")),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Nights";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            height: 8.h,
                            width: 18.w,
                            decoration: BoxDecoration(
                              color: controller.internetProductType.value ==
                                      "Nights"
                                  ? const Color(0xFFe7edfc)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(child: Text("Nights")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 35.h,
                  width: 100.w,
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.productsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                          child: GestureDetector(
                            onTap: () {
                              controller.internetRadioGroupValue.value =
                                  controller.productsList[index].productid;
                              controller.selectedProduct =
                                  controller.productsList[index];
                            },
                            child: Container(
                              height: 8.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFe7edfc),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.textSplitterPackageName(
                                              text: controller
                                                  .productsList[index]
                                                  .description),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                            "${controller.productsList[index].price} FCFA - ${controller.textSplitterPrice(text: controller.productsList[index].description)}"),
                                      ],
                                    ),
                                    Obx(
                                      () => Radio(
                                          value: controller
                                              .productsList[index].productid,
                                          groupValue: controller
                                              .internetRadioGroupValue.value,
                                          onChanged: (value) {
                                            controller.internetRadioGroupValue
                                                    .value =
                                                controller.productsList[index]
                                                    .productid;
                                            controller.selectedProduct =
                                                controller.productsList[index];
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: FluButton.text(
                    'Continuer',
                    suffixIcon: FluIcons.passwordCheck,
                    iconStrokeWidth: 1.8,
                    onPressed: () {
                      if (controller.selectedProduct != null) {
                        Get.back();
                        RechargeInternetOTPBottomSheet.showBottomSheetOTP();
                      } else {
                        Get.snackbar("Message", "Please select a product",
                            backgroundColor: Colors.lightBlue,
                            colorText: Colors.white);
                      }
                    },
                    height: 55,
                    width: 100.w,
                    cornerRadius: UISettings.minButtonCornerRadius,
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: Offset(0, 5),
                      )
                    ],
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: M3FontSizes.bodyLarge),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }
}
