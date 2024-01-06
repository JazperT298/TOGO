import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/utils/configs.dart';

class RechargeModalBottomSheet extends StatefulWidget {
  const RechargeModalBottomSheet({super.key});

  @override
  State<RechargeModalBottomSheet> createState() => _RechargeModalBottomSheetState();
}

class _RechargeModalBottomSheetState extends State<RechargeModalBottomSheet> {
  final PageController pageController = PageController();

  void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  @override
  Widget build(BuildContext context) {
    final action = WalletAction.getAll()[0];
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          action.name.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Ma banque en ligne',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Effectuez en toute sécurité des transactions entre Moov Money et vos comptes bancaires affiliés.',
            style: TextStyle(
              fontSize: M3FontSizes.titleSmall,
            ),
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: context.height * .025),
        ),
      ],
    );
    final header1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BANQUES',
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Ecobank',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Opérez en toute sérénité vos transactions entre Moov Money et votre compte Ecobank Moov Money vers Ecobank',
            style: TextStyle(
              fontSize: M3FontSizes.titleSmall,
            ),
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: context.height * .025),
        ),
      ],
    );
    final header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          action.name.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Vous êtes entrain de recharger votre compte ',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: ' Ecobank',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
              TextSpan(
                text: ' via',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
              TextSpan(
                text: ' Moov Money',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: context.height * .025),
        ),
      ],
    );
    final header3 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Vous allez \nRecharger votre \ncompte '.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
              TextSpan(
                text: 'Ecobank de '.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: '\n50 000 FCFA'.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Frais de L’operation : '.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineTiny,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: '150 FCFA'.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineTiny,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: context.height * .025),
        ),
      ],
    );
    final page1 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: action.children.length,
              itemBuilder: (context, index) {
                final option = action.children[index];

                return FluButton(
                  onPressed: toNextStep,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  child: Row(
                    children: [
                      FluArc(
                        startOfArc: 90,
                        angle: 80,
                        strokeWidth: 1,
                        color: context.colorScheme.primaryContainer,
                        child: Container(
                            height: context.width * .15,
                            width: context.width * .15,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: FluIcon(option.icon, color: Colors.black)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.name,
                                style:
                                    TextStyle(fontSize: M3FontSizes.headlineTiny, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                              ),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.headlineTiny,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FluIcon(
                        FluIcons.arrowRight1,
                        size: 16,
                        color: context.colorScheme.onBackground,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
    final page2 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header1,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: action.children.length,
              itemBuilder: (context, index) {
                final option = action.children[index];

                return FluButton(
                  onPressed: toNextStep,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  child: Row(
                    children: [
                      FluArc(
                        startOfArc: 90,
                        angle: 80,
                        strokeWidth: 1,
                        color: context.colorScheme.primaryContainer,
                        child: Container(
                            height: context.width * .15,
                            width: context.width * .15,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: FluIcon(option.icon, color: Colors.black)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.name,
                                style:
                                    TextStyle(fontSize: M3FontSizes.headlineTiny, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                              ),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.headlineTiny,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FluIcon(
                        FluIcons.arrowRight1,
                        size: 16,
                        color: context.colorScheme.onBackground,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
    final page3 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header2,
            const SizedBox(height: 24),
            FluTextField(
              hint: "Montant à envoyer",
              height: 50,
              cornerRadius: 15,
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
              textStyle: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                'Continuer',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: toNextStep,
                height: 55,
                width: context.width * 16,
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
            ),
            const SizedBox(height: 30),
          ],
        );
      }),
    );
    final page4 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header3,
            const SizedBox(height: 24),
            FluTextField(
              hint: "Votre code secret",
              height: 50,
              cornerRadius: 15,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
              textStyle: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                'Valider',
                suffixIcon: FluIcons.checkCircleUnicon,
                iconStrokeWidth: 1.8,
                // onPressed: () => KRouter.to(context, Routes.transactionComplete),
                height: 55,
                width: context.width * 16,
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
            ),
            const SizedBox(height: 30),
          ],
        );
      }),
    );
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [page1, page2, page3, page4],
    );
  }
}
