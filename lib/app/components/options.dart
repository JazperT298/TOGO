// ignore_for_file: avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';

class FluOption {
  final String title;
  final String? description, image;
  final ImageSources imageType;
  final FluIcons? icon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  final Color? color, background, iconbackground, outlineColor;
  final bool hasSuffix;
  final String? label;

  FluOption(
      {required this.title,
      this.description,
      this.icon,
      this.image,
      this.imageType = ImageSources.asset,
      this.suffixWidget,
      this.hasSuffix = true,
      this.onPressed,
      this.color,
      this.background,
      this.iconbackground,
      this.outlineColor,
      this.label});
}

class Options extends StatelessWidget {
  final List<FluOption> options;
  final double itemSize, spaceBetweenOptions;
  final EdgeInsets padding;
  final bool lastIsLogout;

  const Options(
    this.options, {
    Key? key,
    this.itemSize = 60,
    this.spaceBetweenOptions = 25,
    this.padding = const EdgeInsets.only(top: 45),
    this.lastIsLogout = false,
  }) : super(key: key);

  void onOptionTap(int index) {}

  @override
  Widget build(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: options.length,
      itemBuilder: (context, index) {
        FluOption option = options[index];
        bool isLogout = lastIsLogout && index == options.length - 1;

        return FluButton(
          onPressed: option.onPressed ??
              () {
                if (index == 0) {
                  Get.find<ProfileController>().selectedRoute.value = LocaleKeys.strPersonalInfo.tr;
                  Get.toNamed(AppRoutes.PROFILEOTP);
                } else if (index == 1) {
                  Get.find<ProfileController>().selectedRoute.value = LocaleKeys.strChangePass.tr;
                  Get.toNamed(AppRoutes.PROFILECHANGESPASSWORD);
                  Get.find<ProfileController>().oldPIN.clear();
                  Get.find<ProfileController>().newPIN.clear();
                  Get.find<ProfileController>().confirmNewPIN.clear();
                } else if (index == 2) {
                  showSelectLanguageDialog(context);
                } else {
                  Get.snackbar("Message", "À venir",
                      backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                }
              },
          backgroundColor: context.colorScheme.background,
          margin: EdgeInsets.only(top: index == 0 ? 0 : spaceBetweenOptions),
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
                        height: itemSize + 8,
                        width: itemSize + 8,
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
                      height: itemSize,
                      width: itemSize,
                      decoration:
                          BoxDecoration(color: (isLogout ? Colors.red : context.colorScheme.primary).withOpacity(.045), shape: BoxShape.circle),
                      child: FluIcon(
                        option.icon!,
                        size: 24,
                        strokeWidth: 1.6,
                        color: isLogout ? Colors.red : context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  option.title,
                  style: TextStyle(
                    fontSize: M3FontSizes.bodyLarge,
                    fontWeight: FontWeight.bold,
                    color: isLogout ? Colors.red : context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  option.description!,
                  style: TextStyle(
                    color: isLogout ? Colors.red : context.colorScheme.onBackground.withOpacity(.75),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ])),
              const SizedBox(width: 15),
              FluIcon(
                FluIcons.arrowRight1,
                size: 18,
                color: isLogout ? Colors.red : context.colorScheme.onBackground,
              ),
            ],
          ),
        );
      });

  void showSelectLanguageDialog(BuildContext context) {
    List<bool> selectedLanguages = [false, false]; // Index 0: English, Index 1: French

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(LocaleKeys.strSelectLanguage.tr),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('English'),
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
                      const Text('French'),
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
                child: const Text('Select'),
              ),
            ],
          );
        });
      },
    ).then((value) {
      // log('value $value');
      // String enLang = Get.find<StorageServices>().storage.read('language');
      // log('value $enLang');
      // Get.updateLocale(Locale(enLang.toLowerCase()));
      // AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
      // AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
      Get.find<BottomNavController>().getDataFromStorage();
    });
  }
}
