import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/logo.dart';
import 'package:ibank/app/modules/splash/controller/splash_controller.dart';
import 'package:ibank/utils/constants/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle
          .copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: AppColors.primaryColor),
      background: AppColors.primaryColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            const Spacer(),
            FluLoader(size: 25, strokeWidth: 2, color: Colors.white, margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1)),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .15),
              child: const Logo(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
