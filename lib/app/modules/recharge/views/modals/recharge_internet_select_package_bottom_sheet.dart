import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                SizedBox(height: 2.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    "Internet package".toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFB6404),
                        fontSize: 13.sp),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Obx(
                    () => controller.selectedOption.value == "For myself"
                        ? Text(
                            "Please select a package.",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 19.sp),
                          )
                        : Text(
                            "Please select a package.",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 19.sp),
                          ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FluTextField(
                    inputController: controller.amountTextField,
                    hint: "Package name", // "Enter amount",
                    hintStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF27303F),
                        fontSize: 13.sp),
                    textStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 13.sp),
                    height: 6.5.h,
                    cornerRadius: 15,
                    // keyboardType: TextInputType.number,
                    fillColor: const Color(0xFFf4f5fa),
                    suffixIcon: FluIcons.refresh,
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 3.h),
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
                SizedBox(height: 3.h),
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
                            padding: EdgeInsets.only(
                                top: 1.5.h,
                                bottom: 1.5.h,
                                left: 3.w,
                                right: 3.w),
                            decoration: BoxDecoration(
                              color:
                                  controller.internetProductType.value == "All"
                                      ? const Color(0xFFB6C8F7)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              "All",
                              style: GoogleFonts.montserrat(
                                  fontWeight:
                                      controller.internetProductType.value ==
                                              "All"
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: 12.sp),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Eco";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.only(
                                top: 1.5.h,
                                bottom: 1.5.h,
                                left: 3.w,
                                right: 3.w),
                            decoration: BoxDecoration(
                              color:
                                  controller.internetProductType.value == "Eco"
                                      ? const Color(0xFFB6C8F7)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              "Eco",
                              style: GoogleFonts.montserrat(
                                  fontWeight:
                                      controller.internetProductType.value ==
                                              "Eco"
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: 12.sp),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Intense";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.only(
                                top: 1.5.h,
                                bottom: 1.5.h,
                                left: 3.w,
                                right: 3.w),
                            decoration: BoxDecoration(
                              color: controller.internetProductType.value ==
                                      "Intense"
                                  ? const Color(0xFFB6C8F7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              "Intense",
                              style: GoogleFonts.montserrat(
                                  fontWeight:
                                      controller.internetProductType.value ==
                                              "Intense"
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: 12.sp),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      InkWell(
                        onTap: () {
                          controller.internetProductType.value = "Nights";
                          controller.changeInternetProductType();
                        },
                        child: Obx(
                          () => Container(
                            padding: EdgeInsets.only(
                                top: 1.5.h,
                                bottom: 1.5.h,
                                left: 3.w,
                                right: 3.w),
                            decoration: BoxDecoration(
                              color: controller.internetProductType.value ==
                                      "Nights"
                                  ? const Color(0xFFB6C8F7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: Text(
                              "Nights",
                              style: GoogleFonts.montserrat(
                                  fontWeight:
                                      controller.internetProductType.value ==
                                              "Nights"
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: 12.sp),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
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
                            child: Obx(
                              () => Container(
                                height: 8.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: controller
                                              .internetRadioGroupValue.value ==
                                          controller
                                              .productsList[index].productid
                                      ? const Color(0xFFFEE8D9)
                                      : const Color(0xFFe7edfc),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 1.w),
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
                                          SizedBox(
                                            width: 70.w,
                                            child: Text(
                                              controller
                                                  .textSplitterPackageName(
                                                      text: controller
                                                          .productsList[index]
                                                          .description),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF27303F),
                                                  fontSize: 21.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70.w,
                                            child: Text(
                                              "${controller.productsList[index].price} FCFA - ${controller.textSplitterPrice(text: controller.productsList[index].description)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFF687997),
                                                  fontSize: 12.sp),
                                            ),
                                          ),
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
                                                  controller
                                                      .productsList[index];
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: FluButton.text(
                    'Confirm',
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
                    height: 7.h,
                    width: 100.w,
                    cornerRadius: UISettings.minButtonCornerRadius,
                    backgroundColor: const Color(0xFF124DE5),
                    foregroundColor: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: Offset(0, 5),
                      )
                    ],
                    textStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF4F5FA),
                        fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }
}
