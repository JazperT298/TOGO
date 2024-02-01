// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class TransacFailedView extends GetView<SendMoneyController> {
  const TransacFailedView({super.key});

  @override
  Widget build(BuildContext context) {
    // var jsonString = Get.arguments['jsonString'];
    // Map<String, dynamic> response = json.decode(jsonString);
    // String message = response["message"];

    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Expanded(
                  child: Image.asset(
                    AppImages.transacFailed,
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.height * .3,
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Operation Failed', //    "Échec de l'Opération",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        controller.responsemessage.value.isEmpty
                            ? 'Sorry, the operation failed. Please try again later or contact support if the problem persists'
                            : controller.responsemessage
                                .value, //     "Désolé, l'opération a échoué. Veuillez réessayer ultérieurement ou contacter le support si le problème persiste",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                FluButton.text(
                  'Try again', //   'Réessayer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.back();
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
                  textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                FluButton.text(
                  'Close', //   'Fermer',

                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    controller.numberController.clear();
                    controller.amountController.clear();
                    // Get.toNamed(AppRoutes.BOTTOMNAV);
                    Get.back();
                    Get.back();
                  },
                  height: 5.8.h,

                  width: MediaQuery.of(context).size.width * 16,
                  cornerRadius: UISettings.minButtonCornerRadius,
                  border: BorderSide(color: context.colorScheme.primary),
                  // backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(.35),
                      blurRadius: 25,
                      spreadRadius: 3,
                      offset: const Offset(0, 5),
                    )
                  ],
                  textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: context.colorScheme.primary),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
