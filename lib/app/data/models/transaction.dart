import 'package:flukit/flukit.dart';

import 'user.dart';

class Agency {
  final String name;
  final String transactionTitle;
  final FluIcons icon;

  Agency(
      {required this.name, required this.transactionTitle, required this.icon});

  static Agency canalBox = Agency(
    name: "CanalBox",
    transactionTitle: "Abonnement canalbox",
    icon: FluIcons.cloudConnection,
  );
}

class Transaction {
  final User? sender;
  final Agency? agency;
  final List<User> receivers;
  final double amout;
  final TransactionType type;
  final TransactionStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Transaction(
      {this.sender,
      this.agency,
      required this.receivers,
      required this.amout,
      required this.type,
      required this.createdAt,
      this.updatedAt,
      this.status = TransactionStatus.waiting})
      : assert(receivers.isNotEmpty && (sender != null || agency != null));
}

enum TransactionType {
  incoming,
  outgoing,
  agency,
}

enum TransactionStatus { waiting, ok, failed, canceled }
