import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';

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

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Padding(
          padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
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
              const Text(
                'Accédez à votre compte',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                child: const Text(
                  'Saisissez vos informations de connexion et connectez-vous à votre compte en toute simplicité',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 42),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Show the country code picker when tapped.

                      final picked = await countryPicker.showPicker(context: context);
                      // Null check
                      // ignore: avoid_print
                      if (picked != null) print(picked.dialCode);
                      setState(() {
                        _selectedCountryCode = picked!.dialCode;
                      });
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 4.5,
                      padding: EdgeInsets.symmetric(horizontal: _selectedCountryCode.length <= 3 ? 18.0 : 12.0, vertical: 4.0),
                      decoration:
                          BoxDecoration(color: context.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_selectedCountryCode.isEmpty ? '+228' : _selectedCountryCode, style: const TextStyle(color: Colors.black)),
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
                        numberController.value = numberController.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                        setState(() {
                          isTextFieldEmpty = false;
                        });
                      },
                      textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium), // context.textTheme.bodyMedium,

                      onFieldSubmitted: (p0) {
                        if (numberController.text.isNotEmpty) {
                          ProgressAlertDialog.showALoadingDialog(context, "Vérification ! S'il vous plaît, attendez...", 3, AppRoutes.OTP);
                          isTextFieldEmpty = false;
                        } else {
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
                  : const SizedBox(height: 35),
              FluButton.text(
                'Continuer',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  // Get.toNamed(AppRoutes.HOME);
                  if (numberController.text.isNotEmpty) {
                    ProgressAlertDialog.showALoadingDialog(context, "Vérification ! S'il vous plaît, attendez...", 3, AppRoutes.OTP);
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
