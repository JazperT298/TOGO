// ignore_for_file: unused_local_variable, unused_import, avoid_print, unnecessary_null_comparison, prefer_const_constructors, constant_identifier_names, use_build_context_synchronously, unused_field, deprecated_member_use, unused_element, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/data/models/transac_reponse.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/dialog/send_menu_dialog.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_search_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/transac_success.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/app/providers/transaction_provider.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/common/parser_validator.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/utils/constants/app_string_confirmation.dart';
import 'package:ibank/utils/constants/app_string_validation.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:xml/xml.dart' as xml;
import 'package:ibank/utils/string_utils.dart';

enum NetState { OFFNET, ONNET }

enum FieldType { NORMAL, PHONEBOOK }

class EnvoiModalBottomSheet extends StatefulWidget {
  final String? countryCode;
  final String? formatPhone;
  const EnvoiModalBottomSheet({super.key, required this.sendType, this.countryCode, this.formatPhone});
  final String sendType;

  @override
  State<EnvoiModalBottomSheet> createState() => _EnvoiModalBottomSheetState();
}

class _EnvoiModalBottomSheetState extends State<EnvoiModalBottomSheet> {
  static final PageController pageController = PageController();
  static final numberEditingCobntroller = TextEditingController();
  static final amountEditingController = TextEditingController();
  static final codeEditingController = TextEditingController();
  static bool isKeyboardVis = false;
  final String _selectedCountryCode = '+228'; // Default country code
  static String phoneContactNumer = '';
  static String countryCodes = '';
  static bool isTextFieldEmpty = false;
  static bool isInvalidCode = false;
  static String invalidCodeString = '';

  static bool isLoading = false;
  static final message = StringBuffer();
  static final notifymessage = StringBuffer();

  static FieldType? fieldtype;

  static String messageType = '';

  static List<TransacResponse>? myDataList;

  static TransacResponse? transacResponse;

  static TransactionFee? transactionFee;

  // 96 04 78 78
  @override
  void initState() {
    numberEditingCobntroller.clear();
    amountEditingController.clear();
    codeEditingController.clear();
    super.initState();
  }

