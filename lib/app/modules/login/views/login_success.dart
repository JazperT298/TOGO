// ignore_for_file: prefer_const_constructors

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key});

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  bool showProgressIndicator = true;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showProgressIndicator = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                showProgressIndicator
                    ? const CircularProgressIndicator(
                        strokeWidth: 6,
                        color: Colors.green,
                      )
                    : FluIcon(
                        FluIcons.checkCircleUnicon,
                        color: Colors.green,
                        size: 48,
                      ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Vouz avez configurer votre comtre avec succes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: M3FontSizes.headlineLarge),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                FluButton.text(
                  'Fermer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.toNamed(AppRoutes.BOTTOMNAV);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
