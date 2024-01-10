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
import 'package:xml/xml.dart' as xml;
import 'package:ibank/utils/string_utils.dart';

enum NetState { OFFNET, ONNET }

enum FieldType { NORMAL, PHONEBOOK }

class EnvoiInternationalBottomSheet extends StatefulWidget {
  const EnvoiInternationalBottomSheet({super.key, required this.sendType});
  final String sendType;

  @override
  State<EnvoiInternationalBottomSheet> createState() => _EnvoiInternationalBottomSheetState();
}

class _EnvoiInternationalBottomSheetState extends State<EnvoiInternationalBottomSheet> {
  static final PageController pageController = PageController();
  static final numberEditingCobntroller = TextEditingController();
  static final amountEditingController = TextEditingController();
  static final codeEditingController = TextEditingController();
  static bool isKeyboardVis = false;
  static User? selectedUser;
  static bool isTextFieldEmpty = false;
  static bool isInvalidCode = false;
  static String invalidCodeString = '';

  static bool isLoading = false;
  static final message = StringBuffer();
  static final notifymessage = StringBuffer();

  static FieldType? fieldtype;

  static String messageType = '';

  String _selectedCountryCode = '+228'; // Default country code
  // final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  late final FlCountryCodePicker countryPicker;

  @override
  void initState() {
    // TODO: implement initState
    countryPicker = FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: false,
      title: title,
    );
    super.initState();
  }

  Widget title = Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 0),
          child: Text('Selectionner'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFFB6404))),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 4.0, left: 0),
          child: Text('Votre pays', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 0),
            child: Text('Choisissez votre pays et bénéficiez d’une expérience personnalisée ainsi que des transactions optimisées.',
                style: TextStyle(fontSize: 14))),
      ],
    ),
  );
  final controller =
      Get.put(SendMoneyController()); // void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  static void toNextStep() async {
    showDialog(
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

  void onUserSelected(User usersNumber) {
    setState(() {
      selectedUser = usersNumber;
      numberEditingCobntroller.text = usersNumber.phoneNumber!;
      AppGlobal.phonenumberspan = usersNumber.phoneNumber!
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
            fontSize: M3FontSizes.headlineSmall,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          'Simple et Rapide',
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Veuillez saisir le numéro du destinataire ou choisissez son contact dans votre répertoire téléphonique.',
            style: TextStyle(
              fontSize: M3FontSizes.titleMedium,
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
            fontSize: M3FontSizes.headlineSmall,
            letterSpacing: 1.0,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Vous allez envoyer de l’argent à ',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              TextSpan(
                text: '+228 ${numberEditingCobntroller.text.toString()}',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineMedium,
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
            fontSize: M3FontSizes.headlineTiny,
            letterSpacing: 1.0,
          ),
        ),
        Text(
          widget.sendType,
          style: TextStyle(
            fontSize: M3FontSizes.headlineMedium,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bénéficiaire'.toUpperCase(),
          style: TextStyle(
            fontSize: M3FontSizes.headlineTiny,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 18),
        const SizedBox.shrink(),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Numéro',
                style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Text(
                numberEditingCobntroller.text.toString(),
                style: TextStyle(
                  fontSize: M3FontSizes.headlineTiny,
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
            fontSize: M3FontSizes.headlineTiny,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Montant',
                style: TextStyle(fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
              ),
            ),
            Expanded(
              child: Text(
                '${amountEditingController.text.toString()} FCFA',
                style: TextStyle(
                  fontSize: M3FontSizes.headlineTiny,
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
                    hintStyle: const TextStyle(fontSize: M3FontSizes.titleMedium),
                    prefix: GestureDetector(
                      onTap: () async {
                        final picked = await countryPicker.showPicker(context: context);
                        // Null check
                        if (picked != null) print(picked.dialCode);
                        setState(() {
                          _selectedCountryCode = picked!.dialCode;
                        });
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 5,
                        padding: EdgeInsets.symmetric(horizontal: _selectedCountryCode.length <= 3 ? 18.0 : 12.0, vertical: 4.0),
                        decoration:
                            BoxDecoration(color: context.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_selectedCountryCode.isEmpty ? '+228' : _selectedCountryCode, style: const TextStyle(color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(width: 1.5, color: Colors.grey, height: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.number,
                    fillColor: context.colorScheme.primaryContainer,
                    textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
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

                        if (selectedUser == null) {
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: ModalBottomSheet(child: EnvoiInternationalBottomSheet(sendType: widget.sendType)))).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedUser = value;
                          onUserSelected(selectedUser!);
                          AppGlobal.isEditedTransferNational = false;
                          print('selected User ${selectedUser!.fullName}');
                          print('selected User ${selectedUser!.phoneNumber}');
                        });
                      }
                    });
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
                        fontSize: M3FontSizes.titleSmall,
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

                    if (selectedUser == null) {
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
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
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
              hintStyle: const TextStyle(fontSize: M3FontSizes.titleMedium),
              height: 50,
              cornerRadius: 15,
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
              textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
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
                        fontSize: M3FontSizes.titleSmall,
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
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
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
                hintStyle: const TextStyle(fontSize: M3FontSizes.titleMedium),
                height: 50,
                cornerRadius: 15,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                fillColor: context.colorScheme.primaryContainer,
                textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                onChanged: (p0) {
                  setState(() {
                    isInvalidCode = false;
                  });
                },
                onFieldSubmitted: (p0) async {
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

                    // Delay for 3 seconds
                    await Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(); // Close the alert dialog

                      print('isInvalidCode $isInvalidCode');
                      if (isInvalidCode == false) {
                        Get.toNamed(AppRoutes.TRANSACCOMPLETE);
                      }
                    });
                    setState(() {});
                    // TransactionProvider.onSendMoneySubmit(numberEditingCobntroller, amountEditingController, context);
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
                          fontSize: M3FontSizes.titleSmall,
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
                    await Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pop(); // Close the alert dialog

                      print('isInvalidCode $isInvalidCode');
                      if (isInvalidCode == false) {
                        Get.toNamed(AppRoutes.TRANSACCOMPLETE);
                      }
                    });
                    setState(() {});
                    // TransactionProvider.onSendMoneySubmit(numberEditingCobntroller, amountEditingController, context);
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
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
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
              keyboardType: TextInputType.number,
              fillColor: context.colorScheme.primaryContainer,
              textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
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
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
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
          <msisdn i:type="d:string">22899990228</msisdn>
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
          sendMoneyToReceiver(asd, 'F3C8DEBDBA27B035', amountEditingController.text, codeEditingController.text, messageType);
          // } else if (description.contains('VERSION NOT UP TO DATE')) {
        } else {
          isInvalidCode = true;
          if (!description.contains('TOKEN_NOT_FOUND')) {
            invalidCodeString = description;
          }
          if (description.contains('TOKEN_NOT_FOUND')) {
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
          <msisdn i:type="d:string">22899990228</msisdn><message i:type="d:string">$mess $msisdn $amounts $code F</message>
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
          String? amounts = dataDecoded['Montant'];
          String? beneficiary = dataDecoded['Beneficiaire'];
          String? date = dataDecoded['Date'].toString();
          String? newBalance = dataDecoded['Nouveau solde Flooz'];
          String? txnId = dataDecoded['Txn ID'];
          String? time = dataDecoded['Time'];

          AppGlobal.beneficiare = beneficiary.toString();
          AppGlobal.date = date.toString();
          AppGlobal.amount = amounts.toString();
          AppGlobal.remainingBal = newBalance.toString();
          AppGlobal.txn = txnId.toString();
          AppGlobal.numbers = msisdn.toString();
          AppGlobal.time = time.toString();

          if (AppGlobal.numbers == AppGlobal.beneficiare) {
            AppGlobal.beneficiare = 'N/A';
          }

          isInvalidCode = false;
        } else {
          isInvalidCode = true;
          invalidCodeString = jsonString;
        }
        numberEditingCobntroller.clear();
      } else {
        numberEditingCobntroller.clear();
        log('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      log("ERROR $_");
    } catch (e) {
      log('asd $e');
    }
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
      msisdn = ParserValidator.validateMsisdn("228", msisdn, context);
      print('onSendMoneySubmit msisdn $msisdn');

      if (StringUtil().isNullOrEmpty(msisdn)) {
        showToast2(context, AppStringValidation.destinationRequired);
        print('onSendMoneySubmit fieldtype ${AppStringValidation.destinationRequired}}');
        return;
      }
      if (AppGlobal.isEditedTransferNational) {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed && res.extendedData.othernet) {
          print('CASH APPCASH ${res.extendedData.issubscribed} ${res.extendedData.othernet}');
          AppGlobal.isEditedTransferNational = false;
          messageType = 'APPCASH';
          toNextStep();
        } else if (res.extendedData.issubscribed && !res.extendedData.othernet) {
          print('CASH APPCASH ${res.extendedData.issubscribed} ${!res.extendedData.othernet}');
          AppGlobal.isEditedTransferNational = false;
          messageType = 'APPCASH';
          toNextStep();
        } else if (!res.extendedData.issubscribed && !res.extendedData.othernet) {
          print('CASH APPCASH ${!res.extendedData.issubscribed} ${!res.extendedData.othernet}');
          AppGlobal.isEditedTransferNational = false;
          messageType = 'APPCASH';
          toNextStep();
        } else if (!res.extendedData.issubscribed && res.extendedData.othernet) {
          print('CASH CASHOFF ${!res.extendedData.issubscribed} ${res.extendedData.othernet}');
          AppGlobal.isEditedTransferNational = false;
          messageType = 'CASHOFF';
          toNextStep();
        } else {
          showToast2(context, AppStringValidation.destinationRequired);
        }
      } else {
        // Kung phonebook ni siya nga function
        print('onSendMoneySubmit asd sulod dre 2');
        //assign amount
        // String? amount = ParserValidator.parseAmount2(amountEditingController, context);
        // print('onSendMoneySubmit amount $amount');
        if (StringUtil().isNullOrEmpty(amountEditingController.text)) return;

        if (AppGlobal.isSubscribedTransferNational & AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (AppGlobal.isSubscribedTransferNational & !AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (!AppGlobal.isSubscribedTransferNational & !AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (!AppGlobal.isSubscribedTransferNational & AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.OFFNET);
        }
      }
    } catch (ex) {
      print('onSendMoneySubmit ex $ex');
    }
  }

  static void sendSoap(String msisdn, String amount, NetState state) {
    resetMessage();
    switch (state) {
      case NetState.OFFNET:
        // HITS: CASHOFF <msisdn> <amount> <password> F
        message
          ..write("CASHOFF")
          ..write(' ')
          ..write(msisdn)
          ..write(' ')
          ..write(amount)
          ..write(' ')
          ..write("<password/>")
          ..write(' ')
          ..write('F');
        print("HITS 1 ${message.toString()}");
        break;

      case NetState.ONNET:
        // HITS: APPCASH <msisdn> <amount> <password> F
        message
          ..write("APPCASH")
          ..write(' ')
          ..write(msisdn)
          ..write(' ')
          ..write(amount)
          ..write(' ')
          ..write("<password/>")
          ..write(' ')
          ..write('F');
        print("HITS 2 ${message.toString()}");
        break;
    }

    String confirm = "";
    switch (fieldtype) {
      case FieldType.NORMAL:
        confirm = AppStringConfirmation.confirmtransfertnationalmanual.replaceAll("<amount>", amount).replaceAll("<msisdn>", msisdn);
        print("HITS 3 ${message.toString()}");
        break;
      case FieldType.PHONEBOOK:
        confirm = AppStringConfirmation.confirmtransfertnational
            .replaceAll("<amount>", amount)
            .replaceAll("<contactname>", StringUtil().setText(AppGlobal.addressBookDisplayName, AppGlobal.addressBookDisplayName, ""))
            .replaceAll("<msisdn>", msisdn);
        print("HITS 4 ${message.toString()}");
        break;
      case null:
        break;
    }
    notifymessage.write(confirm);
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
    if (AppGlobal.message.length > 0) AppGlobal.message.write(AppGlobal.message.length);
    if (AppGlobal.notifymessage.length > 0) AppGlobal.notifymessage.write(AppGlobal.notifymessage.length);
    if (AppGlobal.shortcode.length > 0) AppGlobal.shortcode.write(AppGlobal.shortcode.length);
  }
}
