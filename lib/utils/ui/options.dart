// ignore_for_file: depend_on_referenced_packages

import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/options.dart';
import 'package:ibank/app/routes/app_routes.dart';

List<FluOption> profileScreenOptions = [
  FluOption(icon: FluIcons.people, title: 'Favoris', description: 'Envoyez plus rapidement de l\'argent à vos proches.'),
  FluOption(icon: FluIcons.cards, title: 'Mes cartes', description: 'Gerer vos cartes VISA de chez Moov.'),
  FluOption(icon: FluIcons.bank, title: 'Mes banques', description: 'Ajouter ou supprimer un compte bancaire.'),
  FluOption(
    icon: FluIcons.noteText,
    title: 'FAQ',
    description: 'Besoin d\'aide? Nous repondons à vos questions',
  ),
  FluOption(icon: FluIcons.supportLikeQuestion24Support, title: 'Support et aide', description: 'Contactez le service client.'),
  FluOption(icon: FluIcons.textalignCenter, title: 'Credit', description: 'A propos de cette application.'),
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
