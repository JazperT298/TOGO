// ignore_for_file: depend_on_referenced_packages

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';

List<FluOption> profileScreenOptions = [
  FluOption(icon: FluIcons.profile, title: LocaleKeys.strPersonalInfo.tr, description: LocaleKeys.strPersonalInfoDesc.tr),
  FluOption(icon: FluIcons.password, title: LocaleKeys.strChangePass.tr, description: LocaleKeys.strChangePassDesc.tr),
  FluOption(icon: FluIcons.flag, title: LocaleKeys.strLanguage.tr, description: LocaleKeys.strLanguageDesc.tr),
  FluOption(icon: FluIcons.people, title: LocaleKeys.strFavorites.tr, description: LocaleKeys.strFavoritesDesc.tr),
  FluOption(icon: FluIcons.cards, title: LocaleKeys.strMyCards.tr, description: LocaleKeys.strMyCardsDesc.tr),
  FluOption(icon: FluIcons.bank, title: LocaleKeys.strMyBanks.tr, description: LocaleKeys.strMyBanksDesc.tr),
  FluOption(
    icon: FluIcons.noteText,
    title: LocaleKeys.strFaq.tr,
    description: LocaleKeys.strFaqDesc.tr,
  ),
  FluOption(icon: FluIcons.supportLikeQuestion24Support, title: LocaleKeys.strSupportHelp.tr, description: LocaleKeys.strSupportHelpDesc.tr),
  FluOption(icon: FluIcons.textalignCenter, title: LocaleKeys.strCredit.tr, description: LocaleKeys.strCreditDesc.tr),
];

List<FluOption> settingsScreenOptions = [
  FluOption(icon: FluIcons.coin1, title: 'Devices', description: 'Change currencies.'),
  FluOption(icon: FluIcons.flag, title: 'Language', description: 'Select the language that suits you best.'),
  FluOption(icon: FluIcons.notificationBing, title: 'Notifications', description: 'Configure notifications'),
  FluOption(icon: FluIcons.shieldSecurity, title: 'Security', description: 'Password, Fingerprint and others.'),
  FluOption(icon: FluIcons.textalignCenter, title: 'System', description: 'Settings related to the operating system.'),
  FluOption(
      icon: FluIcons.logout1,
      title: 'Disconnect',
      description: 'Close the current session.',
      onPressed: () => Get.toNamed(AppRoutes.ONBOARD)) // KRouter.noContextPush(Routes.onboarding)),
];
