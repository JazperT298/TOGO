import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class WithdrawalProgressView extends StatelessWidget {
  const WithdrawalProgressView({super.key});

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
                const Spacer(),

                // Expanded(
                //   child:
                Image.asset(
                  AppImages.progressLoading,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.height * .3,
                ),
                // ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Operation in progress \nplease wait', //    'Opération effectuer avec succèss',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'The operation is currently being processed. In a few seconds you will receive the code to be able to make your ATM withdrawal. Thanks for your patience.', //    "L'opération a été confirmée avec succès. Vous pouvez consulter les détails dans l'historique des transactions.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                // const SizedBox(
                //   height: 64,
                // ),
                const Spacer(),
                FluButton.text(
                  'Close', //  'Fermer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.back();
                    // controller.code.clear();
                    // Get.toNamed(AppRoutes.BOTTOMNAV);
                  },
                  height: 5.8.h,
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
