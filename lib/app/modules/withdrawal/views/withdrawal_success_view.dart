import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';

class WithdrawalSuccessView extends GetView<WithdrawalController> {
  const WithdrawalSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => controller.getBack(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: UISettings.pagePadding,
                  child: Text(
                    LocaleKeys.strWalletWithdrawalDesc.tr, //  "RETRAIT",
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: UISettings.pagePadding,
                  child: Text(
                    LocaleKeys.strYouWithdraw.tr, //  "Vous retirez",
                    style: const TextStyle(
                      fontSize: M3FontSizes.headlineLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding,
                  child: Obx(
                    () => Text(
                      controller.withdrawalAmountWithUnit.value,
                      style: const TextStyle(fontSize: M3FontSizes.headlineLarge, color: Colors.orange),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding,
                  child: Obx(
                    () => Text(
                      "${LocaleKeys.strAtTheHouse.tr} ${controller.nickname.value}",
                      style: const TextStyle(
                        fontSize: M3FontSizes.headlineLarge,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: UISettings.pagePadding,
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.strOperationCoses.tr,
                          //"Frais de l'operation: ",
                          style: const TextStyle(
                            fontSize: M3FontSizes.bodyLarge,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.fees.value,
                            style: const TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.orange),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: UISettings.pagePadding,
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.strTaf.tr,
                          style: const TextStyle(
                            fontSize: M3FontSizes.bodyLarge,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.taf.value,
                            style: const TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.orange),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: UISettings.pagePadding,
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.strNewFloozBalance.tr, //   "Nouveau solde Flooz: ",
                          style: const TextStyle(
                            fontSize: M3FontSizes.bodyLarge,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.balance.value,
                            style: const TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.orange),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.57,
                ),
                Padding(
                  padding: UISettings.pagePadding,
                  child: FluButton.text(
                    LocaleKeys.strContinue.tr, //   'Continuer',
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
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
