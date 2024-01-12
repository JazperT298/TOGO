import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class TransacFailedView extends StatelessWidget {
  const TransacFailedView({super.key});

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
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: FluIcon(
                    FluIcons.warning2,
                    color: Colors.red,
                    size: 120,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Échec de l'Opération",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 11.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Désolé, l'opération a échoué. Veuillez réessayer ultérieurement ou contacter le support si le problème persiste",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 11.sp),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(
                  height: 64,
                ),
                FluButton.text(
                  'Réessayer',
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
                  textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                const SizedBox(
                  height: 12,
                ),
                FluButton.text(
                  'Fermer',

                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.toNamed(AppRoutes.BOTTOMNAV);
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
                  textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp, color: context.colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
