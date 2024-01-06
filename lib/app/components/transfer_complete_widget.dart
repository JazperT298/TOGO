// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/transfer/controller/transfer_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';

class TransactionConplete extends StatelessWidget {
  const TransactionConplete({super.key});

  void onFermerTap(BuildContext context) {
    Get.toNamed(AppRoutes.BOTTOMNAV);
  }

  @override
  Widget build(BuildContext context) {
    TransferController controller = Get.find();
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Padding(
          padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(color: Colors.green, strokeWidth: 12),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'Vous avez configurer \nvotre compte avec \nsucces',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 35),
              FluButton.text(
                'Fermer',
                iconStrokeWidth: 1.8,
                onPressed: () => onFermerTap(context),
                height: 55,
                width: MediaQuery.of(context).size.width * .70,
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
            ],
          ),
        ),
      ),
    );
  }
}
