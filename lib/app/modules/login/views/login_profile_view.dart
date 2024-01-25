import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class LoginProfileView extends StatefulWidget {
  const LoginProfileView({super.key});

  @override
  State<LoginProfileView> createState() => _LoginProfileViewState();
}

class _LoginProfileViewState extends State<LoginProfileView> {
  int selectedImageIndex = -1; // Initialize with an index that represents no selection
  static final galleryEditingCobntroller = TextEditingController();
  String selectedImage = '';
  List<String> imageList = [
    AppImages.profileIcon1,
    AppImages.profileIcon2,
    AppImages.profileIcon3,
    AppImages.profileIcon4,
    AppImages.profileIcon5,
    AppImages.profileIcon6,
    AppImages.profileIcon7,
    AppImages.profileIcon8,
    AppImages.profileIcon9,
    AppImages.profileIcon10,
    AppImages.profileIcon11,
    AppImages.profileIcon12,
    AppImages.profileIcon13,
    AppImages.profileIcon14,
    AppImages.profileIcon15,
    AppImages.profileIcon16,
    AppImages.profileIcon17,
    AppImages.profileIcon18,
    AppImages.profileIcon19,
    AppImages.profileIcon20,
  ];

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Text(
                          'My Profile'.toUpperCase(),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF687997), fontSize: 14),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Finalizing the configuration',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 26),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose an avatar or select a photo from your gallery',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                        ),
                        Row(
                          children: [
                            FluLine(
                              width: 25.w,
                              color: context.colorScheme.secondary,
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
                            ),
                            CircleAvatar(
                              radius: 1.w,
                              backgroundColor: context.colorScheme.secondary,
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        FluTextField(
                          hint: 'Choose from gallery', // "Numéro du destinataire",
                          inputController: galleryEditingCobntroller,
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                          height: 50,
                          cornerRadius: 15,
                          suffixIcon: FluIcons.galleryAdd,
                          iconColor: Colors.white,
                          iconSize: 24,
                          fillColor: const Color(0xFF27303F),
                          keyboardType: TextInputType.none,
                          cursorColor: Colors.transparent,
                        ),
                        // FluButton.text(
                        //   LocaleKeys.strvalidate.tr,
                        //   iconStrokeWidth: 1.8,
                        //   onPressed: () {
                        //     // Get.find<StorageServices>().isPrivacyCheck(isPrivacyCheck: true);
                        //     // // Get.offAllNamed(AppRoutes.LOGINSUCCESS);
                        //     // Get.offAllNamed(AppRoutes.LOGINSECURITYCODE);
                        //   },
                        //   height: 50,
                        //   width: MediaQuery.of(context).size.width,
                        //   cornerRadius: UISettings.minButtonCornerRadius,
                        //   backgroundColor: const Color(0xFF27303F),
                        //   iconSize: 24,
                        //   foregroundColor: context.colorScheme.onPrimary,
                        //   suffixIcon: FluIcons.galleryAdd,
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: context.colorScheme.primary.withOpacity(.35),
                        //       blurRadius: 25,
                        //       spreadRadius: 3,
                        //       offset: const Offset(0, 5),
                        //     )
                        //   ],
                        //   textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFF4F5FA), fontSize: 14),
                        // ),

                        const SizedBox(height: 20),
                        // Display image selection grid
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // You can adjust the number of columns
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: imageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedImageIndex == index) {
                                    selectedImageIndex = -1;
                                  } else {
                                    selectedImageIndex = index;
                                    selectedImage = imageList[index];
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedImageIndex == index
                                        ? Colors.blue // Indicator color when selected
                                        : Colors.transparent,
                                    width: 4.0,
                                  ),
                                ),
                                child: Image.asset(
                                  imageList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .09,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'Later',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              Get.find<StorageServices>().saveOTP(otp: AppImages.userIcon);
                              Get.offAllNamed(AppRoutes.LOGINSUCCESS);
                            },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            border: BorderSide(color: context.colorScheme.primary),
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                          ),
                          FluButton.text(
                            'Confirm',
                            iconStrokeWidth: 1.8,
                            // onPressed: () {
                            //   // Get.find<StorageServices>().isPrivacyCheck(isPrivacyCheck: true);
                            //   // // Get.offAllNamed(AppRoutes.LOGINSUCCESS);
                            //   AppGlobal.userAvatar = AppImages.userIcon;
                            //   // Get.offAllNamed(AppRoutes.LOGINSECURITYCODE);
                            // },
                            onPressed: selectedImage.isEmpty
                                ? null
                                : () {
                                    Get.find<StorageServices>().savePofileImage(image: selectedImage);
                                    Get.offAllNamed(AppRoutes.LOGINSUCCESS);
                                  },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
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
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
