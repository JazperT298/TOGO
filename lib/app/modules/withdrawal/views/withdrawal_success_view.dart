import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/utils/configs.dart';

class WithdrawalSuccessView extends GetView<WithdrawalController> {
  const WithdrawalSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: UISettings.pagePadding,
                child: Text(
                  "RETRAIT",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: UISettings.pagePadding,
                child: Text(
                  "Vous retirez",
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineLarge,
                  ),
                ),
              ),
              Padding(
                padding: UISettings.pagePadding,
                child: Obx(
                  () => Text(
                    controller.withdrawalAmountWithUnit.value,
                    style: const TextStyle(
                        fontSize: M3FontSizes.headlineLarge,
                        color: Colors.orange),
                  ),
                ),
              ),
              const Padding(
                padding: UISettings.pagePadding,
                child: Text(
                  "Chez Etz Alibaba",
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineLarge,
                  ),
                ),
              ),
              Padding(
                  padding: UISettings.pagePadding,
                  child: Row(
                    children: [
                      const Text(
                        "Frais de l'operation: ",
                        style: TextStyle(
                          fontSize: M3FontSizes.bodyLarge,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.fees.value,
                          style: const TextStyle(
                              fontSize: M3FontSizes.bodyLarge,
                              color: Colors.orange),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.62,
              ),
              Padding(
                padding: UISettings.pagePadding,
                child: FluButton.text(
                  'Continuer',
                  suffixIcon: FluIcons.arrowRight,
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.back();
                    Get.back();
                    Get.back();
                    // Get.toNamed(AppRoutes.WITHDRAWALOTP);
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
      ),
    );
  }
}
