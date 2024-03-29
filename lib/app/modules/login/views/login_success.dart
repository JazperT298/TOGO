// ignore_for_file: prefer_const_constructors

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class LoginSuccess extends StatefulWidget {
  const LoginSuccess({super.key});

  @override
  State<LoginSuccess> createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  bool showProgressIndicator = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showProgressIndicator = false;
      });
    });
    super.initState();
  }

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
            padding:
                UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                showProgressIndicator
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 120),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: const CircularProgressIndicator(
                            strokeWidth: 6,
                            color: Colors.green,
                          ),
                        ),
                      )
                    : Image.asset(
                        AppImages.transacSuccess,
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.height * .3,
                      ),
                Padding(
                  padding: UISettings.pagePadding
                      .copyWith(top: 16, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.strLoginSuccessMessage.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: UISettings.pagePadding
                      .copyWith(top: 12, left: 24, right: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'The operation was carried out successfully. You can view the details in the transaction history.', //    "L'opération a été confirmée avec succès. Vous pouvez consulter les détails dans l'historique des transactions.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
                const Spacer(),
                FluButton.text(
                  LocaleKeys.strClose.tr,
                  iconStrokeWidth: 1.8,
                  onPressed: showProgressIndicator
                      ? null
                      : () {
                          Get.find<StorageServices>()
                              .isLoginSuccessClick(isLoginSuccessClick: true);
                          Get.offAllNamed(AppRoutes.BOTTOMNAV);
                        },
                  height: 7.h,
                  width: MediaQuery.of(context).size.width * 16,
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
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
