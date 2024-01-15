// ignore_for_file: unused_import, deprecated_member_use

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/routes/app_pages.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/config/theme/theme_manager.dart';
import 'package:ibank/config/theme/theme_provider.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_locale.dart';
import 'package:ibank/utils/constants/ws_const.dart';
import 'package:ibank/utils/theme.dart';
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
  // cameras = await availableCameras();

  final sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.getBool('first_run') ?? true) {
    AppGlobal.isAppFirstRun = true;
    await sharedPref.setBool('first_run', false);
  }

  await Get.putAsync<StorageServices>(() async => StorageServices());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProviderScope(
        // overrides: [
        //   authService.overrideWithProvider(Provider((ref) => AuthService())),
        //   sharedPrefService.overrideWithProvider(Provider((ref) => SharedPrefService())),
        // ],
        child: Sizer(builder: (context, orientation, deviceType) {
          // return Consumer(builder: (context, ref, child) {
          //   final themeManager = ref.watch(themeProvider);

          return GetMaterialApp(
            title: AppLocalizations.translate(context, 'title'),
            debugShowCheckedModeBanner: false,
            theme: ThemeManager().lightTheme,
            darkTheme: ThemeManager().darkTheme,
            initialRoute: AppRoutes.SPLASH, //  Routes.splash.path,
            getPages: AppPages.list,
            locale: Get.locale ?? const Locale('fr'),
            fallbackLocale: const Locale('fr'),
            supportedLocales: AppLocalizations.supportedLocales,
            //flc.CountryLocalizations.supportedLocales.map(Locale.new),
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
