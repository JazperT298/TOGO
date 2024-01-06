import 'dart:math' as math;

import 'package:ibank/app/data/models/transaction.dart';
import 'package:ibank/utils/core/users.dart';

List<Transaction> transactions = [
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
        users[math.Random().nextInt(users.length)],
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(20000).toDouble(),
      type: TransactionType.outgoing,
      createdAt: DateTime.now()),
  Transaction(
      agency: Agency.canalBox,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(70000).toDouble(),
      type: TransactionType.incoming,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(30000).toDouble(),
      type: TransactionType.incoming,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.canceled,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(1000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.incoming,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(40000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.failed,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.incoming,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
  Transaction(
      sender: authenticatedUser,
      receivers: [
        users[math.Random().nextInt(users.length)],
      ],
      amout: math.Random().nextInt(10000).toDouble(),
      type: TransactionType.outgoing,
      status: TransactionStatus.ok,
      createdAt: DateTime.now()),
];
