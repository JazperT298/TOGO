// ignore_for_file: depend_on_referenced_packages

import 'package:flukit_icons/flukit_icons.dart';
import 'package:get/get.dart';
import 'package:ibank/generated/locales.g.dart';

class Wallet {
  final int id, userId;
  final double amount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Wallet({
    required this.id,
    required this.userId,
    required this.amount,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  factory Wallet.fromJson(Map<String, dynamic> data) => Wallet(
        id: data['id'],
        userId: data['user_id'],
        amount: data['amount'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        isActive: data['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'amount': amount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_active': isActive,
      };
}

class WalletAction {
  final String name;
  final String description;
  final FluIcons icon;
  final List<WalletAction> children;

  WalletAction({
    required this.name,
    required this.description,
    required this.icon,
    this.children = const <WalletAction>[],
  });

  static List<WalletAction> getAll() {
    return [
      /// Top up action.
      /// Used to refund wallet.
      WalletAction(
          name: LocaleKeys.strWalletRechange.tr,
          description: LocaleKeys.strWalletRechangeDesc.tr,
          icon: FluIcons.plus,
          children: <WalletAction>[
            WalletAction(
              icon: FluIcons.cards,
              name: 'Ecobank',
              description:
                  'Utilisez votre carte de credit pour recharger votre compte flooz...',
            ),
            WalletAction(
              icon: FluIcons.bank,
              name: 'Banque Atlantique',
              description: 'Rechargez depuis votre compte bancaire.',
            ),
            WalletAction(
              icon: FluIcons.people,
              name: 'La Poste',
              description: 'Lancez une tontine ou une collection',
            ),
            WalletAction(
              icon: FluIcons.routing,
              name: 'Collectes et tontine',
              description: 'Effectuez un depôt en physique.',
            ),
            WalletAction(
              icon: FluIcons.cards,
              name: 'Agences à proximité',
              description:
                  'Utilisez votre carte de credit pour recharger votre compte flooz...',
            ),
          ]),

      /// Send action.
      /// Used to send money to another user or another merchant.
      WalletAction(
          name: LocaleKeys.strWalletSend.tr,
          description: LocaleKeys.strWalletSendDesc.tr,
          icon: FluIcons.moneySend),

      /// Payment action.
      /// Used for merchant payments.
      /// this concern only merchant that are partners & saved in api database.
      WalletAction(
          name: LocaleKeys.strWalletPay.tr,
          description: LocaleKeys.strWalletPayDesc.tr,
          icon: FluIcons.barcode,
          children: [
            WalletAction(
              icon: FluIcons.monitorMobbile,
              name: 'Canal +',
              description:
                  'Profitez de nombreux bonus en effectuant votre abonnement canal+',
            ),
            WalletAction(
              icon: FluIcons.airdrop,
              name: 'CanalBox Fiber',
              description:
                  'Fibrez comme jamais. Souscrivez à votre connexion internet',
            ),
            WalletAction(
              icon: FluIcons.flash,
              name: 'Ceet.',
              description: 'Payez vos factures d\'electricité',
            ),
            WalletAction(
              icon: FluIcons.drop,
              name: 'TDE.',
              description: 'Payez vos factures d\'eau',
            ),
            WalletAction(
              icon: FluIcons.driving,
              name: 'Assurance',
              description: 'Gerez votre assurance',
            ),
            WalletAction(
              icon: FluIcons.teacher,
              name: 'Frais de scolarité',
              description: 'Assurez l\'education de vos enfants',
            ),
          ]),

      /// Cashout action.
      /// Used to retrieve money from wallet.
      WalletAction(
          name: LocaleKeys.strWalletWithdrawal.tr,
          description: LocaleKeys.strWalletWithdrawalDesc.tr,
          icon: FluIcons.import),
    ];
  }
}

enum WalletActions { send, withdraw, pay, topUp, mBanking }

extension WA on WalletActions {
  FluIcons get icon {
    switch (this) {
      case WalletActions.send:
        return FluIcons.export3;
      case WalletActions.pay:
        return FluIcons.wallet;
      case WalletActions.withdraw:
        return FluIcons.import;
      case WalletActions.topUp:
        return FluIcons.addCircle;
      case WalletActions.mBanking:
        return FluIcons.bank;
    }
  }

  String get text {
    switch (this) {
      case WalletActions.send:
        return LocaleKeys.strWalletSend.tr;
      case WalletActions.pay:
        return LocaleKeys.strWalletPay.tr;
      case WalletActions.withdraw:
        return LocaleKeys.strWalletWithdrawal.tr;
      case WalletActions.topUp:
        return LocaleKeys.strWalletRechange.tr;
      case WalletActions.mBanking:
        return "Mbanking";
    }
  }
}
