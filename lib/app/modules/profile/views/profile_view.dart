// ignore_for_file: avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/components/line.dart';
import 'package:ibank/app/components/map.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
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

  void getDataFromProfileOptions() {
    profileScreenOptions = [
      FluOption(
          icon: FluIcons.profile,
          title: LocaleKeys.strPersonalInfo.tr,
          description: LocaleKeys.strPersonalInfoDesc.tr),
      FluOption(
          icon: FluIcons.password,
          title: LocaleKeys.strChangePass.tr,
          description: LocaleKeys.strChangePassDesc.tr),
      FluOption(
          icon: FluIcons.flag,
          title: LocaleKeys.strLanguage.tr,
          description: LocaleKeys.strLanguageDesc.tr),
      FluOption(
          icon: FluIcons.people,
          title: LocaleKeys.strFavorites.tr,
          description: LocaleKeys.strFavoritesDesc.tr),
      FluOption(
          icon: FluIcons.cards,
          title: LocaleKeys.strMyCards.tr,
          description: LocaleKeys.strMyCardsDesc.tr),
      FluOption(
          icon: FluIcons.bank,
          title: LocaleKeys.strMyBanks.tr,
          description: LocaleKeys.strMyBanksDesc.tr),
      FluOption(
          icon: FluIcons.noteText,
          title: LocaleKeys.strFaq.tr,
          description: LocaleKeys.strFaqDesc.tr),
      FluOption(
          icon: FluIcons.supportLikeQuestion24Support,
          title: LocaleKeys.strSupportHelp.tr,
          description: LocaleKeys.strSupportHelpDesc.tr),
      FluOption(
          icon: FluIcons.textalignCenter,
          title: LocaleKeys.strCredit.tr,
          description: LocaleKeys.strCreditDesc.tr),
      FluOption(
          icon: FluIcons.logout,
          title: LocaleKeys.strLogout.tr,
          description: LocaleKeys.strLogoutDesc.tr),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoadingProfile.value
            ? const CircularProgressIndicator()
            : SafeArea(
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 25, bottom: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Padding(
                      padding: UISettings.pagePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                          strokeWidth: 2,
                                          value: .15,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  context.colorScheme.primary),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: 'user_avatar',
                                      child: GestureDetector(
                                        onTap: () async {
                                          await storage
                                              .remove('msisdn')
                                              .then((value) {
                                            storage.remove('isPrivacyCheck');
                                            storage
                                                .remove('isLoginSuccessClick');
                                            ProgressAlertDialog
                                                .showALoadingDialog(
                                                    context,
                                                    LocaleKeys
                                                        .strLogoutMessage.tr,
                                                    3,
                                                    AppRoutes.LOGIN);
                                          });
                                          // await SharedPrefService.logoutUserData(false, '').then((value) {
                                          //   ProgressAlertDialog.showALoadingDialog(context, 'Logging out...', 3, AppRoutes.LOGIN);
                                          // });
                                        },
                                        child: const FluAvatar(
                                          size: 65,
                                          cornerRadius: 999,
                                          icon: FluIcons.user,
                                        ),
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
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const FluIcon(
                                          FluIcons.routing2,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            AppGlobal.currentAddress.isEmpty
                                                ? ''
                                                : AppGlobal.currentAddress,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FluLine(
                                height: UISettings.minButtonSize / 2,
                                width: 1,
                                color: context.colorScheme.onBackground
                                    .withOpacity(.5),
                                margin: const EdgeInsets.only(right: 10),
                              ),
                              Hero(
                                tag: "backButtonHeroTag",
                                child: FluButton.icon(
                                  FluIcons.setting2,
                                  // onPressed: () => Get.toNamed(AppRoutes.SETTINGS),
                                  size: UISettings.minButtonSize,
                                  cornerRadius:
                                      UISettings.minButtonCornerRadius,
                                  backgroundColor:
                                      context.colorScheme.background,
                                  iconSize: 24,
                                  foregroundColor:
                                      context.colorScheme.onBackground,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FluLine(
                            height: 2,
                            width: 30,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: context.colorScheme.tertiary,
                          ),
                          Text(
                            LocaleKeys.strAgenciesNearby.tr,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          const SizedBox(height: 10),
                          Hero(
                            tag: "descriptionTextHeroTag",
                            child: Text(
                              LocaleKeys.strAgenciesNearbyDesc.tr,
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 45),
                            child: AgenciesMap(
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                radius:
                                    MediaQuery.of(context).size.height * .045,
                                onTap: (lat) {
                                  Get.toNamed(AppRoutes.MAP);
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SepLine(
                      margin: EdgeInsets.only(bottom: 25),
                    ),
                    Padding(
                        padding: UISettings.pagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.strMyFlooz.tr,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 45),
                                itemCount: profileScreenOptions.length,
                                itemBuilder: (context, index) {
                                  FluOption option =
                                      profileScreenOptions[index];
                                  bool isLogout = lastIsLogout &&
                                      index == profileScreenOptions.length - 1;

                                  return FluButton(
                                    onPressed: option.onPressed ??
                                        () {
                                          if (index == 0) {
                                            Get.find<ProfileController>()
                                                    .selectedRoute
                                                    .value =
                                                LocaleKeys.strPersonalInfo.tr;
                                            Get.toNamed(AppRoutes.PROFILEOTP);
                                          } else if (index == 1) {
                                            Get.find<ProfileController>()
                                                    .selectedRoute
                                                    .value =
                                                LocaleKeys.strChangePass.tr;
                                            Get.toNamed(AppRoutes
                                                .PROFILECHANGESPASSWORD);
                                            Get.find<ProfileController>()
                                                .oldPIN
                                                .clear();
                                            Get.find<ProfileController>()
                                                .newPIN
                                                .clear();
                                            Get.find<ProfileController>()
                                                .confirmNewPIN
                                                .clear();
                                          } else if (index == 2) {
                                            showSelectLanguageDialog(context);
                                          } else if (index == 9) {
                                            showLogoutDialog(context);
                                          } else {
                                            Get.snackbar("Message",
                                                LocaleKeys.strComingSoon.tr,
                                                backgroundColor:
                                                    Colors.lightBlue,
                                                colorText: Colors.white,
                                                duration:
                                                    const Duration(seconds: 3));
                                          }
                                        },
                                    backgroundColor:
                                        context.colorScheme.background,
                                    margin: EdgeInsets.only(
                                        top: index == 0 ? 0 : 25),
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                  height: 60 + 8,
                                                  width: 60 + 8,
                                                  child: RotatedBox(
                                                    quarterTurns: 2,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 1.5,
                                                      value: .25,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        (isLogout
                                                                ? Colors.red
                                                                : context
                                                                    .colorScheme
                                                                    .primary)
                                                            .withOpacity(.1),
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: (isLogout
                                                            ? Colors.red
                                                            : context
                                                                .colorScheme
                                                                .primary)
                                                        .withOpacity(.045),
                                                    shape: BoxShape.circle),
                                                child: FluIcon(
                                                  option.icon!,
                                                  size: 24,
                                                  strokeWidth: 1.6,
                                                  color: isLogout
                                                      ? Colors.red
                                                      : context.colorScheme
                                                          .onSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(
                                                option.title,
                                                style: TextStyle(
                                                  fontSize:
                                                      M3FontSizes.bodyLarge,
                                                  fontWeight: FontWeight.bold,
                                                  color: isLogout
                                                      ? Colors.red
                                                      : context.colorScheme
                                                          .onBackground,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                option.description!,
                                                style: TextStyle(
                                                  color: isLogout
                                                      ? Colors.red
                                                      : context.colorScheme
                                                          .onBackground
                                                          .withOpacity(.75),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ])),
                                        const SizedBox(width: 15),
                                        FluIcon(
                                          FluIcons.arrowRight1,
                                          size: 18,
                                          color: isLogout
                                              ? Colors.red
                                              : context
                                                  .colorScheme.onBackground,
                                        ),
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
    );
  }

  void showSelectLanguageDialog(BuildContext context) {
    List<bool> selectedLanguages = [
      false,
      false
    ]; // Index 0: English, Index 1: French
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
                          Image.asset(AppImages.franceFlag,
                              height: 30, width: 30),
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
                onPressed: AppGlobal.isSelectEnglish == false &&
                        AppGlobal.isSelectFrench == false
                    ? null
                    : () {
                        if (AppGlobal.isSelectFrench == true &&
                            AppGlobal.isSelectEnglish == false) {
                          Get.find<StorageServices>()
                              .saveLanguage(language: 'FR');
                        } else {
                          Get.find<StorageServices>()
                              .saveLanguage(language: 'EN');
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
          title: Text(LocaleKeys.strLogout.tr),
          content: SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width - 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(LocaleKeys.strLogoutWarning.tr),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await storage.remove('msisdn').then((value) {
                  storage.remove('isPrivacyCheck');
                  storage.remove('isLoginSuccessClick');
                  ProgressAlertDialog.showALoadingDialog(context,
                      LocaleKeys.strLogoutMessage.tr, 3, AppRoutes.LOGIN);
                });
              },
              child: Text(LocaleKeys.strYes.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(LocaleKeys.strNo.tr),
            ),
          ],
        );
      },
    );
  }
}
