// ignore_for_file: unused_local_variable, unused_import, avoid_print, unnecessary_null_comparison, prefer_const_constructors, constant_identifier_names, use_build_context_synchronously, unused_field

import 'dart:convert';
import 'dart:developer';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/data/models/user.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/dialog/send_menu_dialog.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_search_bottom_sheet.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/app/providers/transaction_provider.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/common/parser_validator.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/utils/constants/app_string_confirmation.dart';
import 'package:ibank/utils/constants/app_string_validation.dart';
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

  static String? phoneContactNumer;
  static bool isTextFieldEmpty = false;
  static bool isInvalidCode = false;
  static String invalidCodeString = '';

  static bool isLoading = false;
  static final message = StringBuffer();
  static final notifymessage = StringBuffer();

  static FieldType? fieldtype;

  static String messageType = '';

  final controller =
      Get.put(SendMoneyController()); // void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  static void toNextStep() async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16.0),
              Text("S'il vous plaît, attendez..."),
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

  void onUserSelected(String usersNumber) {
    setState(() {
      // selectedContact = usersNumber;
      phoneContactNumer = usersNumber;
      print('phoneContactNumer $phoneContactNumer');
      numberEditingCobntroller.text = phoneContactNumer.toString();
      AppGlobal.phonenumberspan = phoneContactNumer
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
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          'Simple et Rapide',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Veuillez saisir le numéro du destinataire ou choisissez son contact dans votre répertoire téléphonique.',
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Envoi'.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            letterSpacing: 1.0,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Vous allez envoyer de l’argent à ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              TextSpan(
                text: '\n+228 ${numberEditingCobntroller.text.toString()}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        FluLine(
          height: 1,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
        ),
      ],
    );
    final header2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Récapitulatif'.toUpperCase(),
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          widget.sendType,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bénéficiaire'.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 18),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const Expanded(
        //       child: Text(
        //         'Nom',
        //         style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
        //       ),
        //     ),
        //     Expanded(
        //       child: Text(
        //         'Karim Razack',
        //         style: TextStyle(
        //           fontSize: M3FontSizes.headlineTiny,
        //           color: context.colorScheme.onSurface,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 6),
        widget.sendType.contains('Transert National')
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Prénom',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Razack',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Numéro',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Text(
                numberEditingCobntroller.text.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        Text(
          'DETAILS'.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 18),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const Expanded(
        //       child: Text(
        //         'Frais',
        //         style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
        //       ),
        //     ),
        //     Expanded(
        //       child: Text(
        //         '0 FCFA',
        //         style: TextStyle(
        //           fontSize: M3FontSizes.headlineTiny,
        //           color: context.colorScheme.onSurface,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Montant',
                style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Text(
                '${amountEditingController.text.toString()} FCFA',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const LineSeparator(color: Colors.grey),
        const SizedBox(height: 32),
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
                    hint: "Numéro du destinataire",
                    inputController: numberEditingCobntroller,
                    hintStyle: TextStyle(fontSize: 11.sp),
                    textStyle: TextStyle(fontSize: 11.sp),
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.number,
                    fillColor: context.colorScheme.primaryContainer,
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
                    onFieldSubmitted: (p0) {
                      if (numberEditingCobntroller.text.isNotEmpty && numberEditingCobntroller.text.length < 11) {
                        Get.snackbar("Message", 'Numero Invalide', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                      } else if (numberEditingCobntroller.text.isNotEmpty || numberEditingCobntroller.text.contains('99 99 02 28')) {
                        // AppGlobal.isEditedTransferNational = true;
                        // AppGlobal.isSubscribedTransferNational = false;
                        // AppGlobal.isOtherNetTransferNational = false;
                        onVerifySmidnSubmit(numberEditingCobntroller, amountEditingController, context);
                        // addNumberFromReceiver(numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                        isTextFieldEmpty = false;
                        setState(() {});
                        if (phoneContactNumer == null) {
                          AppGlobal.phonenumberspan = null;
                        }
                      } else {
                        setState(() {
                          isTextFieldEmpty = true;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(width: 1.5, color: Colors.grey, height: 20),
                ),
                GestureDetector(
                  onTap: () async {
                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     context: context,
                    //     builder: (context) => Container(
                    //         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    //         child: ModalBottomSheet(child: EnvoiModalBottomSheet(sendType: widget.sendType)))).then((value) {
                    //   if (value != null) {
                    //     setState(() {
                    //       phoneContactNumer = value;
                    //       onUserSelected(phoneContactNumer!);
                    //       AppGlobal.isEditedTransferNational = false;
                    //       // print('selected User ${selectedContact!.fullName}');
                    //       // print('selected User ${selectedUser!.phoneNumber}');
                    //     });
                    //   }
                    // });
                    Get.snackbar("Message", "À venir",
                        backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 7.8,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration:
                          BoxDecoration(color: context.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: const FluIcon(FluIcons.userSearch, size: 20)),
                ),
              ],
            ),
            isTextFieldEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Phone number is required*',
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
                'Saisir le montant',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (numberEditingCobntroller.text.isNotEmpty) {
                    onVerifySmidnSubmit(numberEditingCobntroller, amountEditingController, context);
                    // addNumberFromReceiver(numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                    AppGlobal.isEditedTransferNational = true;
                    AppGlobal.isSubscribedTransferNational = false;
                    AppGlobal.isOtherNetTransferNational = false;
                    isTextFieldEmpty = false;

                    if (phoneContactNumer == null) {
                      AppGlobal.phonenumberspan = null;
                    }
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
              hint: "Montant à envoyer",
              hintStyle: TextStyle(fontSize: 11.sp),
              textStyle: TextStyle(fontSize: 11.sp),
              height: 50,
              cornerRadius: 15,
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
              onChanged: (text) {
                setState(() {
                  isTextFieldEmpty = false;
                });
              },
              onFieldSubmitted: (p0) {
                if (amountEditingController.text.isNotEmpty) {
                  AppGlobal.siOTPPage = true;
                  toNextStep();
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
                      'Veuillez saisir le montant*',
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
                'Continuer',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (amountEditingController.text.isNotEmpty) {
                    // TransactionProvider.onSendMoneySubmit(numberEditingCobntroller, amountEditingController, context);
                    AppGlobal.siOTPPage = true;
                    toNextStep();
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
                hint: "Votre code secret",
                height: 50,
                cornerRadius: 15,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                fillColor: context.colorScheme.primaryContainer,
                hintStyle: TextStyle(fontSize: 11.sp),
                textStyle: TextStyle(fontSize: 11.sp),
                onChanged: (p0) {
                  setState(() {
                    isInvalidCode = false;
                    invalidCodeString = '';
                  });
                },
                onFieldSubmitted: (p0) async {
                  if (codeEditingController.text.isNotEmpty) {
                    if (codeEditingController.text.isEmpty) {
                      showToast(context, 'Le code secret ne doit pas être vide');
                      isInvalidCode = true;
                      invalidCodeString = "Le code secret ne doit pas être vide";
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
                        addNumberFromReceiver(numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16.0),
                                Text("S'il vous plaît, attendez..."),
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
                'Valider',
                suffixIcon: FluIcons.checkCircleUnicon,
                iconStrokeWidth: 1.8,
                onPressed: () async {
                  if (codeEditingController.text.isNotEmpty) {
                    setState(() {
                      addNumberFromReceiver(numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                    });
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(width: 16.0),
                              Text("S'il vous plaît, attendez..."),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (codeEditingController.text.isNotEmpty) {
                    setState(() {
                      isInvalidCode = true;
                      invalidCodeString = "Code invalide. S'il vous plaît essayer à nouveau";
                    });
                  } else if (codeEditingController.text.isEmpty) {
                    setState(() {
                      isInvalidCode = true;
                      invalidCodeString = "Le code secret ne doit pas être vide";
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
      var strToken = await SqlHelper.getToken();
      print('strToken ${strToken!.replaceAll(".", "")}');
      var toe = strToken.replaceAll(".", "");
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body><n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">22899990137</msisdn>
          <message i:type="d:string">VRFY ANDROIDAPP F3C8DEBDBA27B035 ANDROID 3.0.1.0 F</message>
          <token i:type="d:string">1234567890</token>
          <sendsms i:type="d:string">false</sendsms>
          </n0:RequestToken></v:Body></v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
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
          print(asd);
          sendMoneyToReceiver(asd, 'F3C8DEBDBA27B035', amountEditingController.text, codeEditingController.text, messageType);
          // } else if (description.contains('VERSION NOT UP TO DATE')) {
        } else {
          isInvalidCode = true;
          if (!description.contains('TOKEN_NOT_FOUND')) {
            invalidCodeString = description;
          } else if (description.contains('TOKEN_NOT_FOUND')) {
            await Future.delayed(Duration(seconds: 1), () {});
            await SharedPrefService.logoutUserData(false, '').then((value) {
              ProgressAlertDialog.showALoadingDialog(Get.context!, 'Déconnecter...', 3, AppRoutes.LOGIN);
            });
            Get.snackbar("Message", "La session a expiré. Vous avez été déconnecté!...",
                backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: Duration(seconds: 5));
          }
        }
        // var jsonResponse = jsonDecode(jsonString);
        print('JSON Response: $jsonString');
      } else {
        numberEditingCobntroller.clear();
        print('asda ${response.reasonPhrase}');
      }
    } catch (e) {
      print('addNumberFromReceiver $e');
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
          <v:Header /><v:Body><n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">22899990137</msisdn><message i:type="d:string">$mess $msisdn $amounts $code F</message>
          <token i:type="d:string">F3C8DEBDBA27B035</token><sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken></v:Body></v:Envelope>''';
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();

        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        var documentss = xml.XmlDocument.parse(parseResult);
        var requestTokenReturnElement = document.findAllElements('RequestTokenReturn').single;

        if (jsonString.contains('Transfert reussi')) {
          String trimString = jsonString.replaceAll('Transfert reussi', '');
          String inputString = "'''$trimString'''";
          var lines = inputString.trim().split('\n');
          var jsonMap = {};
          log(lines.toString());
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
          showSuccessOrderPlace(message: jsonString);
          // SqlHelper.setTransacHistory("-1", jsonString);
        } else {
          Get.back();
          Get.find<StorageServices>().saveHistoryTransaction(message: jsonString, service: "Transfert National");
          showSuccessOrderPlace(message: jsonString);

          invalidCodeString = jsonString;
        }
      } else {
        numberEditingCobntroller.clear();
        log('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      log("ERROR $_");
    } catch (e) {
      log('asd $e');
    }
    isInvalidCode = false;
    numberEditingCobntroller.clear();
    amountEditingController.clear();
    codeEditingController.clear();
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

  static void onVerifySmidnSubmit(
      TextEditingController numberEditingController, TextEditingController amountEditingController, BuildContext context) async {
    try {
      String msisdn = "";
      print('onSendMoneySubmit AppGlobal.phonenumberspan  ${AppGlobal.phonenumberspan}');
      if (AppGlobal.phonenumberspan != null) {
        // List<dynamic> url = AppGlobal.phonenumberspan.getSpans(0, AppGlobal.phonenumberspan.length) as List<dynamic>;
        msisdn = AppGlobal.phonenumberspan;
        //url[0].url;
        fieldtype = FieldType.PHONEBOOK;
      } else {
        //assign receivers number
        msisdn = numberEditingController.text.replaceAll(" ", "");

        fieldtype = FieldType.NORMAL;
      }
      print('onSendMoneySubmit fieldtype $fieldtype');
      print('onSendMoneySubmit fieldtype $msisdn');
      //msisdn = verifyMsisdn(msisdn);
      if (msisdn.length <= 8) {
        msisdn = ParserValidator.validateMsisdn("228", msisdn, context);
      } else {
        msisdn = ParserValidator.validateMsisdn("", msisdn, context);
      }

      print('onSendMoneySubmit msisdn $msisdn');

      if (StringUtil().isNullOrEmpty(msisdn)) {
        showToast2(context, AppStringValidation.destinationRequired);
        print('onSendMoneySubmit fieldtype ${AppStringValidation.destinationRequired}}');
        return;
      }
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
    } catch (ex) {
      print('onSendMoneySubmit ex $ex');
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

  static showSuccessOrderPlace({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.2,
          width: MediaQuery.of(Get.context!).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Message",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.height * 0.032,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.sp),
              ),
            ],
          ),
        )));
  }
}
