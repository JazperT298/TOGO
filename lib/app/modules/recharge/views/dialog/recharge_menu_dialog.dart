import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:sizer/sizer.dart';

import '../modals/recharge_credit_input_amount_bottom_sheet.dart';
import '../modals/recharge_credit_input_number_bottom_sheet.dart';

class RechargeMenuDialog {
  static void showRechargeMenuDialog({required BuildContext context}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
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
                    showCreditSelectOption(context: context);
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
        );
      },
    );
  }

  static void showCreditSelectOption({required BuildContext context}) {
    // flutter defined function
    var controller = Get.find<RechargeController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
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
                    RechargeCreditInputAmountBottomSheet
                        .showBottomSheetInputAmount();
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
                    RechargeCreditInputNumberBottomSheet
                        .showBottomSheetInputNumber();
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
        );
      },
    );
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
