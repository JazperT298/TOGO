// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/line.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/map.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/app/modules/profile/modals/profile_modal_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
  final storage = GetStorage();
  final bool lastIsLogout = false;
  List<FluOption> profileScreenOptions = [];
  @override
  void initState() {
    getDataFromProfileOptions();
    super.initState();
  }

  void getImageFromStorage() {}

  void getDataFromProfileOptions() {
    profileScreenOptions = [
      FluOption(icon: FluIcons.profile, title: LocaleKeys.strPersonalInfo.tr, description: LocaleKeys.strPersonalInfoDesc.tr),
      FluOption(icon: FluIcons.password, title: LocaleKeys.strChangePass.tr, description: LocaleKeys.strChangePassDesc.tr),
      FluOption(icon: FluIcons.flag, title: LocaleKeys.strLanguage.tr, description: LocaleKeys.strLanguageDesc.tr),
      FluOption(icon: FluIcons.people, title: LocaleKeys.strFavorites.tr, description: LocaleKeys.strFavoritesDesc.tr),
      FluOption(icon: FluIcons.cards, title: LocaleKeys.strMyCards.tr, description: LocaleKeys.strMyCardsDesc.tr),
      FluOption(icon: FluIcons.bank, title: LocaleKeys.strMyBanks.tr, description: LocaleKeys.strMyBanksDesc.tr),
      FluOption(icon: FluIcons.noteText, title: LocaleKeys.strFaq.tr, description: LocaleKeys.strFaqDesc.tr),
      FluOption(icon: FluIcons.supportLikeQuestion24Support, title: LocaleKeys.strSupportHelp.tr, description: LocaleKeys.strSupportHelpDesc.tr),
      FluOption(icon: FluIcons.textalignCenter, title: LocaleKeys.strCredit.tr, description: LocaleKeys.strCreditDesc.tr),
      FluOption(icon: FluIcons.calculator, title: 'Calculate keycost', description: 'Need help? Contact us...'),
      FluOption(icon: FluIcons.fingerScan, title: 'Secure Account', description: 'Enable facial recognition authentication'),
      FluOption(icon: FluIcons.logout, title: LocaleKeys.strLogout.tr, description: LocaleKeys.strLogoutDesc.tr),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoadingProfile.value
            ? const CircularProgressIndicator()
            : FluScreen(
                overlayStyle: context.systemUiOverlayStyle.copyWith(statusBarIconBrightness: Brightness.dark),
                body: SafeArea(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .05),
                  child: Column(
                    children: [
                      /// Header
                      Padding(
                        padding: UISettings.pagePadding.copyWith(top: 20, bottom: MediaQuery.of(context).size.height * .025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Other services'.toUpperCase(),
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF687997), fontSize: 14),
                                ),
                                Text(
                                  'Horem ipsum dor'.toUpperCase(),
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 26),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// User avatar.
                                Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      /// Avatar indicator.
                                      SizedBox(
                                        height: 75,
                                        width: 75,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5,
                                            value: .03,
                                            valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
                                          ),
                                        ),
                                      ),
                                      Hero(
                                        tag: 'user_avatar',
                                        child: GestureDetector(
                                          onTap: () async {
                                            log('(AppGlobal.PROFILEIMAGE ${AppGlobal.PROFILEIMAGE}');
                                            log('(AppGlobal.PROFILEAVATAR ${AppGlobal.PROFILEAVATAR}');
                                            // Get.back();
                                            // await Get.find<StorageServices>().clearUserLocalData().then((value) {
                                            //   ProgressAlertDialog.showLogoutALoadingDialog(context, LocaleKeys.strLogoutMessage.tr, 3, AppRoutes.LOGIN);
                                            // });
                                            // await SharedPrefService.logoutUserData(false, '').then((value) {
                                            //   ProgressAlertDialog.showALoadingDialog(context, 'Logging out...', 3, AppRoutes.LOGIN);
                                            // });
                                          },
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 1,
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: AppGlobal.PROFILEAVATAR.isEmpty && AppGlobal.PROFILEIMAGE.isNotEmpty
                                                  ? CircleAvatar(
                                                      backgroundColor: Colors.black,
                                                      radius: 30.0,
                                                      child: ClipOval(
                                                        child: Image.file(
                                                          File(AppGlobal.PROFILEIMAGE),
                                                        ),
                                                      ))
                                                  : AppGlobal.PROFILEIMAGE.isEmpty && AppGlobal.PROFILEAVATAR.isNotEmpty
                                                      ? Image.asset(AppGlobal.PROFILEAVATAR, height: 52, width: 52)
                                                      : Image.asset(AppImages.userIcon, height: 52, width: 52)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// User informations
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Hero(
                                      //       tag: "titleTextHeroTag",
                                      //       child: Text(
                                      //         authenticatedUser.fullName,
                                      //         style: TextStyle(
                                      //             fontSize: M3FontSizes.titleMedium, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                                      //       ),
                                      //     ),
                                      //     const SizedBox(width: 5),
                                      //     FluIcon(
                                      //       FluIcons.verify,
                                      //       size: 20,
                                      //       color: context.colorScheme.primary,
                                      //       style: FluIconStyles.bulk,
                                      //     )
                                      //   ],
                                      // ),
                                      Text(
                                        // AppGlobal.currentAddress.isEmpty ? '' : AppGlobal.currentAddress,
                                        'Koffi Kagni',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 16),
                                      ),
                                      Text(
                                        // AppGlobal.currentAddress.isEmpty ? '' : AppGlobal.currentAddress,
                                        '99 00 00 00 ',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 14),
                                      ),
                                      const SizedBox(height: 2),
                                      // Row(
                                      //   children: [
                                      //     // const FluIcon(
                                      //     //   FluIcons.routing2,
                                      //     //   size: 18,
                                      //     // ),
                                      //     // const SizedBox(width: 5),
                                      //     Expanded(
                                      //       child: Text(
                                      //         // AppGlobal.currentAddress.isEmpty ? '' : AppGlobal.currentAddress,
                                      //         'Koffi Kagni',
                                      //         overflow: TextOverflow.ellipsis,
                                      //         style:
                                      //             GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 16),
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Text(
                                      //         // AppGlobal.currentAddress.isEmpty ? '' : AppGlobal.currentAddress,
                                      //         '99 00 00 00 ',
                                      //         overflow: TextOverflow.ellipsis,
                                      //         style:
                                      //             GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 13),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                FluLine(
                                  height: UISettings.minButtonSize / 2,
                                  width: 1,
                                  color: context.colorScheme.onBackground.withOpacity(.5),
                                  margin: const EdgeInsets.only(right: 10),
                                ),
                                Hero(
                                  tag: "backButtonHeroTag",
                                  child: FluButton.icon(
                                    FluIcons.setting2,
                                    // onPressed: () => Get.toNamed(AppRoutes.SETTINGS),
                                    size: UISettings.minButtonSize,
                                    cornerRadius: UISettings.minButtonCornerRadius,
                                    backgroundColor: const Color(0xFFDBE4FB),
                                    iconSize: 24,
                                    foregroundColor: context.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: UISettings.pagePadding.copyWith(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.strAgenciesNearby.tr.toUpperCase(),
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Hero(
                              tag: "descriptionTextHeroTag",
                              child: Text(
                                LocaleKeys.strAgenciesNearbyDesc.tr,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25, bottom: 3.h),
                              child: AgenciesMap(
                                  height: MediaQuery.of(context).size.height * .25,
                                  radius: MediaQuery.of(context).size.height * .045,
                                  onTap: (lat) {
                                    Get.toNamed(AppRoutes.MAP);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          FluLine(
                            width: 30.w,
                            color: const Color(0xFFfb6708),
                          ),
                          CircleAvatar(
                            radius: 1.w,
                            backgroundColor: const Color(0xFFfb6708),
                          )
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  LocaleKeys.strMyFlooz.tr.toUpperCase(),
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 14),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 24),
                                  itemCount: profileScreenOptions.length,
                                  itemBuilder: (context, index) {
                                    FluOption option = profileScreenOptions[index];
                                    bool isLogout = lastIsLogout && index == profileScreenOptions.length - 1;

                                    return FluButton(
                                      onPressed: option.onPressed ??
                                          () {
                                            if (index == 0) {
                                              Get.find<ProfileController>().selectedRoute.value = LocaleKeys.strPersonalInfo.tr;
                                              // Get.toNamed(AppRoutes.PROFILEOTP);
                                              ProfileBottomSheet.showBottomSheetInputPIN();
                                            } else if (index == 1) {
                                              Get.find<ProfileController>().selectedRoute.value = LocaleKeys.strChangePass.tr;
                                              Get.toNamed(AppRoutes.PROFILECHANGESPASSWORD);
                                              Get.find<ProfileController>().oldPIN.clear();
                                              Get.find<ProfileController>().newPIN.clear();
                                              Get.find<ProfileController>().confirmNewPIN.clear();
                                            } else if (index == 2) {
                                              showSelectLanguageDialog(context);
                                            } else if (index == 9) {
                                              ProfileBottomSheet.showBottomSheetInputNumber();
                                            } else if (index == 10) {
                                              ProfileBottomSheet.showBottomSheetBiometrics();
                                            } else if (index == 11) {
                                              showLogoutDialog(context);
                                            } else {
                                              Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                                                  backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                                            }
                                          },
                                      backgroundColor: context.colorScheme.background,
                                      margin: EdgeInsets.only(top: index == 0 ? 0 : 12),
                                      padding: EdgeInsets.zero,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 70,
                                                    width: 70,
                                                    child: RotatedBox(
                                                      quarterTurns: 2,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 1.5,
                                                        value: .25,
                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                          (isLogout ? Colors.red : context.colorScheme.primary).withOpacity(.1),
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                  height: 62,
                                                  width: 62,
                                                  decoration: const BoxDecoration(color: Color(0xFFDBE4FB), shape: BoxShape.circle),
                                                  child:
                                                      FluIcon(option.icon!, size: 24, strokeWidth: 1.6, color: isLogout ? Colors.red : Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Text(
                                              option.title,
                                              style:
                                                  GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              option.description!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                                            ),
                                          ])),
                                          // const SizedBox(width: 15),
                                          // FluIcon(
                                          //   FluIcons.arrowRight1,
                                          //   size: 18,
                                          //   color: isLogout ? Colors.red : context.colorScheme.onBackground,
                                          // ),
                                        ],
                                      ),
                                    );
                                  }),
                              // Options(profileScreenOptions)
                            ],
                          ))
                    ],
                  ),
                )),
              ),
      ),
    );
  }

  void showSelectLanguageDialog(BuildContext context) {
    List<bool> selectedLanguages = [false, false]; // Index 0: English, Index 1: French
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(12), // Outside Padding
            contentPadding: const EdgeInsets.all(12), // Content Padding
            title: Text(LocaleKeys.strSelectLanguage.tr),
            content: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.ukFlag, height: 30, width: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(LocaleKeys.strEnglish.tr),
                          ),
                        ],
                      ),
                      Checkbox(
                        value: AppGlobal.isSelectEnglish,
                        onChanged: (value) {
                          // English checkbox
                          setState(() {
                            selectedLanguages[1] = false;
                            AppGlobal.isSelectEnglish = true;
                            AppGlobal.isSelectFrench = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.franceFlag, height: 30, width: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(LocaleKeys.strFrench.tr),
                          ),
                        ],
                      ),
                      Checkbox(
                        value: AppGlobal.isSelectFrench,
                        onChanged: (value) {
                          // French checkbox
                          setState(() {
                            AppGlobal.isSelectEnglish = false;
                            AppGlobal.isSelectFrench = true;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: AppGlobal.isSelectEnglish == false && AppGlobal.isSelectFrench == false
                    ? null
                    : () {
                        if (AppGlobal.isSelectFrench == true && AppGlobal.isSelectEnglish == false) {
                          Get.find<StorageServices>().saveLanguage(language: 'FR');
                        } else {
                          Get.find<StorageServices>().saveLanguage(language: 'EN');
                        }

                        Navigator.pop(context);
                      },
                child: Text(LocaleKeys.strSelect.tr),
              ),
            ],
          );
        });
      },
    ).then((value) {
      Get.find<BottomNavController>().getDataFromStorage();
      getDataFromProfileOptions();
    });
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12), // Content Padding
          title: Text(
            LocaleKeys.strLogout.tr,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
          ),
          content: SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width - 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                LocaleKeys.strLogoutWarning.tr,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Get.back();
                FullScreenLoading.fullScreenLoadingWithText('Logging out. . .');
                await storage.remove('msisdn').then((value) async {
                  await Future.delayed(const Duration(seconds: 3), () {
                    Get.back();
                    Get.find<StorageServices>().clearUserLocalData();
                    Get.offAllNamed(AppRoutes.LOGIN);
                  });
                });
                // Get.find<StorageServices>().clearUserLocalData();
              },
              child: Text(LocaleKeys.strYes.tr, style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                LocaleKeys.strNo.tr,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }
}
// My Flooz
// Personal informations.
// View your personal information...
// Security
// Change your security settings
// Favorites
// My cards
// Edit your personal information...
// Vorem ipsum dolor sit amet, cons...
// Personal references
// Corem ipsum dolor sit amezx ...
// M Banking
// Corem ipsum dolor sit amezx ...
// Ticket
// Corem ipsum dolor sit amezx ...
// Tontine
// Corem ipsum dolor sit amezx ...
// Collection
// Corem ipsum dolor sit amezx ...
// No Limit Subscription
// Need help ? Contact us...
// Fee calculation
// Need help ? Contact us...
// Support and help
// Need help ? Contact us...