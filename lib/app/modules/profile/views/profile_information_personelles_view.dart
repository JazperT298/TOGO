// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/profile/modals/profile_modal_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

import '../controller/profile_controller.dart';

class ProfileInformationPersonellesView extends GetView<ProfileController> {
  const ProfileInformationPersonellesView({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(statusBarIconBrightness: Brightness.dark),
      body: Scaffold(
        body: WillPopScope(
          onWillPop: () => controller.getBack(),
          child: SafeArea(
              child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 175, 221, 243)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ))),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: const FluIcon(
                        FluIcons.arrowLeft,
                        size: 40,
                        strokeWidth: 2,
                        color: Color(0xFF27303F),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Text(
                    LocaleKeys.strAccount.tr.toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 14),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strPersonalInfos.tr.toUpperCase(),
                      //  "INFOS PERSONELLE.",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 26),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(height: 3.h),
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
                SizedBox(height: 3.5.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Stack(
                      children: [
                        Obx(
                          () => controller.selectedImage.value.isEmpty
                              ? SizedBox(
                                  child: AppGlobal.PROFILEAVATAR.isEmpty && AppGlobal.PROFILEIMAGE.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: MediaQuery.of(context).size.height * 0.075,
                                          child: ClipOval(
                                            child: Image.file(
                                              File(AppGlobal.PROFILEIMAGE),
                                            ),
                                          ))
                                      : AppGlobal.PROFILEIMAGE.isEmpty && AppGlobal.PROFILEAVATAR.isNotEmpty
                                          ? Image.asset(AppGlobal.PROFILEAVATAR, height: 52, width: 52)
                                          : Image.asset(AppImages.userIcon, height: 52, width: 52))
                              : CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: MediaQuery.of(context).size.height * 0.075,
                                  child: ClipOval(
                                    child: Image.file(
                                      File(controller.selectedImage.value),
                                    ),
                                  )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 1,
                          child: InkWell(
                            onTap: () {
                              controller.changeProfilePicture();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(color: Color(0xFF124DE5), shape: BoxShape.circle),
                              child: const FluIcon(FluIcons.penUnicon, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.5.h),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strName.tr, //   "Nom",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      controller.name.value,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 16),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strFirstName.tr, // "Prenoms",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      controller.firstname.value,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 16),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strFloozSale.tr, //    "Solde Flooz",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      controller.soldeFlooz.value,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 16),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strCommission.tr, // "Commission",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      controller.commission.value,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 16),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Text(
                      LocaleKeys.strDateOfBirth.tr, //   "Date de naissance",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                    )),
                InkWell(
                  onTap: () {
                    ProfileBottomSheet.showBottomSheetEditEmail();
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text(
                        controller.birthdate.value,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 16),
                      )),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.03,
                // ),
                // Padding(
                //     padding: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.05,
                //       right: MediaQuery.of(context).size.width * 0.05,
                //     ),
                //     child: const Text(
                //       "Email",
                //       style: TextStyle(
                //         fontSize: M3FontSizes.bodySmall,
                //       ),
                //     )),
                // Padding(
                //     padding: EdgeInsets.only(
                //       left: MediaQuery.of(context).size.width * 0.05,
                //       right: MediaQuery.of(context).size.width * 0.05,
                //     ),
                //     child: Text(
                //       "${controller.name.value}@gmail.com",
                //       style: const TextStyle(
                //         fontSize: M3FontSizes.labelLarge,
                //       ),
                //     )),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FluButton.text(
                    'Expand my account',
                    iconStrokeWidth: 1.8,
                    onPressed: () {},
                    height: 55,
                    width: 100.w,
                    cornerRadius: UISettings.minButtonCornerRadius,
                    backgroundColor: const Color(0xFF124DE5),
                    foregroundColor: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: Offset(0, 5),
                      )
                    ],
                    textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                  ),
                ),
                SizedBox(height: 1.h)
              ],
            ),
          )),
        ),
      ),
    );
  }
}
