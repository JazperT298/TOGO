import 'package:get/get.dart';
import 'package:ibank/app/modules/bottomnav/views/bottomnav_view.dart';
import 'package:ibank/app/modules/history/views/history_view.dart';
import 'package:ibank/app/modules/login/views/login_biometrics_view.dart';
import 'package:ibank/app/modules/login/views/login_pin_biometrics_view.dart';
import 'package:ibank/app/modules/login/views/login_profile_view.dart';
import 'package:ibank/app/modules/login/views/login_security_code_view.dart';
import 'package:ibank/app/modules/login/views/login_success.dart';
import 'package:ibank/app/modules/login/views/login_view.dart';
import 'package:ibank/app/modules/map/views/map_view.dart';
import 'package:ibank/app/modules/mbanking/views/mbanking_failed_view.dart';
import 'package:ibank/app/modules/mbanking/views/mbanking_success_view.dart';
import 'package:ibank/app/modules/newfav/views/newfav_view.dart';
import 'package:ibank/app/modules/notification/views/notification_view.dart';
import 'package:ibank/app/modules/onboard/views/onboard_view.dart';
import 'package:ibank/app/modules/otp/views/otp_recovery_view.dart';
import 'package:ibank/app/modules/otp/views/otp_view.dart';
import 'package:ibank/app/modules/payment/view/payment_failed_view.dart';
import 'package:ibank/app/modules/payment/view/payment_success_view.dart';
import 'package:ibank/app/modules/privacy/views/privacy_view.dart';
import 'package:ibank/app/modules/recharge/views/recharge_failed_view.dart';
import 'package:ibank/app/modules/recharge/views/recharge_otp_view.dart';
import 'package:ibank/app/modules/recharge/views/recharge_success_view.dart';
import 'package:ibank/app/modules/recharge/views/recharge_view.dart';
import 'package:ibank/app/modules/sendmoney/views/transac_complete.dart';
import 'package:ibank/app/modules/sendmoney/views/transac_failed.dart';
import 'package:ibank/app/modules/sendmoney/views/transac_success.dart';
import 'package:ibank/app/modules/settings/views/settings_view.dart';
import 'package:ibank/app/modules/shop/views/shop_view.dart';
import 'package:ibank/app/modules/splash/views/splash_view.dart';
import 'package:ibank/app/modules/transfer/views/transfer_view.dart';
import 'package:ibank/app/modules/withdrawal/views/withdrawal_failed.dart';
import 'package:ibank/app/modules/withdrawal/views/withdrawal_progress_view.dart';
import 'package:ibank/app/modules/withdrawal/views/withdrawal_view.dart';
import 'package:ibank/app/routes/app_routes.dart';

import '../modules/profile/views/profile_change_pin.dart';
import '../modules/profile/views/profile_information_personelles_view.dart';
import '../modules/profile/views/profile_otp_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/withdrawal/views/withdrawal_otp_view.dart';
import '../modules/withdrawal/views/withdrawal_success_view.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView()),
    GetPage(name: AppRoutes.ONBOARD, page: () => const OnboardView()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginView()),
    GetPage(name: AppRoutes.LOGINPROFILE, page: () => const LoginProfileView()),
    GetPage(name: AppRoutes.LOGINSECURITYCODE, page: () => const LoginSecurityCodeView()),
    GetPage(name: AppRoutes.LOGINBIOMETRICS, page: () => const LoginBiometricsView()),
    GetPage(name: AppRoutes.LOGINPINBIOMETRICS, page: () => const LoginPinBiometricsView()),
    GetPage(name: AppRoutes.OTP, page: () => const OtpView()),
    GetPage(name: AppRoutes.PRIVACY, page: () => const PrivacyView()),
    GetPage(name: AppRoutes.LOGINSUCCESS, page: () => const LoginSuccess()),
    GetPage(name: AppRoutes.BOTTOMNAV, page: () => const BottomNavView()),
    GetPage(name: AppRoutes.HISTORY, page: () => const HistoryView()),
    GetPage(name: AppRoutes.SHOP, page: () => const ShopView()),
    GetPage(name: AppRoutes.SETTINGS, page: () => const SettingsView()),
    GetPage(name: AppRoutes.MAP, page: () => const MapView()),
    GetPage(name: AppRoutes.NEWFAV, page: () => const NewFavView()),
    GetPage(name: AppRoutes.WITHDRAWAL, page: () => const WithdrawalView()),
    GetPage(name: AppRoutes.TRANSFER, page: () => const TransferView()),
    GetPage(name: AppRoutes.WITHDRAWALOTP, page: () => const WithdrawalOtpView()),
    GetPage(name: AppRoutes.WITHDRAWALSUCCESS, page: () => const WithdrawalSuccessView()),
    GetPage(name: AppRoutes.WITHDRAWALFAILED, page: () => const WithdrawalFailed()),
    GetPage(name: AppRoutes.PROFILE, page: () => const ProfileView()),
    GetPage(name: AppRoutes.PROFILEINFORMATIONPERSONELLES, page: () => const ProfileInformationPersonellesView()),
    GetPage(name: AppRoutes.PROFILEOTP, page: () => const ProfileOtpView()),
    GetPage(name: AppRoutes.PROFILECHANGESPASSWORD, page: () => const ProfileChangePinView()),
    GetPage(name: AppRoutes.WITHDRAWALOTP, page: () => const WithdrawalOtpView()),
    GetPage(name: AppRoutes.WITHDRAWALSUCCESS, page: () => const WithdrawalSuccessView()),
    GetPage(name: AppRoutes.TRANSACCOMPLETE, page: () => const TransacCompleteView()),
    GetPage(name: AppRoutes.TRANSACFAILED, page: () => const TransacFailedView()),
    GetPage(name: AppRoutes.TRANSACSUCCESS, page: () => const TransacSuccessView()),
    GetPage(name: AppRoutes.RECHARGE, page: () => const RechargeView()),
    GetPage(name: AppRoutes.RECHARGEOTP, page: () => const RechargeOtpView()),
    GetPage(name: AppRoutes.WITHDRAWPROGRESS, page: () => const WithdrawalProgressView()),
    GetPage(name: AppRoutes.PAYMENTSUCCESS, page: () => const PaymentSuccessView()),
    GetPage(name: AppRoutes.PAYMENTFAILED, page: () => const PaymentFieldView()),
    GetPage(name: AppRoutes.OTPRECOVERY, page: () => const OtpRecoveryView()),
    GetPage(name: AppRoutes.MBANKFAILED, page: () => const MBangkingFailedView()),
    GetPage(name: AppRoutes.MBANKSUCCESS, page: () => const MBangkingSuccessView()),
    GetPage(name: AppRoutes.RECHARGEFAILED, page: () => const RechargeFailedView()),
    GetPage(name: AppRoutes.RECHARGESUCCESS, page: () => const RechargeSuccessView()),
    GetPage(name: AppRoutes.NOTIFICAITON, page: () => const NotificationView()),
  ];
}
