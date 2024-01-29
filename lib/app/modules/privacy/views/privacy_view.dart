// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/privacy/controller/privacy_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Obx(
            () => Stack(
              children: [
                if (controller.isLoadingPrivacy.value == true)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: loadingContainer(),
                  ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.5.h),
                          Text(
                            LocaleKeys.strPrivacyPolicy.tr.toUpperCase(),
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 14),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Gorem ipsum dolor sit \namet.',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Nunc vulputate libero et velit interdum.',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac ',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus. Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. ',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Nunc vulputate libero et velit interdum.',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac ',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus. Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. ',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 110),
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
                              LocaleKeys.strDecline.tr,
                              iconStrokeWidth: 1.8,
                              onPressed: () {
                                // Get.find<StorageServices>().isPrivacyCheck(isClick: false);
                                showWarningDialog(context);
                              },
                              height: 5.8.h,
                              width: MediaQuery.of(context).size.width * .40,
                              cornerRadius: UISettings.minButtonCornerRadius,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              border: const BorderSide(color: Color(0xFFFB6404)),
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: const Color(0xFFFB6404)),
                            ),
                            FluButton.text(
                              LocaleKeys.strAccept.tr,
                              iconStrokeWidth: 1.8,
                              onPressed: () {
                                controller.privacyAcceptButtonClick();
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
      ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: double.infinity,
      //   color: Colors.green,
      // ),
      // Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 100, width: double.infinity, color: Colors.red))
    );
  }

  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.strWarning.tr),
          content: Text(LocaleKeys.strWarningMessage.tr),
          actions: [
            TextButton(
              onPressed: () {
                Get.find<StorageServices>().isPrivacyCheck(isPrivacyCheck: true);
                Get.offAllNamed(AppRoutes.LOGINSECURITYCODE);
              },
              child: Text(LocaleKeys.strOk.tr),
            ),
          ],
        );
      },
    );
  }
}
