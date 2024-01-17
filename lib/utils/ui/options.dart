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
  FluOption(icon: FluIcons.profile, title: 'Informations personelles.', description: 'Modifiez ou ajoutez des informations.'),
  FluOption(icon: FluIcons.coin1, title: 'Devises', description: 'Changez de devises.'),
  FluOption(icon: FluIcons.flag, title: 'Langues', description: 'Selectionnez la langue qui vous convient le mieux.'),
  FluOption(icon: FluIcons.notificationBing, title: 'Notifications', description: 'Parametrez les notifications'),
  FluOption(icon: FluIcons.shieldSecurity, title: 'Securité', description: 'Mot de passe, Empreinte digitale et autres.'),
  FluOption(icon: FluIcons.textalignCenter, title: 'Système', description: 'Parametres liés au systeme d\'exploitation.'),
  FluOption(
      icon: FluIcons.logout1,
      title: 'Deconnexion',
      description: 'Fermez la session actuelle.',
      onPressed: () => Get.toNamed(AppRoutes.ONBOARD)) // KRouter.noContextPush(Routes.onboarding)),
];
