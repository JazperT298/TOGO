import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentServiceLinksBottomSheet {
  static void showBottomSheetCeetServicePackageTo() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 60.h : 70.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'
                              .toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: 13.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Select an Invoice",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 19.sp),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Which of your references would you like to pay for today?",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: FluTextField(
                        hint: "Reference name or number",
                        height: 6.5.h,
                        cornerRadius: 15,
                        keyboardType: TextInputType.name,
                        fillColor: const Color(0xFFF4F5FA),
                        hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF27303F),
                            fontSize: 12.sp),
                        textStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12.sp),
                        suffixIcon: FluIcons.refresh,
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
                    SizedBox(height: 1.h),
                    SizedBox(
                      height: 27.h,
                      width: 100.w,
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.ceetDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 1.h),
                              child: GestureDetector(
                                onTap: () {
                                  controller.ceetPackageRadioGroupValue.value =
                                      controller.ceetDataList[index].reference;
                                  controller.selectDatum =
                                      controller.ceetDataList[index];
                                },
                                child: Obx(
                                  () => Container(
                                    height: 8.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: controller
                                                  .ceetPackageRadioGroupValue
                                                  .value ==
                                              controller
                                                  .ceetDataList[index].reference
                                          ? const Color(0xFFFEE8D9)
                                          : const Color(0xFFe7edfc),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 1.w),
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
                                                controller.ceetDataList[index]
                                                    .reference,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFF27303F),
                                                    fontSize: 13.sp),
                                              ),
                                              Text(
                                                controller.ceetDataList[index]
                                                    .reference,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF687997),
                                                    fontSize: 13.sp),
                                              ),
                                            ],
                                          ),
                                          Obx(
                                            () => Radio(
                                                value: controller
                                                    .ceetDataList[index]
                                                    .reference,
                                                groupValue: controller
                                                    .ceetPackageRadioGroupValue
                                                    .value,
                                                onChanged: (value) {
                                                  controller
                                                          .ceetPackageRadioGroupValue
                                                          .value =
                                                      controller
                                                          .ceetDataList[index]
                                                          .reference;
                                                  controller.selectDatum =
                                                      controller
                                                          .ceetDataList[index];
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
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          'Continue',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.selectDatum != null) {
                              Get.back();
                              // PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
                              controller.verifyCeetRefIDfromInput(
                                  refId: controller
                                      .ceetPackageRadioGroupValue.value);
                              controller.ceetPackageRadioGroupValue.value = '';
                            } else {
                              Get.snackbar("Message", "Please select a service",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          },
                          height: 7.h,
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
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      isScrollControlled: true,
    );
  }
}
