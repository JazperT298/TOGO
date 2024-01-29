// ignore_for_file: unused_local_variable, unused_element, unused_import

import 'dart:io';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/home/alertdialog/home_alertdialog.dart';
import 'package:ibank/app/modules/home/controller/home_controller.dart';
import 'package:ibank/app/modules/home/views/modals/balance_check_bottom_sheet.dart';
import 'package:ibank/app/modules/home/views/widgets/carousel_widget.dart';
import 'package:ibank/app/modules/mbanking/views/modals/mbanking_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_main_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_service_link_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_menu_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:ibank/utils/core/users.dart';
import 'package:sizer/sizer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget _buildTitle(BuildContext context, String text, Color color) => Text(
        text.toUpperCase(),
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: MediaQuery.of(context).size.height * .025),
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
                                AppGlobal.PROFILEAVATAR.isEmpty && AppGlobal.PROFILEIMAGE.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 24.0,
                                        child: ClipOval(
                                          child: Image.file(
                                            File(AppGlobal.PROFILEIMAGE),
                                          ),
                                        ))
                                    : AppGlobal.PROFILEIMAGE.isEmpty && AppGlobal.PROFILEAVATAR.isNotEmpty
                                        ? Image.asset(AppGlobal.PROFILEAVATAR, height: 52, width: 52)
                                        : Image.asset(AppImages.userIcon, height: 52, width: 52),
                                const Spacer(),
                                /* FluButton.icon(FluIcons.plusUnicon,
                                  size: UISettings.minButtonSize), */
                                const FluButton.icon(
                                  FluIcons.notification,
                                  size: UISettings.minButtonSize,
                                ),
                              ],
                            ),
                            Obx(
                              () => controller.isLoadingHome.value == true
                                  ? loadingHomeScreen()
                                  : SizedBox(height: MediaQuery.of(context).size.height * .035),
                            ),
                            Text(
                              Flu.formatDate(DateTime.now()).toUpperCase(),
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 14),
                            ),
                            _buildTitle(context, LocaleKeys.strMoneyControl.tr.toUpperCase(), context.colorScheme.onSurface),
                            FluLine(
                              height: 1,
                              width: double.infinity,
                              color: context.colorScheme.surface,
                              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025).copyWith(
                                left: MediaQuery.of(context).size.height * .1,
                                right: MediaQuery.of(context).size.height * .015,
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
                padding: EdgeInsets.only(right: 20, top: 50, left: 20, bottom: 15),
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
        decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(25)),
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
                      'My Balance',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14),
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
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      )
                                    : Text(
                                        controller.soldeFlooz.value,
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                child: Text(
                                  " FCFA",
                                  style: TextStyle(
                                    fontSize: 11.sp,
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
                              controller.afficherSolde.value == true ? FluIcons.eye : FluIcons.eyeSlash,
                              onPressed: () {
                                if (controller.afficherSolde.value == true) {
                                  // HomeAlertDialog.showOTPview(controller: controller);
                                  BalanceCheckBottomSheet.showBottomSheetInputNumber();
                                } else {
                                  controller.afficherSolde.value = true;
                                }

                                setState(() {});
                              },
                              alignment: Alignment.centerRight,
                              backgroundColor: Colors.transparent,
                              foregroundColor: context.colorScheme.onPrimary.withOpacity(.5),
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
                      '${controller.name.value} ${controller.firstname.value}',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    Get.find<StorageServices>().storage.read('formattedMSISDN'),
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
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const _ModalBottomSheet(
                  child: EnvoiMenuBottomSheet(),
                ));
        // SendMoneyMenuBottomSheet.showBottomSheetSendMoneyMenu();

        break;
      case WalletActions.withdraw:
        // KRouter.noContextPush(Routes.withdrawal);
        // Get.toNamed(AppRoutes.WITHDRAWAL);
        // showModalBottomSheet(
        //     isScrollControlled: true,
        //     context: context,
        //     builder: (context) => const _ModalBottomSheet2(
        //           child: WithdrawMenuBottomSheet(),
        //         ));
        WithdrawMenuBottomSheets.showBottomSheetWithdrawMenu();
        break;
      case WalletActions.pay:
        // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
        //     backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
        PaymentMainMenuBottomSheet.showBottomSheetPaymentMenu(context);

        // showModalBottomSheet(
        // context: context,
        // builder: (context) => _ModalBottomSheet(child: (action == WalletActions.pay) ? const _ServicesModalBottomSheet() : Container()));
        break;
      // case WalletActions.topUp:
      // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
      //     backgroundColor: Colors.lightBlue,
      //     colorText: Colors.white,
      //     duration: const Duration(seconds: 3));
      // RechargeMenuDialog.showRechargeMenuDialog();
      // RechargeCreditMainMenuBottomSheet.showBottomSheetRechargeMainMenu();
      // showModalBottomSheet(
      // context: context,
      // builder: (context) => _ModalBottomSheet(child: (action == WalletActions.pay) ? const _ServicesModalBottomSheet() : Container()));
      // break;
      case WalletActions.mBanking:
        MBankingMenuBottomSheet.showMBankingMenuBottomSheet();
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
            margin: EdgeInsets.only(left: WalletActions.values.indexOf(action) == 0 ? 0 : 10),
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
    // Get.toNamed(index == null ? AppRoutes.NEWFAV : AppRoutes.TRANSFER);
    Get.snackbar("Message", "À venir", backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    const double itemSize = UISettings.buttonSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: UISettings.pagePadding.copyWith(top: MediaQuery.of(context).size.height * .035, bottom: MediaQuery.of(context).size.height * .035),
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.strRapidCash.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                ),
                const SizedBox(height: 5),
                Hero(
                  tag: '<title>',
                  child: Text(
                    LocaleKeys.strFavoritePeople.tr.toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
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
              Container(
                  height: itemSize,
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = favorites[index];

                      // return CustomPaint(
                      //   painter: DottedCirclePainter(),
                      //   child: const FluIcon(FluIcons.plus),
                      // );

                      return FluButton(
                        onPressed: () => onItemTap(index),
                        height: itemSize,
                        width: itemSize,
                        margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          // child: Center(
                          //   child: Text(
                          //     user.firstName.substring(0, 1),
                          //     style: const TextStyle(
                          //       color: Colors.white, // You can change the text color
                          //       fontSize: 24.0, // You can adjust the font size
                          //     ),
                          //   ),
                          // ),
                          child: const FluIcon(
                            FluIcons.add,
                            size: 24.0,
                            color: Colors.black,
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
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
              //   child: Container(
              //     height: 6,
              //     width: 100,
              //     color: Colors.white,
              //     margin: const EdgeInsets.only(bottom: 4),
              //   ),
              // ),
              Container(
                  height: isKeyboardVisible ? MediaQuery.of(context).size.height * .5 : MediaQuery.of(context).size.height * .39,
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                  ),
                  child: child),
            ],
          ),
        ),
      );
    });
  }
}

