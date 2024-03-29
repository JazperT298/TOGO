// ignore_for_file: unused_import

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/routes/app_pages.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/android_verify_services.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/config/theme/theme_manager.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/togo_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:telephony/telephony.dart';
import 'app/data/local/getstorage_services.dart';
import 'utils/configs.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;

// late List<CameraDescription> cameras;
// final authService = Provider<AuthService>((ref) => AuthService());
// final sharedPrefService = Provider<SharedPrefService>((ref) => SharedPrefService());

// msisdn: 22896047878
// pin: 2222
// msisdn : 22899990507
// pin: 9999
// Test Destination: 22879397111, 22879397112

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SqlHelper.initDatabase();
  Get.put(DevicePlatformServices());
  // cameras = await availableCameras();

  final sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.getBool('first_run') ?? true) {
    AppGlobal.isAppFirstRun = true;
    await sharedPref.setBool('first_run', false);
  }

  await Get.putAsync<StorageServices>(() async => StorageServices());
  await Get.putAsync<AndroidVerifyServices>(() async => AndroidVerifyServices());

  initializeDateFormatting().then((value) => runApp(
        const AutoLogoutView(),
      ));
}

class AutoLogoutView extends StatefulWidget {
  const AutoLogoutView({super.key});

  @override
  State<AutoLogoutView> createState() => _AutoLogoutViewState();
}

class _AutoLogoutViewState extends State<AutoLogoutView> with WidgetsBindingObserver {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _timer = Timer(const Duration(minutes: 10), () {
        log('The app is state $state 0 $_timer');
        if (AppGlobal.MSISDN.isNotEmpty) {
          Get.offAndToNamed(AppRoutes.LOGINPINBIOMETRICS);
        } else {
          log('The app is state $state 1 $_timer');
        }
      });
    } else if (state == AppLifecycleState.resumed) {
      _timer = Timer(const Duration(minutes: 10), () {
        log('The app is state $state 0 ${_timer!.tick}');
        if (AppGlobal.MSISDN.isNotEmpty) {
          Get.offAndToNamed(AppRoutes.LOGINPINBIOMETRICS);
        } else {
          log('The app is state $state 1 $_timer');
        }
      });
    } else if (state == AppLifecycleState.detached) {
      _timer = Timer(const Duration(seconds: 10), () {
        log('The app is state $state 0 $_timer');
        if (AppGlobal.MSISDN.isNotEmpty) {
          Get.offAndToNamed(AppRoutes.LOGINPINBIOMETRICS);
        } else {
          log('The app is state $state 1 $_timer');
        }
      });
    } else if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      // overrides: [
      //   authService.overrideWithProvider(Provider((ref) => AuthService())),
      //   sharedPrefService.overrideWithProvider(Provider((ref) => SharedPrefService())),
      // ],
      child: Sizer(builder: (context, orientation, deviceType) {
        // return Consumer(builder: (context, ref, child) {
        //   final themeManager = ref.watch(themeProvider);

        return GetMaterialApp(
          title: Configs.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeManager().lightTheme, //TogoTheme.lightTheme,
          darkTheme: ThemeManager().darkTheme, //TogoTheme.darkTheme,
          initialRoute: AppRoutes.SPLASH, //  Routes.splash.path,
          getPages: AppPages.list,
          translationsKeys: AppTranslation.translations,
          locale: Get.locale ?? const Locale('en'),
          fallbackLocale: const Locale('en'),
          // supportedLocales: const [
          //   Locale('en', 'US'),
          //   Locale('fr', 'FR'),
          // ],
          supportedLocales: const [Locale('en')],
          // supportedLocales: AppLocalizations.supportedLocales,
          // flc.CountryLocalizations.supportedLocales.map(Locale.new),
          localizationsDelegates: const [
            // Package's localization delegate.
            // You can still add other delegates from your app.

            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            flc.CountryLocalizations.delegate,
          ],
        );
        // });
      }),
    );
  }
}
