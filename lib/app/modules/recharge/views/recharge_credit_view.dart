import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeCreditView extends GetView<RechargeController> {
  const RechargeCreditView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 175, 221, 243)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
                    onPressed: () {
                      Get.back();
                    },
                    child: const FluIcon(
                      FluIcons.arrowLeft,
                      size: 30,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Select option",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.selectedOption.value = 'For myself';
                      },
                      child: SizedBox(
                          height: 10.h,
                          width: 35.w,
                          child: const Center(child: Text("For myself")))),
                  ElevatedButton(
                      onPressed: () {
                        controller.selectedOption.value = 'For others';
                      },
                      child: SizedBox(
                          height: 10.h,
                          width: 35.w,
                          child: const Center(child: Text("For others"))))
                ],
              ),
            ),
            Obx(
              () => SizedBox(
                height:
                    controller.selectedOption.value == "For others" ? 4.h : 2.h,
              ),
            ),
            Obx(
              () => controller.selectedOption.value == "For others"
                  ? Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: controller.numberTextField,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter number",
                          fillColor: const Color.fromARGB(255, 175, 221, 243),
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(Get.context!).size.width *
                                  0.03),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => controller.selectedOption.value == "For others" ||
                      controller.selectedOption.value == "For myself"
                  ? Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: controller.amountTextField,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter amount",
                          fillColor: const Color.fromARGB(255, 175, 221, 243),
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(Get.context!).size.width *
                                  0.03),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => SizedBox(
                height: controller.selectedOption.value == "For others"
                    ? 37.h
                    : controller.selectedOption.value == "For myself"
                        ? 46.h
                        : 53.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: FluButton.text(
                'Continuer',
                suffixIcon: FluIcons.passwordCheck,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (controller.selectedOption.value == "For myself") {
                    if (controller.amountTextField.text.isNotEmpty) {
                      Get.toNamed(AppRoutes.RECHARGEOTP);
                    } else {
                      Get.snackbar("Message", "Montant invalide",
                          backgroundColor: Colors.lightBlue,
                          colorText: Colors.white);
                    }
                  } else if (controller.selectedOption.value == "For others") {
                    if (controller.amountTextField.text.isEmpty ||
                        controller.numberTextField.text.isEmpty) {
                      Get.snackbar("Message", "Montant invalide",
                          backgroundColor: Colors.lightBlue,
                          colorText: Colors.white);
                    } else {
                      Get.toNamed(AppRoutes.RECHARGEOTP);
                    }
                  } else {
                    Get.snackbar("Message", "veuillez sélectionner une option",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  }
                },
                height: 55,
                width: MediaQuery.of(context).size.width * 16,
                cornerRadius: UISettings.minButtonCornerRadius,
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary.withOpacity(.35),
                    blurRadius: 25,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  )
                ],
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
