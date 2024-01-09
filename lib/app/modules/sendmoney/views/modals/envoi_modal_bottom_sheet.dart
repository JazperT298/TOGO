// ignore_for_file: unused_local_variable, unused_import, avoid_print, unnecessary_null_comparison, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

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
import 'package:ibank/app/providers/transaction_provider.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class EnvoiModalBottomSheet extends StatefulWidget {
  const EnvoiModalBottomSheet({super.key, required this.sendType});
  final String sendType;

  @override
  State<EnvoiModalBottomSheet> createState() => _EnvoiModalBottomSheetState();
}

class _EnvoiModalBottomSheetState extends State<EnvoiModalBottomSheet> {
  final PageController pageController = PageController();
  final numberEditingCobntroller = TextEditingController();
  final amountEditingController = TextEditingController();
  final codeEditingController = TextEditingController();
  bool isKeyboardVis = false;
  User? selectedUser;
  bool isTextFieldEmpty = false;
  bool isInvalidCode = false;
  String invalidCodeString = '';
  final controller = Get.put(
      SendMoneyController()); // void toNextStep() => pageController.nextPage(duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
  void toNextStep() async {
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
              Text('Please wait...'),
            ],
          ),
        );
      },
    );

    // Delay for 3 seconds
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the alert dialog

      // Navigate to the next page
      pageController.nextPage(
          duration: 300.milliseconds, curve: Curves.fastOutSlowIn);
    });
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onUserSelected(User usersNumber) {
    setState(() {
      selectedUser = usersNumber;
      numberEditingCobntroller.text = usersNumber.phoneNumber!;
      AppGlobal.phonenumberspan = usersNumber.phoneNumber!.replaceAll("[^0-9]",
          ""); //Html(data: "<a href=\"${usersNumber.phoneNumber!.replaceAll("[^0-9]", "")}\">${usersNumber.fullName}</a>");
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
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025),
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
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .025),
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
                  const Expanded(
                    child: Text(
                      'Prénom',
                      style: TextStyle(
                          fontSize: M3FontSizes.headlineTiny,
                          color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Razack',
                      style: TextStyle(
                        fontSize: M3FontSizes.headlineTiny,
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
            const Expanded(
              child: Text(
                'Numéro',
                style: TextStyle(
                    fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
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
                style: TextStyle(
                    fontSize: M3FontSizes.headlineTiny, color: Colors.grey),
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
              children: [
                Expanded(
                  child: FluTextField(
                    hint: "Numéro du destinataire",
                    inputController: numberEditingCobntroller,
                    hintStyle:
                        const TextStyle(fontSize: M3FontSizes.titleMedium),
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.number,
                    fillColor: context.colorScheme.primaryContainer,
                    textStyle:
                        const TextStyle(fontSize: M3FontSizes.bodyMedium),
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
                      numberEditingCobntroller.value =
                          numberEditingCobntroller.value.copyWith(
                        text: text,
                        selection: TextSelection.collapsed(offset: text.length),
                      );
                      setState(() {
                        isTextFieldEmpty = false;
                      });
                    },
                    onFieldSubmitted: (p0) {
                      if (numberEditingCobntroller.text.isNotEmpty ||
                          numberEditingCobntroller.text
                              .contains('99 99 02 28')) {
                        AppGlobal.isEditedTransferNational = true;
                        AppGlobal.isSubscribedTransferNational = false;
                        AppGlobal.isOtherNetTransferNational = false;
                        addNumberFromReceiver(
                            numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                        isTextFieldEmpty = false;
                        toNextStep();
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
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ModalBottomSheet(
                                child: EnvoiModalBottomSheet(
                                    sendType: widget.sendType)))).then((value) {
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
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
                    addNumberFromReceiver(
                        numberEditingCobntroller.text, 'F3C8DEBDBA27B035');
                    AppGlobal.isEditedTransferNational = true;
                    AppGlobal.isSubscribedTransferNational = false;
                    AppGlobal.isOtherNetTransferNational = false;
                    isTextFieldEmpty = false;
                    toNextStep();
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
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
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
                      'Please input am amount*',
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
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
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
                    showToast(context, 'Code Secret should not be empty');
                    isInvalidCode = true;
                    invalidCodeString = "Code Secret should not be empty";
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
                    if (widget.sendType.contains('Transfert National')) {
                      setState(() {
                        var asd =
                            '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                        sendMoneyToReceiver(
                            asd,
                            'F3C8DEBDBA27B035',
                            amountEditingController.text,
                            codeEditingController.text);
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
                                Text("Verfying OTP! Please wait..."),
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
                    } else {
                      setState(() {
                        var asd =
                            '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                        sendMoneyToReceiver(
                            asd,
                            'F3C8DEBDBA27B035',
                            amountEditingController.text,
                            codeEditingController.text);
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
                                Text("Verfying OTP! Please wait..."),
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
                    showToast(context, 'Code Secret should not be empty');
                    isInvalidCode = true;
                    invalidCodeString = "Code Secret should not be empty";
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
                    if (widget.sendType.contains('Transfert National')) {
                      setState(() {
                        var asd =
                            '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                        sendMoneyToReceiver(
                            asd,
                            'F3C8DEBDBA27B035',
                            amountEditingController.text,
                            codeEditingController.text);
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
                                Text("Verfying OTP! Please wait..."),
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
                    } else {
                      setState(() {
                        var asd =
                            '228${numberEditingCobntroller.text.replaceAll(" ", "")}';
                        sendMoneyToReceiver(
                            asd,
                            'F3C8DEBDBA27B035',
                            amountEditingController.text,
                            codeEditingController.text);
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
                                Text("Verfying OTP! Please wait..."),
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
                    }
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
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
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
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: M3FontSizes.bodyLarge),
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
  addNumberFromReceiver(String msisdn, String token) async {
    try {
      var strToken = await SqlHelper.getToken();
      print('strToken ${strToken!.replaceAll(".", "")}');
      var toe = strToken.replaceAll(".", "");
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
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
        // var jsonResponse = jsonDecode(jsonString);
        print('JSON Response: $jsonString');
      } else {
        print('asda ${response.reasonPhrase}');
      }
    } catch (e) {
      print('addNumberFromReceiver $e');
    }
  }

  //1111 and code if kani 22879397111 nga user
  // 99990137
  sendMoneyToReceiver(
      String msisdn, String token, String amounts, String code) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body><n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">22899990228</msisdn><message i:type="d:string">APPCASH $msisdn $amounts $code F</message>
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
        var requestTokenReturnElement =
            document.findAllElements('RequestTokenReturn').single;

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

          setState(() {});
        } else {
          setState(() {
            isInvalidCode = true;
            invalidCodeString = jsonString;
          });
        }
      } else {
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
}
