// ignore_for_file: avoid_print

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/modules/login/modals/login_settings_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final numberController = TextEditingController();
  final controller = Get.put(LoginController());
  String _selectedCountryCode = '+228'; // Default country code
  // final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  bool isTextFieldEmpty = false;
  String errorMessage = '';
  late final FlCountryCodePicker countryPicker;
  @override
  void initState() {
    setCountryCodePicker();
    super.initState();
  }

  void setCountryCodePicker() {
    final filteredCountries = ['TG'];
    countryPicker = FlCountryCodePicker(
        localize: true,
        showDialCode: true,
        showSearchBar: false,
        // favoritesIcon: _yourIcon,
        // favorites: _yourFavorites,
        title: title,
        filteredCountries: filteredCountries);
  }

  Widget title = Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 0),
          child: Text(LocaleKeys.strSelect.tr.toUpperCase(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFB6404),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 0),
          child: Text(
            LocaleKeys.strYourCountry.tr,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 0), child: Text(LocaleKeys.strChooseCountryDesc.tr, style: TextStyle(fontSize: 10.sp))),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              if (controller.isLoadingMsisdn.value == true)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: loadingContainer(),
                ),
              Padding(
                padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // showSelectLanguageDialog(context);
                        LoginSettingsBottomSheet.shoBottomSheetLoginSettings();
                      },
                      child: const SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FluIcon(
                              FluIcons.settingUnicon,
                              color: Colors.black54,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        AppImages.loginImage1,
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.height * .3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      LocaleKeys.strAccessAccount.tr,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                      child: Text(
                        LocaleKeys.strAccessAccountDesc.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final picked = await countryPicker.showPicker(context: context);
                            // Null check
                            if (picked != null) {
                              setState(() {
                                print(picked.dialCode);
                                _selectedCountryCode = picked.dialCode;
                              });
                            } else {
                              _selectedCountryCode = '+228';
                            }
                          },
                          child: Container(
                            height: 5.h,
                            width: MediaQuery.of(context).size.width / 4.6,
                            padding: EdgeInsets.symmetric(horizontal: _selectedCountryCode.length <= 3 ? 18.0 : 12.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedCountryCode.isEmpty ? '+228' : _selectedCountryCode,
                                    style: TextStyle(color: Colors.black, fontSize: 10.sp)),
                                const FluIcon(FluIcons.arrowDown2, size: 16)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: FluTextField(
                            hint: LocaleKeys.strPhoneNumber.tr,
                            inputController: numberController,
                            height: 5.8.h,
                            cornerRadius: 15,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                            ],
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
                              numberController.value = numberController.value.copyWith(
                                text: text,
                                selection: TextSelection.collapsed(offset: text.length),
                              );
                              setState(() {
                                isTextFieldEmpty = false;
                                errorMessage = '';
                              });
                            },
                            textStyle: TextStyle(fontSize: 10.sp), // context.textTheme.bodyMedium,

                            onFieldSubmitted: (p0) {
                              print(numberController.text.trim().toString().length);
                              if (numberController.text.isNotEmpty && numberController.text.trim().toString().length == 11) {
                                if (numberController.text.contains(" ")) {
                                  print("wala ge input ang 228");
                                  String replacedString = numberController.text.replaceAll(" ", "").trim().toString();
                                  String msisdn = (_selectedCountryCode + replacedString).replaceAll("+", "").toString();
                                  print(msisdn);
                                  print(_selectedCountryCode);

                                  if (msisdn.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                                    ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                                    controller.kycInquiryRequest(
                                        msisdn: msisdn, formattedMSISDN: numberController.text, countryCode: _selectedCountryCode);
                                  } else {
                                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  }
                                } else {
                                  print("ge input ang 228");
                                  print(numberController.text);
                                  if (numberController.text.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                                    ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                                    String stringRemoveCountryCode = numberController.text.substring(3);
                                    String formattedMSISDN =
                                        stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                                    controller.kycInquiryRequest(
                                        msisdn: numberController.text, formattedMSISDN: formattedMSISDN, countryCode: _selectedCountryCode);
                                  } else {
                                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  }
                                }

                                isTextFieldEmpty = false;
                              } else if (numberController.text.isEmpty) {
                                setState(() {
                                  isTextFieldEmpty = true;
                                });
                              } else if (numberController.text.trim().toString().length != 11) {
                                Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    isTextFieldEmpty == true
                        ? errorMessage.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  errorMessage,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: context.colorScheme.secondary,
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  LocaleKeys.strPhoneNumberRequired.tr,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: context.colorScheme.secondary,
                                  ),
                                ),
                              )
                        : const SizedBox(height: 35),
                    FluButton.text(
                      LocaleKeys.strContinue.tr,
                      suffixIcon: FluIcons.arrowRight,
                      iconStrokeWidth: 1.8,
                      onPressed: () async {
                        // controller.encryptionExample(
                        //     msisdn: "22879397111",
                        //     formattedMSISDN: "79 39 71 11",
                        //     countryCode: "228");
                        print(numberController.text.trim().toString().length);
                        if (numberController.text.isNotEmpty && numberController.text.trim().toString().length == 11) {
                          if (numberController.text.contains(" ")) {
                            print("wala ge input ang 228");
                            String replacedString = numberController.text.replaceAll(" ", "").trim().toString();
                            String msisdn = (_selectedCountryCode + replacedString).replaceAll("+", "").toString();
                            print(msisdn);
                            print(_selectedCountryCode);

                            if (msisdn.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                              // ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                              controller.kycInquiryRequest(msisdn: msisdn, formattedMSISDN: numberController.text, countryCode: _selectedCountryCode);
                            } else {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
                          } else {
                            print("ge input ang 228");
                            print(numberController.text);
                            if (numberController.text.substring(0, 3) == _selectedCountryCode.replaceAll("+", "")) {
                              // ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                              String stringRemoveCountryCode = numberController.text.substring(3);
                              String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                              controller.kycInquiryRequest(
                                  msisdn: numberController.text, formattedMSISDN: formattedMSISDN, countryCode: _selectedCountryCode);
                            } else {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
                          }

                          isTextFieldEmpty = false;
                        } else if (numberController.text.isEmpty) {
                          setState(() {
                            isTextFieldEmpty = true;
                          });
                        } else if (numberController.text.trim().toString().length != 11) {
                          Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        }
                      },
                      height: 5.8.h,
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
                      textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSelectLanguageDialog(BuildContext context) {
    List<bool> selectedLanguages = [false, false]; // Index 0: English, Index 1: French

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(12), // Outside Padding
            contentPadding: const EdgeInsets.all(12), // Content Padding

            title: Text(LocaleKeys.strSelectLanguage.tr),
            content: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImages.ukFlag, height: 30, width: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(LocaleKeys.strEnglish.tr),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: AppGlobal.isSelectEnglish,
                          onChanged: (value) {
                            // English checkbox
                            setState(() {
                              selectedLanguages[1] = false;
                              AppGlobal.isSelectEnglish = true;
                              AppGlobal.isSelectFrench = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImages.franceFlag, height: 30, width: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(LocaleKeys.strFrench.tr),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: AppGlobal.isSelectFrench,
                          onChanged: (value) {
                            // French checkbox
                            setState(() {
                              AppGlobal.isSelectEnglish = false;
                              AppGlobal.isSelectFrench = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: AppGlobal.isSelectEnglish == false && AppGlobal.isSelectFrench == false
                    ? null
                    : () {
                        if (AppGlobal.isSelectFrench == true && AppGlobal.isSelectEnglish == false) {
                          Get.find<StorageServices>().saveLanguage(language: 'FR');
                        } else {
                          Get.find<StorageServices>().saveLanguage(language: 'EN');
                        }

                        Navigator.pop(context);
                      },
                child: Text(LocaleKeys.strSelect.tr),
              ),
            ],
          );
        });
      },
    ).then((value) {
      String enLang = Get.find<StorageServices>().storage.read('language');
      Get.updateLocale(Locale(enLang.toLowerCase()));
      AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
      AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
      setState(() {});
    });
  }
}
