import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:sizer/sizer.dart';
import '../modals/recharge_credit_input_amount_bottom_sheet.dart';
import '../modals/recharge_credit_input_number_bottom_sheet.dart';
import '../modals/recharge_internet_select_package_bottom_sheet.dart';

class RechargeMenuDialog {
  static void showRechargeMenuDialogs() {
    // flutter defined function
    Get.dialog(AlertDialog(
      title: const Text('Credit transfer'),
      content: SizedBox(
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text('Transfert National'),
            GestureDetector(
              onTap: () {
                Get.back();
                showCreditSelectOption();
                // Get.toNamed(AppRoutes.RECHARGE, arguments: {
                //   "screens": "credit",
                // });
              },
              child: const SizedBox(
                height: 20,
                child: Text('Credit'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                showForfaitsSelectInternetOrVoice();
                // Get.toNamed(AppRoutes.RECHARGE, arguments: {
                //   "screens": "internet",
                // });
              },
              child: const SizedBox(
                height: 20,
                child: Text('Internet'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ));
  }

  static void showCreditSelectOption() {
    // flutter defined function
    var controller = Get.find<RechargeController>();
    Get.dialog(AlertDialog(
      title: const Text('Select Options'),
      content: SizedBox(
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Get.back();
                controller.amountTextField.clear();
                controller.code.clear();
                controller.numberTextField.clear();
                controller.selectedOption.value = 'For myself';
                RechargeCreditInputAmountBottomSheet.showBottomSheetInputAmount(selectedMenu: "OWN");
                // Get.toNamed(AppRoutes.RECHARGE, arguments: {
                //   "screens": "credit",
                // });
              },
              child: const SizedBox(
                height: 20,
                child: Text('For Myself'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                controller.amountTextField.clear();
                controller.code.clear();
                controller.numberTextField.clear();
                controller.selectedOption.value = 'For others';
                RechargeCreditInputNumberBottomSheet.showBottomSheetInputNumber();
                // Get.toNamed(AppRoutes.RECHARGE, arguments: {
                //   "screens": "internet",
                // });
              },
              child: const SizedBox(
                height: 20,
                child: Text('For Others'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ));
  }

  static void showForfaitsSelectInternetOrVoice() {
    // flutter defined function
    var controller = Get.find<RechargeController>();
    Get.dialog(AlertDialog(
      title: const Text('Select Options'),
      content: SizedBox(
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                Get.back();
                controller.internetNumberCode.value = "400";
                await controller.internetGetProducts();
                showForfaitsInternetSelectOption();
              },
              child: const SizedBox(
                height: 20,
                child: Text('Internet'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                Get.back();
                controller.internetNumberCode.value = "555";
                await controller.internetGetProducts();
                showForfaitsInternetSelectOption();
              },
              child: const SizedBox(
                height: 20,
                child: Text('Voice'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ));
  }

  static void showForfaitsInternetSelectOption() {
    // flutter defined function
    var controller = Get.find<RechargeController>();
    Get.dialog(AlertDialog(
      title: const Text('Select Options'),
      content: SizedBox(
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                Get.back();
                controller.amountTextField.clear();
                controller.code.clear();
                controller.numberTextField.clear();
                controller.selectedOption.value = 'For myself';

                RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackageAmount();
              },
              child: const SizedBox(
                height: 20,
                child: Text('For Myself'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                controller.amountTextField.clear();
                controller.code.clear();
                controller.numberTextField.clear();
                controller.selectedOption.value = 'For others';
                RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackageAmount();
              },
              child: const SizedBox(
                height: 20,
                child: Text('For Others'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ));
  }

  static showMessageDialog({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        )));
  }
}
