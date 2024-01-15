// ignore_for_file: avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/components/alert_loading.dart';
import 'package:ibank/app/components/line.dart';
import 'package:ibank/app/components/map.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/ui/options.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
  final storage = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    // getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoadingProfile.value
            ? LoadingWidget(
                progressMessage: "Chargement! S'il vous plaît, attendez...",
              )
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
                                          valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: 'user_avatar',
                                      child: GestureDetector(
                                        onTap: () async {
                                          await storage.remove('msisdn').then((value) {
                                            storage.remove('isPrivacyCheck');
                                            storage.remove('isLoginSuccessClick');
                                            ProgressAlertDialog.showALoadingDialog(context, 'Déconnecter...', 3, AppRoutes.LOGIN);
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
                                            AppGlobal.currentAddress.isEmpty ? '' : AppGlobal.currentAddress,
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
                                  backgroundColor: context.colorScheme.background,
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
                            'Agences à proximité.',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          const SizedBox(height: 10),
                          const Hero(
                            tag: "descriptionTextHeroTag",
                            child: Text(
                              'Rendez-vous facilement dans l\'une de nos agences la plus proche. Nous vous y attendons.',
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 45),
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
                    const SepLine(
                      margin: EdgeInsets.only(bottom: 25),
                    ),
                    Padding(
                        padding: UISettings.pagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mon Flooz.',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Options(profileScreenOptions)
                          ],
                        ))
                  ],
                ),
              )),
      ),
    );
  }
}
