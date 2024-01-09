// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/utils/configs.dart';

class PaiementModalBottomSheet extends StatefulWidget {
  const PaiementModalBottomSheet({super.key});

  @override
  State<PaiementModalBottomSheet> createState() =>
      _PaiementModalBottomSheetState();
}

class _PaiementModalBottomSheetState extends State<PaiementModalBottomSheet> {
  final PageController pageController = PageController();

  void toNextStep() => pageController.nextPage(
      duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  @override
  Widget build(BuildContext context) {
    final action = WalletAction.getAll()[2];

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
          'Facile et Pratique',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Sélectionnez les services à régler et simplifiez votre vie financière en quelques clics.',
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
          action.name.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Chaines Télés',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Sélectionnez votre fournisseur TV et payez le bouquet qui reflète vos envies en quelques secondes.',
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
        Text(
          'Sélectionnez ou ajoutez une nouvelle carte.',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
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
        Text(
          action.name.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Abonnement Canal +',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text:
                    'Réabonnez-vous  à l’identique ou passez à une autre formule pour ',
                style: TextStyle(
                    fontSize: M3FontSizes.headlineSmall,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              TextSpan(
                text: ' Maison 1',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineSmall,
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
    final header4 = Column(
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
                text: 'Vous allez payer'.toUpperCase(),
                style: const TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' \n15 000 fcfa'.toUpperCase(),
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
                text: 'à '.toUpperCase(),
                style: const TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'canal+ '.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
              TextSpan(
                text: 'pour \nrenouveler votre abonnement.'.toUpperCase(),
                style: const TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
                style: const TextStyle(
                  fontSize: M3FontSizes.headlineSmall,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: '150 FCFA'.toUpperCase(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineSmall,
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
                                style: TextStyle(
                                    fontSize: M3FontSizes.headlineSmall,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurface),
                              ),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.headlineSmall,
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
                                style: TextStyle(
                                    fontSize: M3FontSizes.headlineSmall,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurface),
                              ),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.headlineSmall,
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
    final page3 = Stack(
      children: [
        SingleChildScrollView(
          padding: UISettings.pagePadding.copyWith(
            top: context.height * .025,
            bottom: context.height * .025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header2,
              FluButton.text(
                "Ajouter carte",
                prefixIcon: FluIcons.addCircle,
                backgroundColor: context.colorScheme.primaryContainer,
                margin: EdgeInsets.only(bottom: context.height * .020),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final option = action.children[index];

                    return FluButton(
                      // onPressed: () => KRouter.to(context, Routes.subscriptionTransferConfirmation),.
                      onPressed: toNextStep,
                      width: double.infinity,
                      backgroundColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      border: BorderSide(
                          width: 1.5,
                          color: context.colorScheme.outlineVariant
                              .withOpacity(.5)),
                      cornerRadius: 25,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Maison $index',
                                  style:
                                      context.textTheme.headlineLarge?.copyWith(
                                    fontSize: M3FontSizes.headlineSmall,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  '0085764',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontSize: M3FontSizes.bodyMedium,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FluIcon(
                            FluIcons.export3,
                            color: context.colorScheme.primary.withOpacity(.5),
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(height: 75),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: true,
              child: Container(
                height: 70,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: UISettings.pagePadding
                      .copyWith(top: 8, left: 24, right: 24),
                  child: FluButton.text(
                    'Confirmir',
                    suffixIcon: FluIcons.checkCircleUnicon,
                    iconStrokeWidth: 1.8,
                    // onPressed: toNextStep,
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
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: M3FontSizes.bodyLarge),
                  ),
                ),
              ),
            ))
      ],
    );
    final page4 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header3,
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
                                style: TextStyle(
                                    fontSize: M3FontSizes.headlineSmall,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurface),
                              ),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: M3FontSizes.headlineSmall,
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
    final page5 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: context.height * .025,
        bottom: context.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header4,
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
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
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
      children: [page1, page2, page3, page4, page5],
    );
  }
}

// 22879397111