  static final controller =
      Get.put(SendMoneyController()); // void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  static void toNextStep() async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text(LocaleKeys.strPleaseWiat.tr),
            ],
          ),
        );
      },
    );

    // Delay for 3 seconds
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(Get.context!).pop(); // Close the alert dialog

      // Navigate to the next page
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
    });
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void onUserSelected(String usersNumber, String countryCode) {
    setState(() {
      print('phoneContactNumer $usersNumber');
      numberEditingCobntroller.text = '${countryCode.replaceAll("+", "")} $usersNumber'; //countryCode.toString()  usersNumber.toString();
      AppGlobal.phonenumberspan = usersNumber
          .toString()
          .replaceAll("[^0-9]", ""); //Html(data: "<a href=\"${usersNumber.phoneNumber!.replaceAll("[^0-9]", "")}\">${usersNumber.fullName}</a>");
    });
  }

  @override
  Widget build(BuildContext context) {
    final action = WalletAction.getAll()[1];
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          action.name.toUpperCase(),
          // widget.sendType,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
        ),
        Text(
          LocaleKeys.strTransferHeader.tr,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            LocaleKeys.strTransferHeaderDesc.tr,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
          ),
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
      ],
    );
    final header1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.strWalletSend.tr.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: LocaleKeys.strTransferInfo.tr, // 'Vous allez envoyer de l’argent à ',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
              ),
              numberEditingCobntroller.text.length <= 11
                  ? TextSpan(
                      text: '\n+${numberEditingCobntroller.text.toString()}',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                    )
                  : TextSpan(
                      text: '\n+228 ${numberEditingCobntroller.text.toString()}',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Color(0xFF124DE5), fontSize: 22),
                    ),
            ],
          ),
        ),
        // FluLine(
        //   height: 1,
        //   width: double.infinity,
        //   margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
        // ),
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
      ],
    );
    final header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.strTransferSummary.tr.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
        ),
        Text(
          widget.sendType,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 22),
        ),
        const SizedBox(height: 24),
        Text(
          LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Name',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                'N/A',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // widget.sendType.contains(LocaleKeys.strNationalTransfer.tr)
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Expanded(
        //             child: Text(
        //               LocaleKeys.strTransferFirstName.tr, //'Prénom',
        //               style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        //             ),
        //           ),
        //           Expanded(
        //             child: Text(
        //               'Razack',
        //               style: TextStyle(
        //                 fontSize: 14.sp,
        //                 color: context.colorScheme.onSurface,
        //               ),
        //             ),
        //           ),
        //         ],
        //       )
        //     : const SizedBox.shrink(),
        // const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                LocaleKeys.strTransferNumber.tr, //       'Numéro',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                numberEditingCobntroller.text.toString(),
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        const LineSeparator(color: Colors.grey),
        const SizedBox(height: 24),
        Text(
          LocaleKeys.strTransferDetails.tr.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
        ),
        const SizedBox(height: 18),
        Row(
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
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                LocaleKeys.strTransferAmount.tr,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                amountEditingController.text.isEmpty
                    ? '0 FCFA'
                    : '${StringHelper.formatNumberWithCommas(int.parse(amountEditingController.text.toString()))} FCFA',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
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
            Row(
              // widget.sendType.contains('Transfert National')
              children: [
                Expanded(
                  child: FluTextField(
                    hint: LocaleKeys.strTransferRecipientNumber.tr, // "Numéro du destinataire",
                    inputController: numberEditingCobntroller,
                    hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Color(0xFF27303F), fontSize: 14),
                    textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                    ],
                    fillColor: Color(0xFFF4F5FA),
                    cursorColor: Color(0xFF27303F),
                    onChanged: (text) {
                      // Remove any existing spaces
                      text = text.replaceAll(" ", "");
                      // Add a space after every two characters
                      if (text.length % 2 == 0) {
                        text = text.replaceAllMapped(
                          RegExp(r'.{2}'),
                          (match) => '${match.group(0)} ',
                        );
                      }
                      numberEditingCobntroller.value = numberEditingCobntroller.value.copyWith(
                        text: text,
                        selection: TextSelection.collapsed(offset: text.length),
                      );
                      setState(() {
                        isTextFieldEmpty = false;
                      });
                    },

                    // onFieldSubmitted: (p0) {
                    //   print(numberEditingCobntroller.text.trim().toString().length);
                    //   if (numberEditingCobntroller.text.isNotEmpty && numberEditingCobntroller.text.trim().toString().length == 11) {
                    //     if (numberEditingCobntroller.text.contains(" ")) {
                    //       log("wala ge input ang 228");
                    //       String replacedString = numberEditingCobntroller.text.replaceAll(" ", "").trim().toString();
                    //       String msisdn = (_selectedCountryCode + replacedString).replaceAll("+", "").toString();
                    //       log(msisdn);
                    //       log(_selectedCountryCode);

                    //       if (msisdn.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                    //         onVerifySmidnSubmit(msisdn, amountEditingController, context);
                    //       } else {
                    //         Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    //       }
                    //     } else {
                    //       log("ge input ang 228");
                    //       log(numberEditingCobntroller.text);
                    //       if (numberEditingCobntroller.text.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                    //         String stringRemoveCountryCode = numberEditingCobntroller.text.substring(3);
                    //         String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                    //         onVerifySmidnSubmit(numberEditingCobntroller.text, amountEditingController, context);
                    //       } else {
                    //         Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    //       }
                    //     }

                    //     isTextFieldEmpty = false;
                    //   } else if (numberEditingCobntroller.text.isEmpty) {
                    //     setState(() {
                    //       isTextFieldEmpty = true;
                    //     });
                    //   } else if (numberEditingCobntroller.text.trim().toString().length != 11) {
                    //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    //   }
                    //   // if (numberEditingCobntroller.text.isNotEmpty && numberEditingCobntroller.text.length < 11) {
                    //   //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    //   // } else if (numberEditingCobntroller.text.isNotEmpty || numberEditingCobntroller.text.contains('99 99 02 28')) {
                    //   //   // AppGlobal.isEditedTransferNational = true;
                    //   //   // AppGlobal.isSubscribedTransferNational = false;
                    //   //   // AppGlobal.isOtherNetTransferNational = false;
                    //   //   onVerifySmidnSubmit(numberEditingCobntroller, amountEditingController, context);
                    //   //   // addNumberFromReceiver(numberEditingCobntroller.text, '${Get.find<DevicePlatformServices>().deviceID}');
                    //   //   isTextFieldEmpty = false;
                    //   //   setState(() {});
                    //   //   if (phoneContactNumer == null) {
                    //   //     AppGlobal.phonenumberspan = null;
                    //   //   }
                    //   // } else {
                    //   //   setState(() {
                    //   //     isTextFieldEmpty = true;
                    //   //   });
                    //   // }
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(width: 1.5, color: Colors.grey, height: 20),
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: ModalBottomSheet(child: EnvoiModalBottomSheet(sendType: widget.sendType)))).then((value) {
                      if (value != null) {
                        setState(() {
                          print('value 2 $value');
                          phoneContactNumer = value['formatPhone'];
                          countryCodes = value['countryCode'];
                          onUserSelected(phoneContactNumer, countryCodes);
                          AppGlobal.isEditedTransferNational = false;
                          // print('selected User ${selectedContact!.fullName}');
                          // print('selected User ${selectedUser!.phoneNumber}');
                        });
                      }
                    });
                    // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                    // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 7.8,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: const FluIcon(
                        FluIcons.userSearch,
                        size: 20,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
            isTextFieldEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.strPhoneNumberRequired.tr,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                LocaleKeys.strContinue.tr, //   'Saisir le montant',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  print(numberEditingCobntroller.text.trim().toString().length);
                  if (numberEditingCobntroller.text.isNotEmpty && numberEditingCobntroller.text.trim().toString().length == 11) {
                    if (numberEditingCobntroller.text.contains(" ")) {
                      print("wala ge input ang 228");
                      String replacedString = numberEditingCobntroller.text.replaceAll(" ", "").trim().toString();
                      String msisdn = (_selectedCountryCode + replacedString).replaceAll("+", "").toString();
                      print(msisdn);
                      print(_selectedCountryCode);

                      if (msisdn.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                        controller.numberController = numberEditingCobntroller;
                        onVerifySmidnSubmit(msisdn, amountEditingController, context);
                      } else {
                        Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                      }
                    } else {
                      print("ge input ang 228");
                      print(numberEditingCobntroller.text);
                      if (numberEditingCobntroller.text.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                        String stringRemoveCountryCode = numberEditingCobntroller.text.substring(3);
                        String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                        onVerifySmidnSubmit(numberEditingCobntroller.text, amountEditingController, context);
                      } else {
                        Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                      }
                    }

                    isTextFieldEmpty = false;
                  } else if (numberEditingCobntroller.text.isEmpty) {
                    setState(() {
                      isTextFieldEmpty = true;
                    });
                  } else if (numberEditingCobntroller.text.trim().toString().length != 11) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                  }
                  // if (numberEditingCobntroller.text.isNotEmpty) {
                  //   onVerifySmidnSubmit(numberEditingCobntroller, amountEditingController, context);
                  //   // addNumberFromReceiver(numberEditingCobntroller.text, '${Get.find<DevicePlatformServices>().deviceID}');
                  //   AppGlobal.isEditedTransferNational = true;
                  //   AppGlobal.isSubscribedTransferNational = false;
                  //   AppGlobal.isOtherNetTransferNational = false;
                  //   isTextFieldEmpty = false;

                  //   if (phoneContactNumer == null) {
                  //     AppGlobal.phonenumberspan = null;
                  //   }
                  // } else {
                  //   setState(() {
                  //     isTextFieldEmpty = true;
                  //   });
                  // }
                },
                height: 55,
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
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
            ),
          ],
        );
      }),
    );

    final page2 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header1,
            const SizedBox(height: 24),
            FluTextField(
              inputController: amountEditingController,
              hint: LocaleKeys.strAmountSend.tr, // "Montant à envoyer",
              hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Color(0xFF27303F), fontSize: 14),
              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
              height: 50,
              cornerRadius: 15,
              keyboardType: TextInputType.number,
              fillColor: Color(0xFFF4F5FA),
              cursorColor: Color(0xFF27303F),
              onChanged: (text) {
                setState(() {
                  isTextFieldEmpty = false;
                });
              },
              onFieldSubmitted: (p0) {
                if (amountEditingController.text.isNotEmpty) {
                  var asd = '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                  if (messageType == 'CASHOFF') {
                    getTransactionFee('WITHDRAW', amountEditingController.text, messageType);
                  } else {
                    getTransactionFee(asd, amountEditingController.text, messageType);
                  }
                  controller.amountController = amountEditingController;
                  AppGlobal.siOTPPage = true;
                  isTextFieldEmpty = false;
                } else {
                  setState(() {
                    isTextFieldEmpty = true;
                  });
                }
              },
            ),
            isTextFieldEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.strAmountSendWarning.tr, //   'Veuillez saisir le montant*',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                LocaleKeys.strContinue.tr, //    'Continuer',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (amountEditingController.text.isNotEmpty) {
                    // TransactionProvider.onSendMoneySubmit(numberEditingCobntroller, amountEditingController, context);
                    var asd = '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                    if (messageType == 'CASHOFF') {
                      getTransactionFee('WITHDRAW', amountEditingController.text, messageType);
                    } else {
                      getTransactionFee(asd, amountEditingController.text, messageType);
                    }
                    controller.amountController = amountEditingController;
                    AppGlobal.siOTPPage = true;
                    isTextFieldEmpty = false;
                  } else {
                    setState(() {
                      isTextFieldEmpty = true;
                    });
                  }
                },
                height: 55,
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
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      }),
    );

    final page3 = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header2,
            const SizedBox(height: 24),
            FluTextField(
                inputController: codeEditingController,
                hint: LocaleKeys.strCodeSecret.tr, // "Votre code secret",
                height: 50,
                cornerRadius: 15,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                fillColor: Color(0xFFF4F5FA),
                cursorColor: Color(0xFF27303F),
                hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Color(0xFF27303F), fontSize: 14),
                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                ],
                onChanged: (p0) {
                  setState(() {
                    isInvalidCode = false;
                    invalidCodeString = '';
                  });
                },
                onFieldSubmitted: (p0) async {
                  if (codeEditingController.text.isNotEmpty) {
                    if (codeEditingController.text.isEmpty) {
                      showToast(context, LocaleKeys.strCodeSecretEmpty.tr);
                      isInvalidCode = true;
                      invalidCodeString = LocaleKeys.strCodeSecretEmpty.tr;
                      // } else if (!codeEditingController.text.trim().contains('4512')) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return const AlertDialog(
                      //         content: Row(
                      //           // mainAxisSize: MainAxisSize.min,
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             CircularProgressIndicator(),
                      //             SizedBox(width: 16.0),
                      //             Text('Please wait...'),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   );
                      //   await Future.delayed(const Duration(seconds: 5), () {
                      //     Navigator.of(context).pop(); // Close the alert dialog

                      //     // Navigate to the next page
                      //     Get.toNamed(AppRoutes.TRANSACFAILED);
                      //   });
                    } else {
                      setState(() {
                        AppGlobal.dateNow = DateTime.now().toString();
                        AppGlobal.timeNow = DateTime.now().toString();
                        addNumberFromReceiver(numberEditingCobntroller.text, Get.find<DevicePlatformServices>().deviceID);
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16.0),
                                Text(LocaleKeys.strPleaseWiat.tr),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                }),
            isInvalidCode == true
                ? Center(
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        invalidCodeString,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                LocaleKeys.strvalidate.tr,
                suffixIcon: FluIcons.checkCircleUnicon,
                iconStrokeWidth: 1.8,
                onPressed: () async {
                  if (codeEditingController.text.isNotEmpty) {
                    setState(() {
                      addNumberFromReceiver(numberEditingCobntroller.text, Get.find<DevicePlatformServices>().deviceID);
                    });
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 16.0),
                              Text(LocaleKeys.strPleaseWiat.tr),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (codeEditingController.text.isNotEmpty) {
                    setState(() {
                      isInvalidCode = true;
                      invalidCodeString = LocaleKeys.strCodeSecretInvalid.tr;
                      // "Code invalide. S'il vous plaît essayer à nouveau";
                    });
                  } else if (codeEditingController.text.isEmpty) {
                    setState(() {
                      isInvalidCode = true;
                      invalidCodeString = LocaleKeys.strCodeSecretEmpty.tr;
                    });
                  }
                },
                height: 55,
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
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      }),
    );

    final searchPage = SingleChildScrollView(
      padding: UISettings.pagePadding.copyWith(
        top: MediaQuery.of(context).size.height * .025,
        bottom: MediaQuery.of(context).size.height * .025,
      ),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header2,
            const SizedBox(height: 24),
            FluTextField(
              hint: "Votre code secret",
              height: 50,
              cornerRadius: 15,
              textAlign: TextAlign.center,
              hintStyle: TextStyle(fontSize: 11.sp),
              textStyle: TextStyle(fontSize: 11.sp),
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
            ),
            const SizedBox(height: 35),
            Visibility(
              visible: isKeyboardVisible ? false : true,
              child: FluButton.text(
                'Valider',
                suffixIcon: FluIcons.checkCircleUnicon,
                iconStrokeWidth: 1.8,
                // onPressed: () => KRouter.to(context, Routes.transactionComplete),
                onPressed: () {
                  AppGlobal.siOTPPage = false;
                },
                height: 55,
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
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
            ),
            const SizedBox(height: 30),
          ],
        );
      }),
    );
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        page1,
        page2,
        page3,
      ],
    );
  }

  //vshould verify the receiver
  static void addNumberFromReceiver(String msisdn, String token) async {
    try {
      // var strToken = await SqlHelper.getToken();
      // print(AppGlobal.MSISDN);
      // print('strToken ${strToken!.replaceAll(".", "")}');
      // var toe = strToken.replaceAll(".", "");
      log('AppGlobal.MSISDN ${AppGlobal.MSISDN}');
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body><n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">VRFY ANDROIDAPP ${Get.find<DevicePlatformServices>().deviceID} ANDROID 3.0.1.0 F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">false</sendsms>
          </n0:RequestToken></v:Body></v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString);
        var decodedData = jsonDecode(jsonString);
        String description = decodedData['description'];
        if (description.contains('TOKEN_FOUND')) {
          var asd = '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
          log(asd);

          sendMoneyToReceiver(
              asd, Get.find<DevicePlatformServices>().deviceID, amountEditingController.text, codeEditingController.text, messageType);
          // // } else if (description.contains('VERSION NOT UP TO DATE')) {
        } else {
          isInvalidCode = true;
          if (!description.contains('TOKEN_NOT_FOUND')) {
            invalidCodeString = description;
          } else if (description.contains('TOKEN_NOT_FOUND')) {
            await Future.delayed(Duration(seconds: 1), () {});
            await SharedPrefService.logoutUserData(false, '').then((value) {
              ProgressAlertDialog.showALoadingDialog(Get.context!, LocaleKeys.strLogoutMessage.tr, 3, AppRoutes.LOGIN);
            });
            Get.snackbar("Message", LocaleKeys.strSessionExpired.tr,
                backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: Duration(seconds: 5));
          }
        }
        // var jsonResponse = jsonDecode(jsonString);
        print('JSON Response: $jsonString');
      } else {
        Get.snackbar("Message", 'An Error Occured', backgroundColor: Colors.lightBlue, colorText: Colors.white);

        print('asda ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Message", e.toString(), backgroundColor: Colors.lightBlue, colorText: Colors.white);
      print('addNumberFromReceiver $e');
    }
  }

  static void getNameNumber() {}

  static void getTransactionFee(String msisdn, String amounts, String mess) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
   <soapenv:Header/>
   <soapenv:Body>
      <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
         <destmsisdn xsi:type="xsd:string">$msisdn</destmsisdn>
         <keyword xsi:type="xsd:string">$mess</keyword>
         <value xsi:type="xsd:string">$amounts</value>
      </app:getTransactionFee>
   </soapenv:Body>
