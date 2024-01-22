import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_international_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_national_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

class EnvoiMenuBottomSheet extends StatelessWidget {
  const EnvoiMenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.strWalletSend.tr.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          LocaleKeys.strMoneyTransferTitle.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child: Text(
        //     LocaleKeys.strTransferHeaderDesc.tr,
        //     style: TextStyle(
        //       color: Colors.transparent,
        //       fontSize: 10.sp,
        //     ),
        //   ),
        // ),
        Row(
          children: [
            FluLine(
              width: 25.w,
              color: context.colorScheme.secondary,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .035),
            ),
            CircleAvatar(
              radius: 1.w,
              backgroundColor: context.colorScheme.secondary,
            )
          ],
        ),
      ],
    );

    final page1 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            GestureDetector(
              onTap: () {
                Get.back();
                AppGlobal.siOTPPage = false;
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => _ModalBottomSheet(
                          sendType: LocaleKeys.strNationalTransfer.tr,
                          siOTPPage: AppGlobal.siOTPPage,
                          child: EnvoiModalBottomSheet(
                            sendType: LocaleKeys.strNationalTransfer.tr,
                          ),
                        ));
              },
              child: Container(
                  height: 9.h,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Text(LocaleKeys.strWalletSend.tr, style: const TextStyle(color: Colors.black))),
                      const SizedBox(height: 12),
                      Text(
                        LocaleKeys.strNationalTransfer.tr,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ).paddingOnly(bottom: 12),
            GestureDetector(
              onTap: () {
                Get.back();
                AppGlobal.siOTPPage = false;
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => _ModalBottomSheet(
                          sendType: LocaleKeys.strInternationalTransfer.tr,
                          siOTPPage: AppGlobal.siOTPPage,
                          child: EnvoiInternationalBottomSheet(
                            sendType: LocaleKeys.strInternationalTransfer.tr,
                          ),
                        ));
              },
              child: Container(
                  height: 9.h,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Text(LocaleKeys.strWalletSend.tr, style: const TextStyle(color: Colors.black))),
                      const SizedBox(height: 12),
                      Text(
                        LocaleKeys.strInternationalTransfer.tr,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ).paddingOnly(bottom: 12),
            GestureDetector(
              onTap: () {
                Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                    backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
              },
              child: Container(
                  height: 9.h,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Text(LocaleKeys.strWalletSend.tr, style: const TextStyle(color: Colors.black))),
                      const SizedBox(height: 12),
                      Text(
                        LocaleKeys.strReversal.tr,
                        style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 35),
            // Visibility(
            //   visible: isKeyboardVisible ? false : true,
            //   child: FluButton.text(
            //     LocaleKeys.strEnterAmount.tr, //   'Saisir le montant',
            //     suffixIcon: FluIcons.arrowRight,
            //     iconStrokeWidth: 1.8,
            //     onPressed: () {},
            //     height: 55,
            //     width: MediaQuery.of(context).size.width * 16,
            //     cornerRadius: UISettings.minButtonCornerRadius,
            //     backgroundColor: context.colorScheme.primary,
            //     foregroundColor: context.colorScheme.onPrimary,
            //     boxShadow: [
            //       BoxShadow(
            //         color: context.colorScheme.primary.withOpacity(.35),
            //         blurRadius: 25,
            //         spreadRadius: 3,
            //         offset: const Offset(0, 5),
            //       )
            //     ],
            //     textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
            //   ),
            // ),
          ],
        );
      }),
    );

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        page1,
      ],
    );
  }
}

class _ModalBottomSheet extends StatelessWidget {
  const _ModalBottomSheet({required this.child, required this.sendType, required this.siOTPPage});

  final Widget child;
  final String sendType;
  final bool siOTPPage;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: isKeyboardVisible
                ? AppGlobal.siOTPPage == true
                    ? MediaQuery.of(context).size.height * .5
                    : MediaQuery.of(context).size.height * .3
                : AppGlobal.siOTPPage == true
                    ? MediaQuery.of(context).size.height * .63
                    : MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
            ),
            child: child),
      );
    });
  }
}
