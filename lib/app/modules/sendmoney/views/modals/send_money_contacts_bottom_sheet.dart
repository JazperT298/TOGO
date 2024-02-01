// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks, invalid_use_of_protected_member

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/newfav/controller/newfav_controller.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_colors.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/fontsize_config.dart';

class SendMoneyContactsBottomSheet {
  static void showBottomSheetSendMoneyNationaContacts() {
    final favController = Get.put(NewFavController());
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Wrap(
          children: [
            bottomSheetDivider(),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return Stack(
                children: [
                  Container(
                    height: isKeyboardVisible ? 70.h : 80.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.5.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Text(
                              LocaleKeys.strWalletSend.tr.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFB6404),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                'Select a person.',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: FontSizes.headerLargeText),
                              )),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Text(
                              'Choose the contact you want to send money to.',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Obx(
                              () => FluTextField(
                                hint: "Name or telephone number",
                                height: 6.5.h,
                                inputController:
                                    favController.nameController.value,
                                cornerRadius: 15,
                                onChanged: (query) {
                                  favController.filterContacts(query);
                                },
                                keyboardType: TextInputType.name,
                                fillColor: const Color(0xFFF4F5FA),
                                cursorColor: const Color(0xFF27303F),
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.textFieldText),
                                textStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: FontSizes.textFieldText),
                                suffixIcon: FluIcons.refresh,
                              ),
                            ),
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
                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: favController.displayedContacts
                                    .length, // favorites.length,
                                itemBuilder: ((context, index) {
                                  final option = favController.contacts[index];
                                  return Obx(() => FluButton(
                                        onPressed: () {
                                          if (favController
                                                  .selectedContacts.value ==
                                              favController
                                                  .displayedContacts[index]) {
                                            favController
                                                    .selectedContacts.value =
                                                Contact(); // Deselect the user
                                          } else {
                                            favController
                                                    .selectedContacts.value =
                                                favController.displayedContacts[
                                                    index]; // Select the user
                                            // favController.selectedByUser.value = favController.contacts[index].id;
                                          }
                                        },
                                        backgroundColor: Colors.transparent,
                                        splashFactory: NoSplash.splashFactory,
                                        margin: EdgeInsets.only(
                                            top: index == 0 ? 0 : .7.h),
                                        child: Row(
                                          children: [
                                            FluArc(
                                              startOfArc: 90,
                                              angle: 80,
                                              strokeWidth: 1,
                                              color: context
                                                  .colorScheme.primaryContainer,
                                              child: Container(
                                                height: 8.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors
                                                      .getRandomColor(),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    option.name
                                                        .toString()
                                                        .substring(0, 1),
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white, // You can change the text color
                                                      fontSize: FontSizes
                                                          .headerLargeText, // You can adjust the font size
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          // option.fullName,
                                                          favController
                                                              .displayedContacts[
                                                                  index]
                                                              .displayName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: FontSizes
                                                                  .headerMediumText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: context
                                                                  .colorScheme
                                                                  .onSurface),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h),
                                                          child: Text(
                                                            // option.phoneNumber.toString(),

                                                            favController
                                                                    .displayedContacts[
                                                                        index]
                                                                    .phones
                                                                    .isEmpty
                                                                ? " "
                                                                : favController
                                                                    .displayedContacts[
                                                                        index]
                                                                    .phones[0]
                                                                    .number
                                                                    .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: FontSizes
                                                                  .headerSmallText,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Obx(() => favController
                                                                .displayedContacts
                                                                .value ==
                                                            favController
                                                                    .displayedContacts[
                                                                index]
                                                        ? const FluIcon(
                                                            FluIcons
                                                                .checkCircleUnicon,
                                                            color: Colors.green)
                                                        : const FluIcon(
                                                            FluIcons
                                                                .checkCircleUnicon,
                                                            color: Colors
                                                                .transparent)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).paddingSymmetric(vertical: 1.h));
                                }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: Container(
                          height: 7.h,
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: FluButton.text(
                              'Confirm',
                              iconStrokeWidth: 1.8,
                              onPressed: favController.selectedContacts.value !=
                                      null
                                  ? () async {
                                      FullScreenLoading
                                          .fullScreenLoadingWithTextAndTimer(
                                              'Validating. . .');
                                      await Future.delayed(
                                          const Duration(seconds: 2), () {
                                        favController.formatPhone.value =
                                            StringHelper.formatPhoneNumber(
                                                favController.selectedContacts
                                                    .value.phones[0].number
                                                    .trim());
                                        favController.countryCode.value =
                                            favController.selectedContacts.value
                                                .phones[0].number
                                                .substring(0, 3);

                                        Get.find<SendMoneyController>()
                                                .numberController
                                                .text =
                                            '${favController.countryCode.value.replaceAll("+", "")} ${favController.formatPhone.value}'; //countryCode.toString()  usersNumber.toString();
                                        AppGlobal.phonenumberspan = {
                                          favController.formatPhone.value
                                        }.toString().replaceAll("[^0-9]", "");

                                        Get.back();
                                        Get.back();
                                      });
                                    }
                                  : null,
                              height: 7.h,
                              width: MediaQuery.of(context).size.width * 16,
                              cornerRadius: UISettings.minButtonCornerRadius,
                              backgroundColor: context.colorScheme.primary,
                              foregroundColor: context.colorScheme.onPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: context.colorScheme.primary
                                      .withOpacity(.35),
                                  blurRadius: 25,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 5),
                                )
                              ],
                              textStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFF4F5FA),
                                  fontSize: FontSizes.buttonText),
                            ),
                          ),
                        ),
                      ))
                ],
              );
            }),
          ],
        ),
        isScrollControlled: true);
  }

  static void showBottomSheetSendMoneyInternationaContacts() {}
}
