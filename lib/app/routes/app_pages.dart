import 'package:get/get.dart';
import 'package:ibank/app/modules/bottomnav/views/bottomnav_view.dart';
import 'package:ibank/app/modules/history/views/history_view.dart';
import 'package:ibank/app/modules/home/views/home_view.dart';
import 'package:ibank/app/modules/login/views/login_view.dart';
import 'package:ibank/app/modules/map/views/map_view.dart';
import 'package:ibank/app/modules/newfav/views/newfav_view.dart';
import 'package:ibank/app/modules/onboard/views/onboard_view.dart';
import 'package:ibank/app/modules/settings/views/settings_view.dart';
import 'package:ibank/app/modules/shop/views/shop_view.dart';
import 'package:ibank/app/modules/splash/views/splash_view.dart';
import 'package:ibank/app/modules/transfer/views/transfer_view.dart';
import 'package:ibank/app/modules/withdrawal/views/withdrawal_view.dart';
import 'package:ibank/app/routes/app_routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),
    GetPage(name: AppRoutes.ONBOARD, page: () => const OnboardView()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginView()),
    GetPage(name: AppRoutes.BOTTOMNAV, page: () => const BottomNavView()),
    GetPage(name: AppRoutes.HOME, page: () => const HomeView()),
    GetPage(name: AppRoutes.HISTORY, page: () => const HistoryView()),
    GetPage(name: AppRoutes.SHOP, page: () => const ShopView()),
    GetPage(name: AppRoutes.SETTINGS, page: () => const SettingsView()),
    GetPage(name: AppRoutes.MAP, page: () => const MapView()),
    GetPage(name: AppRoutes.NEWFAV, page: () => const NewFavView()),
    GetPage(name: AppRoutes.WITHDRAWAL, page: () => const WithdrawalView()),
    GetPage(name: AppRoutes.TRANSFER, page: () => const TransferView()),
  ];
}
