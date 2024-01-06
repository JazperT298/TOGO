import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/logo.dart';
import 'package:ibank/app/modules/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
          statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: context.colorScheme.primary),
      background: context.colorScheme.primary,
      body: SizedBox.expand(
        child: Column(
          children: [
            const Spacer(),
            FluLoader(
                size: 25,
                strokeWidth: 2,
                color: context.colorScheme.onPrimary,
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1)),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .15),
              child: Logo(color: context.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