</soapenv:Envelope>''';
      log('getTransactionFee ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('getTransactionFee jsonString 1 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');
        var asd = '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        transactionFee = TransactionFee.fromJson(jsonData);
        controller.fees.value = transactionFee!.sender;

        toNextStep();
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      showMessageDialog(message: e.toString());
    }
  }

  //1111 and code if kani 22879397111 nga user
  // 99990137
  static void sendMoneyToReceiver(String msisdn, String token, String amounts, String code, String mess) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body>
          <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">$mess $msisdn $amounts $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token><sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson></v:Body></v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      log(request.body);

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('result 2 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        var documentss = xml.XmlDocument.parse(parseResult);
        var requestTokenReturnElement = document.findAllElements('RequestTokenJsonReturn').single;

        if (jsonString.contains('Transfert reussi')) {
          String trimString = jsonString.replaceAll('Transfert reussi', '');
          log('LINES $trimString');

          // String inputString = "'''$trimString'''";
          String inputString = '''$trimString''';
          var lines = inputString.trim().split('\r\n');
          var jsonMap = {};
          log('LINES 1 ${lines.toString()}');

          Map<String, dynamic> jsonData = jsonDecode(trimString);

          transacResponse = TransacResponse.fromJson(jsonData);

          for (var line in lines) {
            var parts = line.split(':');
            if (parts.length == 2) {
              var key = parts[0].trim();
              var value = parts[1].trim();
              jsonMap[key] = value;
            }
            if (parts.length == 3) {
              var trioPart = line.split(',');
              for (var lin in trioPart) {
                var finLine = lin.split(':');
                var key = finLine[0].trim();
                var value = finLine[1].trim();
                jsonMap[key] = value;
              }
            }
            if (parts.length == 4) {
              String date = line.replaceAll('Date:', '');
              var dateformatList = date.trim().toString().split(" ");
              jsonMap['Date'] = dateformatList[0];
              jsonMap['Time'] = dateformatList[1];
            }
          }
          var dataEncoded = jsonEncode(jsonMap);
          var dataDecoded = jsonDecode(dataEncoded);
          log(dataDecoded.toString());

          Get.back();
          Get.back();
          Get.find<StorageServices>().saveHistoryTransaction(message: jsonString, service: LocaleKeys.strNationalTransfer.tr);

          int msgId = jsonData["msgid"];
          if (msgId == 0 && messageType == "APPCASH" || msgId == 3010 && messageType == "CASHOFF") {
            Get.toNamed(AppRoutes.TRANSACCOMPLETE, arguments: {'msisdn': msisdn, 'amounts': amounts, 'trimString': trimString});
          } else {
            Get.toNamed(AppRoutes.TRANSACFAILED, arguments: {'jsonString': jsonString});
          }
        } else {
          Get.back();
          Get.find<StorageServices>().saveHistoryTransaction(message: jsonString, service: LocaleKeys.strNationalTransfer.tr);
          // showMessageDialog(message: jsonString);
          log('response jsonString $jsonString');
          Get.toNamed(AppRoutes.TRANSACFAILED, arguments: {'jsonString': jsonString});

          invalidCodeString = jsonString;
        }
      } else {
        log('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      Get.back();
      showMessageDialog(message: 'An Error occured! Please try again later');

      log("ERROR $_");
    } catch (e) {
      log('asd $e');
      Get.back();
      Get.back();
      showMessageDialog(message: 'An Error occured! Please try again later');
    }
    isInvalidCode = false;
  }

  Map<String, dynamic> parseInnerStringToMap(String innerString) {
    Map<String, dynamic> result = {};
    List<String> lines = innerString.split('\n');

    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        List<String> parts = line.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          String value = parts[1].trim();
          result[key] = value;
        }
      }
    }

    return result;
  }

  String xmlToJson(String xmlString) {
    var document = xml.XmlDocument.parse(xmlString);
    var jsonString = jsonEncode(_xmlToJson(document.rootElement));
    return jsonString;
  }

  Map<String, dynamic> _xmlToJson(xml.XmlElement node) {
    Map<String, dynamic> json = {};

    node.children.whereType<xml.XmlElement>().forEach((child) {
      var key = child.name.local;
      var value = _xmlToJson(child);

      if (json.containsKey(key)) {
        if (json[key] is List) {
          json[key].add(value);
        } else {
          json[key] = [json[key], value];
        }
      } else {
        json[key] = value;
      }
    });

    if (node.children.isEmpty) {
      json = node.text as Map<String, dynamic>;
    }

    return json;
  }

  Map<String, dynamic> parseTransferDetails(String transferDetails) {
    Map<String, dynamic> transferInfo = {};
    List<String> lines = transferDetails.split('\n');

    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        List<String> parts = line.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          String value = parts[1].trim();
          transferInfo[key] = value;
        }
        if (parts.length == 3) {
          var trioPart = line.split(',');
          for (var lin in trioPart) {
            var finLine = lin.split(':');
            var key = finLine[0].trim();
            var value = finLine[1].trim();
            transferInfo[key] = value;
          }
        }
      }
    }

    return transferInfo;
  }

  static void onVerifySmidnSubmit(String msisdn, TextEditingController amountEditingController, BuildContext context) async {
    try {
      fieldtype = FieldType.NORMAL;
      // }
      log('onSendMoneySubmit fieldtype 1 $fieldtype');
      log('onSendMoneySubmit fieldtype 2 $msisdn');

      if (AppGlobal.isEditedTransferNational) {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed == false && res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          messageType = 'CASHOFF';
          toNextStep();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType = 'APPCASH';
          toNextStep();
        }
      } else {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed == false && res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          messageType = 'CASHOFF';
          toNextStep();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType = 'APPCASH';
          toNextStep();
        }
      }
      log('onSendMoneySubmit messageType $messageType');
    } catch (ex) {
      Get.back();
      log('onSendMoneySubmit ex $ex');
    }
  }

  void showProgressDialog(BuildContext context, String progressMessage) {
    if (isLoading == true) {
      ProgressAlertDialog.progressAlertDialog(context, progressMessage);
    } else {
      null;
    }
  }

  static void showToast2(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static void resetMessage() {
    if (AppGlobal.message.length > 0) {
      AppGlobal.message.write(AppGlobal.message.length);
    }
    if (AppGlobal.notifymessage.length > 0) {
      AppGlobal.notifymessage.write(AppGlobal.notifymessage.length);
    }
    if (AppGlobal.shortcode.length > 0) {
      AppGlobal.shortcode.write(AppGlobal.shortcode.length);
    }
  }

  static showMessageDialog({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        )));
  }
}
