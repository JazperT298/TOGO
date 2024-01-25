import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_enter_otp_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentServiceLinksBottomSheet {
  static void showBottomSheetCeetServicePackageTo() {
    final controller = Get.put(PaymentController());

    Get.bottomSheet(Container(
      height: 70.h,
      width: 100.w,
      decoration:
          const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Obx(
                () => Text(
                  'Payment ${controller.selectedOption.value}'.toUpperCase(),
                  style: TextStyle(
                    color: const Color(0xFFfb6708),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    letterSpacing: 1.0,
                  ),
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
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Which of your references would you like to pay for today?",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: FluTextField(
                hint: "Reference name or number",
                height: 50,
                cornerRadius: 15,
                keyboardType: TextInputType.name,
                fillColor: Get.context!.colorScheme.primaryContainer,
                hintStyle: const TextStyle(fontSize: M3FontSizes.titleSmall),
                textStyle: const TextStyle(fontSize: M3FontSizes.titleSmall),
                suffixIcon: FluIcons.refresh,
              ),
            ),
            SizedBox(
              height: 3.h,
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
              height: 1.h,
            ),
            SizedBox(
              height: 27.h,
              width: 100.w,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.ceetDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                      child: GestureDetector(
                        onTap: () {
                          controller.ceetPackageRadioGroupValue.value = controller.ceetDataList[index].reference;
                          controller.selectDatum = controller.ceetDataList[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.ceetDataList[index].reference,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(controller.ceetDataList[index].reference),
                                  ],
                                ),
                                Obx(
                                  () => Radio(
                                      value: controller.ceetDataList[index].reference,
                                      groupValue: controller.ceetPackageRadioGroupValue.value,
                                      onChanged: (value) {
                                        controller.ceetPackageRadioGroupValue.value = controller.ceetDataList[index].reference;
                                        controller.selectDatum = controller.ceetDataList[index];
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
                'Continue',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (controller.selectDatum != null) {
                    Get.back();
                    PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
                  } else {
                    Get.snackbar("Message", "Please select a service", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    ));
  }
}