class _ModalBottomSheet2 extends StatelessWidget {
  const _ModalBottomSheet2({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center(
              //   child: Container(
              //     height: 6,
              //     width: 100,
              //     color: Colors.white,
              //     margin: const EdgeInsets.only(bottom: 4),
              //   ),
              // ),
              Container(
                  height: isKeyboardVisible ? MediaQuery.of(context).size.height * .5 : MediaQuery.of(context).size.height * .50,
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                  ),
                  child: child),
            ],
          ),
        ),
      );
    });
  }
}

class _ServicesModalBottomSheet extends StatefulWidget {
  const _ServicesModalBottomSheet();

  @override
  State<_ServicesModalBottomSheet> createState() => _ServicesModalBottomSheetState();
}

class _ServicesModalBottomSheetState extends State<_ServicesModalBottomSheet> {
  final PageController pageController = PageController();

  void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);

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
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.strCanalboxOffers.tr,
          style: TextStyle(
            fontFamily: 'neptune',
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Selectionnez votre offre.',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onBackground,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'canalBox',
          style: TextStyle(
            color: context.colorScheme.primary,
          ),
        ),
        Text(
          'Selectionnez votre box.',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onBackground,
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: BorderSide(width: 1.5, color: context.colorScheme.outlineVariant.withOpacity(.5)),
                  cornerRadius: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.strStartOffer.tr),
                            Text.rich(
                              TextSpan(children: [
                                const TextSpan(text: '15000'),
                                TextSpan(text: ' ${LocaleKeys.strFmonth.tr}', style: TextStyle(fontSize: 11.sp))
                              ]),
                              style: TextStyle(
                                fontSize: 11.sp,
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
                  onPressed: () => Get.toNamed(AppRoutes.BOTTOMNAV), //KRouter.to(context, Routes.subscriptionTransferConfirmation),
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: BorderSide(width: 1.5, color: context.colorScheme.outlineVariant.withOpacity(.5)),
                  cornerRadius: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${LocaleKeys.strHome.tr} $index'),
                            Text(
                              '0085764',
                              style: TextStyle(
                                fontSize: 11.sp,
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
            LocaleKeys.strAddABox.tr,
            prefixIcon: FluIcons.add,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .015),
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
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  LocaleKeys.strJustForYou.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  LocaleKeys.strRechargeSendWin.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                ),
              ],
            ))
          ],
        ),
        const SizedBox(height: 40),
        Container(
          height: 215,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: CarouselWidget.buildCarouselSlider(),
        ),
        // Container(
        //     height: 215,
        //     margin: const EdgeInsets.only(bottom: 20),
        //     clipBehavior: Clip.hardEdge,
        //     decoration: BoxDecoration(color: context.colorScheme.secondary.withOpacity(.45), borderRadius: BorderRadius.circular(30)),
        //     child: Stack(
        //       children: [
        //         const FluImage(
        //           'https://cdn.dribbble.com/users/221912/screenshots/16487340/media/cbe88d0a96371191065d6e2eb8f25a6f.jpg?compress=1&resize=800x600&vertical=top',
        //           height: double.infinity,
        //           width: double.infinity,
        //           overlayOpacity: .5,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15, bottom: 15),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Row(children: [
        //                 Expanded(child: _StoryIndicator(1)),
        //                 SizedBox(width: 8),
        //                 Expanded(child: _StoryIndicator(0)),
        //                 SizedBox(width: 8),
        //                 Expanded(child: _StoryIndicator(0)),
        //                 SizedBox(width: 8),
        //                 Expanded(child: _StoryIndicator(0)),
        //               ]),
        //               SizedBox(
        //                   width: double.infinity,
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         '2023 Super Bowl LVI.',
        //                         style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: context.colorScheme.onPrimary),
        //                       ),
        //                       const SizedBox(height: 3),
        //                       Text(
        //                         'Le super bowl est là. Vivez de moments de folie avec flooz.',
        //                         style: TextStyle(color: context.colorScheme.onPrimary),
        //                       ),
        //                     ],
        //                   ))
        //             ],
        //           ),
        //         ),
        //       ],
        //     )),
        Text(
          LocaleKeys.strRechargeSendWinDesc.tr,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),
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
        valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.onPrimary),
      ),
    );
  }
}
