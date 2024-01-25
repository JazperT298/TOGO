import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/line_separator.dart';
// import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

class WithdrawOtpBottomSheet {
  static showBottomSheetWithdrawOTP() {
    var controller = Get.put(WithdrawalController());
    Get.bottomSheet(
      Container(
        height: 50.h,
        width: 100.w,
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Text(
                  LocaleKeys.strTransferSummary.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Withdraw ', // 'Vous allez envoyer de l’argent à ',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Normal',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Text(
                  'Point of sale'.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Name',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.nickname.value,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                child: const LineSeparator(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Text(
                  LocaleKeys.strTransferDetails.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Frais',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.fees.value.isEmpty
                              ? '0 FCFA'
                              : '${StringHelper.formatNumberWithCommas(int.parse(controller.fees.value.replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.strTransferAmount.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.amount.isEmpty
                              ? '0 FCFA'
                              : '${StringHelper.formatNumberWithCommas(int.parse(controller.amount.toString()))} FCFA',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                child: FluTextField(
                    inputController: controller.code,
                    hint: LocaleKeys.strCodeSecret.tr, // "Votre code secret",
                    height: 50,
                    cornerRadius: 15,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    fillColor: const Color(0xFFF4F5FA),
                    cursorColor: const Color(0xFF27303F),
                    hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                    textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                    onFieldSubmitted: (p0) async {
                      if (controller.code.text.isNotEmpty) {
                        AppGlobal.dateNow = DateTime.now().toString();
                        AppGlobal.timeNow = DateTime.now().toString();
                        controller.enterPinToTransactWithdrawal(code: controller.code.text);
                      } else {
                        Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                      }
                    }),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: FluButton.text(
                  'Validate',
                  suffixIcon: FluIcons.checkCircleUnicon,
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    if (controller.code.text.isNotEmpty) {
                      AppGlobal.dateNow = DateTime.now().toString();
                      AppGlobal.timeNow = DateTime.now().toString();
                      controller.enterPinToTransactWithdrawal(code: controller.code.text);
                    } else {
                      Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    }
                  },
                  height: 55,
                  width: 100.w,
                  cornerRadius: UISettings.minButtonCornerRadius,
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25,
                      spreadRadius: 3,
                      offset: Offset(0, 5),
                    )
                  ],
                  textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}