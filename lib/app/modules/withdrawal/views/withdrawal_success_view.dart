import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/app/modules/withdrawal/dialog/withdrawal_dialog.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class WithdrawalSuccessView extends GetView<WithdrawalController> {
  const WithdrawalSuccessView({super.key});

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
                  AppImages.transacSuccess,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.height * .3,
                ),
                // ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Operation completed \nsuccessfully', //    'Opération effectuer avec succèss',
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
                      'The operation was carried out successfully. You can view the details in the transaction history.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    WithdrawalDialog.showRecapOperationDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'See the recap', // 'Voir le récap',
                      style: GoogleFonts.montserrat(
                          color: const Color(0xFF124DE5), decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 64,
                // ),
                const Spacer(),
                FluButton.text(
                  'Close', //  'Fermer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    controller.code.clear();
                    Get.back();
                    Get.back();
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
