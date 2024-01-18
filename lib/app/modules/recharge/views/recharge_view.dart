import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/recharge/views/recharge_credit_view.dart';
import 'package:ibank/app/modules/recharge/views/recharge_internet_view.dart';
import 'package:sizer/sizer.dart';

class RechargeView extends GetView<RechargeController> {
  const RechargeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(RechargeController());
    return Scaffold(
        body: SafeArea(
      child: Obx(() => controller.screen.value == 'credit'
          ? const RechargeCreditView()
          : controller.screen.value == 'internet'
              ? const RechargeInternetView()
              : SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    ));
  }
}
