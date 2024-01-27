import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

class WithdrawMenuBottomSheet extends StatelessWidget {
  const WithdrawMenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final controller = Get.put(WithdrawalController());
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * .025),
          child: Text(
            'Withdrawal of money'.toUpperCase(),
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * .025),
          child: Text(
            'Yorem ipsum dolor sit amet, adipiscing elit.',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
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
      // padding: UISettings.pagePadding.copyWith(
      //   top: MediaQuery.of(context).size.height * .025,
      //   bottom: MediaQuery.of(context).size.height * .025,
      // ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .025,
              ),
              child: header,
            ),
            InkWell(
              onTap: () {
                Get.back();
                AppGlobal.siOTPPage = false;
                AppGlobal.dateNow = '';
                AppGlobal.timeNow = '';
                controller.code.clear();
                controller.checkPendingCashout();
              },
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * .025),
                child: Container(
                    height: 9.h,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                          child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Normal withdrawal',
                              style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Worem ipsum dolor sit amet ...',
                              style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ).paddingOnly(bottom: 12),
            InkWell(
              onTap: () {
                Get.back();
                AppGlobal.siOTPPage = false;
                AppGlobal.dateNow = '';
                AppGlobal.timeNow = '';
                // showModalBottomSheet(
                //     isScrollControlled: true,
                //     context: context,
                //     builder: (context) => _ModalBottomSheet(
                //           sendType: LocaleKeys.strInternationalTransfer.tr,
                //           siOTPPage: AppGlobal.siOTPPage,
                //           child: EnvoiInternationalBottomSheet(
                //             sendType: LocaleKeys.strInternationalTransfer.tr,
                //           ),
                //         ));
              },
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * .025),
                child: Container(
                    height: 9.h,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                          child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WIthdrawal collection',
                              style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Worem ipsum dolor sit amet ...',
                              style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ).paddingOnly(bottom: 12),
            InkWell(
              onTap: () {
                Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                    backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
              },
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * .025),
                child: Container(
                    height: 9.h,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                          child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Withdrawal counter',
                              style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Worem ipsum dolor sit amet ...',
                              style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
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
                    ? MediaQuery.of(context).size.height * .55
                    : MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
            ),
            child: child),
      );
    });
  }
}
