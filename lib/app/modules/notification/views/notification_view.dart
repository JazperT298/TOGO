import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/notification/controller/notification_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.13,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 175, 221, 243)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ))),
                        onPressed: () {
                          Get.back();
                        },
                        child: const FluIcon(
                          FluIcons.arrowLeft,
                          size: 30,
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child:
                    Image.asset(
                      AppImages.notificationIcon,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.height * .3,
                    ),
                    // ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You don't have notifications", //    'Opération effectuer avec succèss',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You haven't received any notifications yet.", //    "L'opération a été confirmée avec succès. Vous pouvez consulter les détails dans l'historique des transactions.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
