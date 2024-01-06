// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/transfer/controller/transfer_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';

enum TransferConfirmationType {
  subscription,
  sent,
  withdraw,
}

class TransferConfirmation extends StatelessWidget {
  const TransferConfirmation({super.key, this.type = TransferConfirmationType.sent});

  final TransferConfirmationType type;

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
          padding: UISettings.pagePadding.copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FluButton.icon(
                    FluIcons.arrowLeft,
                    size: UISettings.minButtonSize,
                    cornerRadius: UISettings.minButtonCornerRadius,
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Spacer(),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text:
                          ('Vous allez ${type == TransferConfirmationType.withdraw ? 'retiré' : (type == TransferConfirmationType.subscription) ? 'payé' : 'envoyé'}')
                              .toUpperCase()),
                  TextSpan(text: ' 15000 FCFA'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w600, color: context.colorScheme.primary)),
                  TextSpan(text: (type == TransferConfirmationType.withdraw ? ' auprès de ' : ' à ').toUpperCase()),
                  TextSpan(
                      text: (type == TransferConfirmationType.subscription
                              ? 'canalBox'
                              : type == TransferConfirmationType.withdraw
                                  ? 'l\'agence K'
                                  : 'Loic')
                          .toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w600, color: context.colorScheme.onSurface)),
                  if (type == TransferConfirmationType.subscription) TextSpan(text: ' pour renouveler votre abonnement.'.toUpperCase()),
                ]),
                style: TextStyle(
                  fontSize: M3FontSizes.displaySmall,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 5),
              Text.rich(TextSpan(children: [
                TextSpan(text: "Frais de transfert: ".toUpperCase()),
                TextSpan(text: "0 FCFA", style: TextStyle(fontWeight: FontWeight.w600, color: context.colorScheme.secondary)),
              ])),
              FluLine(
                height: 1,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
              ),
              Text(
                'Entrez votre code pin pour comfirmer'.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              FluTextField(
                hint: "Votre code PIN",
                height: UISettings.buttonSize + 5,
                fillColor: context.colorScheme.primaryContainer,
                textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium), // context.textTheme.bodyMedium,
                cornerRadius: UISettings.buttonCornerRadius,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .035, bottom: 10),
              ),
              FluButton(
                onPressed: () => Get.toNamed(AppRoutes.BOTTOMNAV),
                height: UISettings.buttonSize + 10,
                cornerRadius: UISettings.buttonCornerRadius,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                child: Row(
                  children: [
                    const Text(
                      'Continuer',
                      style: TextStyle(
                        fontSize: M3FontSizes.bodyLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    FluIcon(
                      FluIcons.arrowRight,
                      color: context.colorScheme.onPrimary,
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
