import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/line.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/core/users.dart';
import 'package:ibank/utils/ui/options.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: UISettings.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "backButtonHeroTag",
                      child: FluButton.icon(
                        FluIcons.arrowLeft1,
                        onPressed: () => Get.back(),
                        size: UISettings.minButtonSize,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        margin: const EdgeInsets.only(bottom: 60),
                        foregroundColor: context.colorScheme.onBackground,
                        iconStrokeWidth: 1.8,
                        iconSize: 20,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "titleTextHeroTag",
                                child: Text(
                                  'Paramètres',
                                  style: TextStyle(
                                    fontSize: M3FontSizes.headlineLarge,
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // const Hero(
                              //   tag: "descriptionTextHeroTag",
                              //   child: Text(
                              //     "Configurez Flooz pour qu'il corresponde plus à vos exigences.",
                              //     maxLines: null,
                              //     overflow: TextOverflow.visible,
                              //   ),
                              // ),

                              const Text(
                                "Configurez Flooz pour qu'il corresponde plus à vos exigences.",
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                        Hero(
                          tag: 'user_avatar',
                          child: FluAvatar(
                            image: authenticatedUser.avatar,
                            label: authenticatedUser.fullName,
                            outlined: true,
                            outlineGap: 2,
                            size: 50,
                            cornerRadius: 20,
                            margin: const EdgeInsets.only(left: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SepLine(
                margin: EdgeInsets.symmetric(vertical: 35),
              ),
              Padding(
                padding: UISettings.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Options(
                      settingsScreenOptions,
                      lastIsLogout: true,
                      padding: const EdgeInsets.only(bottom: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}
