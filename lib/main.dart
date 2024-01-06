// ignore_for_file: unused_import, deprecated_member_use

import 'package:camera/camera.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/routes/app_pages.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/config/theme/theme_provider.dart';
import 'package:ibank/utils/constants/ws_const.dart';
import 'package:telephony/telephony.dart';

import 'utils/configs.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;

late List<CameraDescription> cameras;
// final authService = Provider<AuthService>((ref) => AuthService());
// final sharedPrefService = Provider<SharedPrefService>((ref) => SharedPrefService());

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlHelper.initDatabase();
  cameras = await availableCameras();

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
        child: Consumer(builder: (context, ref, child) {
          final themeManager = ref.watch(themeProvider);

          return GetMaterialApp(
            title: Configs.appName,
            debugShowCheckedModeBanner: false,
            theme: themeManager.lightTheme,
            darkTheme: themeManager.darkTheme,
            themeMode: themeManager.themeMode,
            initialRoute: AppRoutes.SPLASH, //  Routes.splash.path,
            getPages: AppPages.list,
            supportedLocales: flc.CountryLocalizations.supportedLocales.map(Locale.new),
            localizationsDelegates: const [
              // Package's localization delegate.
              // You can still add other delegates from your app.
              flc.CountryLocalizations.delegate,
            ],
          );
        }),
      );
}
