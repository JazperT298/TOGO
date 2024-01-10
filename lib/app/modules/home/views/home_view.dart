// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/home/alertdialog/home_alertdialog.dart';
import 'package:ibank/app/modules/home/controller/home_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/dialog/send_menu_dialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_colors.dart';
import 'package:ibank/utils/core/users.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget _buildTitle(BuildContext context, String text, Color color) => Text(
        text.toUpperCase(),
        style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1.5),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 10, bottom: MediaQuery.of(context).size.height * .025),
                color: context.colorScheme.primary.withOpacity(.1),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: UISettings.pagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FluBadge(
                                  offset: const Offset(5, 5),
                                  child: FluAvatar(
                                    size: UISettings.minButtonSize - 8,
                                    outlined: true,
                                    outlineThickness: 1.5,
                                    outlineGap: 3,
                                    outlineColor: [
                                      context.colorScheme.outlineVariant
                                    ],
                                    margin: const EdgeInsets.only(right: 10),
                                  ),
                                ),
                                const Spacer(),
                                /* FluButton.icon(FluIcons.plusUnicon,
                                  size: UISettings.minButtonSize), */
                                const FluButton.icon(
                                  FluIcons.notification,
                                  size: UISettings.minButtonSize,
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .035),
                            Text(Flu.formatDate(DateTime.now()).toUpperCase(),
                                style: TextStyle(
                                    color: context.colorScheme.onBackground
                                        .withOpacity(.45))),
                            _buildTitle(
                                context,
                                'Votre argent, votre contrôle.'.toUpperCase(),
                                context.colorScheme.onSurface),
                            FluLine(
                              height: 1,
                              width: double.infinity,
                              color: context.colorScheme.surface,
                              margin: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .025)
                                  .copyWith(
                                left: MediaQuery.of(context).size.height * .1,
                                right:
                                    MediaQuery.of(context).size.height * .015,
                              ),
                            ),
                            const _Card(),
                          ],
                        ),
                      ),
                      const _QuickActions(),
                    ],
                  ),
                ),
              ),
              _Favorites(users..shuffle()),
              const Padding(
                padding:
                    EdgeInsets.only(right: 20, top: 50, left: 20, bottom: 15),
                child: _PromotionsAndOffers(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatefulWidget {
  const _Card();

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    const double paddingSize = 15;

    return Container(
        height: MediaQuery.of(context).size.height * .25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(paddingSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'flooz',
                      style: TextStyle(
                        color: context.colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'neptune',
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(children: [
                              Obx(
                                () => controller.afficherSolde.value == true
                                    ? Text(
                                        '######',
                                        style: TextStyle(
                                          fontSize: M3FontSizes.displayMedium,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      )
                                    : Text(
                                        controller.soldeFlooz.value,
                                        style: TextStyle(
                                          fontSize: M3FontSizes.displayMedium,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                child: Text(
                                  " FCFA",
                                  style: TextStyle(
                                    fontSize: M3FontSizes.bodySmall,
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ]),
                            // child: Text.rich(
                            //   TextSpan(children: [
                            //     TextSpan(
                            //         text: controller.afficherSolde
                            //             ? '######'
                            //             : controller.soldeFlooz.value),
                            //     const TextSpan(
                            //         text: ' CFA',
                            //         style: TextStyle(
                            //             fontSize: M3FontSizes.bodySmall)),
                            //   ]),
                            //   style: TextStyle(
                            //     fontSize: M3FontSizes.displayMedium,
                            //     fontWeight: FontWeight.bold,
                            //     color: context.colorScheme.onPrimary,
                            //   ),
                            // ),
                          ),
                          Obx(
                            () => FluButton.icon(
                              controller.afficherSolde.value == true
                                  ? FluIcons.eye
                                  : FluIcons.eyeSlash,
                              onPressed: () {
                                if (controller.afficherSolde.value == true) {
                                  HomeAlertDialog.showOTPview(
                                      controller: controller);
                                } else {
                                  controller.afficherSolde.value = true;
                                }

                                setState(() {});
                              },
                              alignment: Alignment.centerRight,
                              backgroundColor: Colors.transparent,
                              foregroundColor:
                                  context.colorScheme.onPrimary.withOpacity(.5),
                              // margin: EdgeInsets.only(bottom: 5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white54),
              padding: const EdgeInsets.symmetric(
                horizontal: paddingSize,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      // authenticatedUser.fullName.toUpperCase(),
                      controller.name.value,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '62 35 67 89',
                    style: TextStyle(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  void onAction(BuildContext context, WalletActions action) {
    switch (action) {
      case WalletActions.send:
        // KRouter.noContextPush(Routes.newTransfer);
        // Get.toNamed(AppRoutes.TRANSFER);
        // showModalBottomSheet(
        //     context: context,
        //     builder: (context) =>
        //         const _ModalBottomSheet(child: EnvoiModalBottomSheet()));
        SendMenuDialog.showMenuDialog(context);

        break;
      case WalletActions.withdraw:
        // KRouter.noContextPush(Routes.withdrawal);
        Get.toNamed(AppRoutes.WITHDRAWAL);
        break;
      case WalletActions.pay:
      case WalletActions.topUp:
        showModalBottomSheet(
            context: context,
            builder: (context) => _ModalBottomSheet(
                child: (action == WalletActions.pay)
                    ? const _ServicesModalBottomSheet()
                    : Container()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UISettings.buttonSize,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: UISettings.pagePadding,
        itemCount: WalletActions.values.length,
        itemBuilder: (context, index) {
          final action = WalletActions.values[index];

          return FluButton.text(
            action.text,
            prefixIcon: action.icon,
            gap: 6,
            iconSize: 20,
            iconStrokeWidth: 1.8,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            backgroundColor: context.colorScheme.background.withOpacity(.1),
            foregroundColor: context.colorScheme.onSurface,
            border: BorderSide(
              width: 1.5,
              color: context.colorScheme.primary.withOpacity(.1),
            ),
            margin: EdgeInsets.only(
                left: WalletActions.values.indexOf(action) == 0 ? 0 : 10),
            onPressed: () => onAction(context, action),
          );
        },
      ),
    );
  }
}

class _Favorites extends StatelessWidget {
  const _Favorites(this.favorites);

  final List<User> favorites;

  void onItemTap([int? index]) {
    // KRouter.noContextPush(index == null ? Routes.newFavorite : Routes.transfer);
    Get.toNamed(index == null ? AppRoutes.NEWFAV : AppRoutes.TRANSFER);
  }

  @override
  Widget build(BuildContext context) {
    const double itemSize = UISettings.buttonSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: UISettings.pagePadding.copyWith(
              top: MediaQuery.of(context).size.height * .035,
              bottom: MediaQuery.of(context).size.height * .035),
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'envoi rapide',
                  style: TextStyle(fontFamily: 'neptune'),
                ),
                const SizedBox(height: 5),
                Hero(
                  tag: '<title>',
                  child: Text(
                    'Personne favorites'.toUpperCase(),
                    style: TextStyle(
                      fontSize: M3FontSizes.headlineSmall,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            )),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: UISettings.pagePadding,
          child: Row(
            children: [
              FluButton.icon(
                FluIcons.plus,
                onPressed: onItemTap,
                size: itemSize,
                margin: const EdgeInsets.only(right: 10),
              ),
              SizedBox(
                  height: itemSize,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = favorites[index];

                      return FluButton(
                        onPressed: () => onItemTap(index),
                        height: itemSize,
                        width: itemSize,
                        margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.getRandomColor(),
                          ),
                          child: Center(
                            child: Text(
                              user.firstName.substring(0, 1),
                              style: const TextStyle(
                                color: Colors
                                    .white, // You can change the text color
                                fontSize: 24.0, // You can adjust the font size
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class _ModalBottomSheet extends StatelessWidget {
  const _ModalBottomSheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: context.colorScheme.background,
        ),
        child: child);
  }
}

class _ServicesModalBottomSheet extends StatefulWidget {
  const _ServicesModalBottomSheet();

  @override
  State<_ServicesModalBottomSheet> createState() =>
      _ServicesModalBottomSheetState();
}

class _ServicesModalBottomSheetState extends State<_ServicesModalBottomSheet> {
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
          action.name,
          style: TextStyle(
            fontFamily: 'neptune',
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          '${action.description}.',
          style: TextStyle(
            fontSize: M3FontSizes.displaySmall,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'les offres canalBox',
          style: TextStyle(
            fontFamily: 'neptune',
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Selectionnez votre offre.',
          style: TextStyle(
            fontSize: M3FontSizes.displaySmall,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onBackground,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'canalBox',
          style: TextStyle(
            fontFamily: 'neptune',
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Selectionnez votre box.',
          style: TextStyle(
            fontSize: M3FontSizes.displaySmall,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onBackground,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );

    final page1 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
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
                            height: MediaQuery.of(context).size.width * .15,
                            width: MediaQuery.of(context).size.width * .15,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: FluIcon(option.icon)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(option.name),
                              Text(
                                option.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header1,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                final option = action.children[index];

                return FluButton(
                  onPressed: toNextStep,
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: BorderSide(
                      width: 1.5,
                      color:
                          context.colorScheme.outlineVariant.withOpacity(.5)),
                  cornerRadius: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Offre start.'),
                            Text.rich(
                              const TextSpan(children: [
                                TextSpan(text: '15000'),
                                TextSpan(
                                    text: ' F/Mois',
                                    style: TextStyle(
                                        fontSize: M3FontSizes.labelSmall))
                              ]),
                              style: TextStyle(
                                fontSize: M3FontSizes.displaySmall,
                                fontWeight: FontWeight.w600,
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
              })
        ],
      ),
    );
    final page3 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header2,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final option = action.children[index];

                return FluButton(
                  onPressed: () => Get.toNamed(AppRoutes
                      .BOTTOMNAV), //KRouter.to(context, Routes.subscriptionTransferConfirmation),
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: BorderSide(
                      width: 1.5,
                      color:
                          context.colorScheme.outlineVariant.withOpacity(.5)),
                  cornerRadius: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Maison $index'),
                            Text(
                              '0085764',
                              style: TextStyle(
                                fontSize: M3FontSizes.headlineSmall,
                                fontWeight: FontWeight.w600,
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
          FluButton.text(
            "Ajouter une box",
            prefixIcon: FluIcons.add,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .015),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ],
      ),
    );

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        page1,
        page2,
        page3,
      ],
    );
  }
}

/// Promotions, offers, news, etc.
/// This section contains a list of promotions, offers, news, etc.
class _PromotionsAndOffers extends StatelessWidget {
  const _PromotionsAndOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FluLine(
                    height: 15,
                    width: 3,
                    color: context.colorScheme.secondary,
                  ),
                  FluLine(
                    height: 35,
                    width: 3,
                    color: context.colorScheme.primary,
                    margin: const EdgeInsets.only(top: 3),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Juste pour vous.',
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontFamily: 'neptune',
                    fontSize: M3FontSizes.bodyLarge,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Rechargez, envoyez et gagnez!'.toUpperCase(),
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineSmall,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ))
          ],
        ),
        const SizedBox(height: 40),
        Container(
            height: 215,
            margin: const EdgeInsets.only(bottom: 20),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: context.colorScheme.secondary.withOpacity(.45),
                borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: [
                const FluImage(
                  'https://cdn.dribbble.com/users/221912/screenshots/16487340/media/cbe88d0a96371191065d6e2eb8f25a6f.jpg?compress=1&resize=800x600&vertical=top',
                  height: double.infinity,
                  width: double.infinity,
                  overlayOpacity: .5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        Expanded(child: _StoryIndicator(1)),
                        SizedBox(width: 8),
                        Expanded(child: _StoryIndicator(0)),
                        SizedBox(width: 8),
                        Expanded(child: _StoryIndicator(0)),
                        SizedBox(width: 8),
                        Expanded(child: _StoryIndicator(0)),
                      ]),
                      SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2023 Super Bowl LVI.',
                                style: TextStyle(
                                    fontSize: M3FontSizes.bodyLarge,
                                    color: context.colorScheme.onPrimary),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Le super bowl est là. Vivez de moments de folie avec flooz.',
                                style: TextStyle(
                                    color: context.colorScheme.onPrimary),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            )),
        const Text(
          'Rechargez, envoyez, payez et parier pour faire partie des heureux gagnants de diverse lots dont un SUV luxueux de chez Toyota...Vous avez l\'art de deviner? Participer à nos jeux concours sur nos réseaux et tentez de remporter un superbe voyage pour deux à Los angeles.',
          style: TextStyle(
            fontSize: M3FontSizes.bodyMedium,
          ),
        )
      ]);
}

class _StoryIndicator extends StatelessWidget {
  final double progress;

  const _StoryIndicator(this.progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(99)),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: context.colorScheme.onPrimary.withOpacity(.5),
        valueColor:
            AlwaysStoppedAnimation<Color>(context.colorScheme.onPrimary),
      ),
    );
  }
}
