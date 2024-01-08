import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/sendmoney/views/dialog/send_menu_dialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';

class TransacCompleteView extends StatelessWidget {
  const TransacCompleteView({super.key});

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
                    FluIcons.checkCircleUnicon,
                    color: Colors.green,
                    size: 120,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Opération effectuer avec succèss',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: M3FontSizes.headlineLarge),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "L'opération a été confirmée avec succès. Vous pouvez consulter les détails dans l'historique des transactions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: M3FontSizes.headlineTiny),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    SendMenuDialog.showRecapOperationDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Voir le récap',
                      style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: M3FontSizes.headlineTiny),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                FluButton.text(
                  'Fermer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.toNamed(AppRoutes.HOME);
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
