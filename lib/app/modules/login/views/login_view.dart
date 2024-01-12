import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/auth_provider.dart';
import '../../../routes/app_routes.dart';

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
    final filteredCountries = ['TG'];
    countryPicker = FlCountryCodePicker(
        localize: true,
        showDialCode: true,
        showSearchBar: false,
        // favoritesIcon: _yourIcon,
        // favorites: _yourFavorites,
        title: title,
        filteredCountries: filteredCountries);
    super.initState();
  }

  Widget title = Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 0),
          child: Text('Selectionner'.toUpperCase(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFB6404),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 0),
          child: Text(
            'Votre pays',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 0),
            child: Text(
                'Choisissez votre pays et bénéficiez d’une expérience personnalisée ainsi que des transactions optimisées.',
                style: TextStyle(fontSize: 10.sp))),
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
        child: Padding(
          padding:
              UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  AppImages.loginImage,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.height * .3,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Accédez à votre compte',
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                child: Text(
                  'Saisissez vos informations de connexion et connectez-vous à votre compte en toute simplicité',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 42),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Show the country code picker when tapped.

                      final picked =
                          await countryPicker.showPicker(context: context);
                      // Null check
                      // ignore: avoid_print
                      if (picked != null) print(picked.dialCode);
                      setState(() {
                        _selectedCountryCode = picked!.dialCode;
                      });
                    },
                    child: Container(
                      height: 5.h,
                      width: MediaQuery.of(context).size.width / 4.8,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              _selectedCountryCode.length <= 3 ? 18.0 : 12.0,
                          vertical: 4.0),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              _selectedCountryCode.isEmpty
                                  ? '+228'
                                  : _selectedCountryCode,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 11.sp)),
                          const FluIcon(FluIcons.arrowDown2, size: 20)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: FluTextField(
                      hint: "Numéro de téléphone",
                      inputController: numberController,
                      height: 5.h,
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
                        numberController.value =
                            numberController.value.copyWith(
                          text: text,
                          selection:
                              TextSelection.collapsed(offset: text.length),
                        );
                        setState(() {
                          isTextFieldEmpty = false;
                          errorMessage = '';
                        });
                      },
                      textStyle: TextStyle(
                          fontSize: 11.sp), // context.textTheme.bodyMedium,

                      onFieldSubmitted: (p0) {
                        if (numberController.text.isNotEmpty) {
                          print(numberController.text);
                          String replacedString = numberController.text
                              .replaceAll(" ", "")
                              .trim()
                              .toString();
                          String msisdn =
                              (_selectedCountryCode + replacedString)
                                  .replaceAll("+", "")
                                  .toString();
                          print(msisdn);

                          ProgressAlertDialog.progressAlertDialog(
                              context, "Chargement..");
                          controller.kycInquiryRequest(
                              msisdn: msisdn,
                              formattedMSISDN: numberController.text,
                              countryCode: _selectedCountryCode);
                          isTextFieldEmpty = false;
                        } else if (numberController.text.isEmpty) {
                          setState(() {
                            isTextFieldEmpty = true;
                          });
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
                              fontSize: 11.sp,
                              color: context.colorScheme.secondary,
                            ),
                          ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Phone number is required*',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        )
                  : const SizedBox(height: 35),
              FluButton.text(
                'Continuer',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () async {
                  if (numberController.text.isNotEmpty) {
                    print(numberController.text);
                    String replacedString = numberController.text
                        .replaceAll(" ", "")
                        .trim()
                        .toString();
                    String msisdn = (_selectedCountryCode + replacedString)
                        .replaceAll("+", "")
                        .toString();
                    print(msisdn);

                    ProgressAlertDialog.progressAlertDialog(
                        context, "Chargement..");
                    controller.kycInquiryRequest(
                        msisdn: msisdn,
                        formattedMSISDN: numberController.text,
                        countryCode: _selectedCountryCode);
                    isTextFieldEmpty = false;
                  } else if (numberController.text.isEmpty) {
                    setState(() {
                      isTextFieldEmpty = true;
                    });
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
                textStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
