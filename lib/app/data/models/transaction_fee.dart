// To parse this JSON data, do
//
//     final transactionFee = transactionFeeFromJson(jsonString);

import 'dart:convert';

TransactionFee transactionFeeFromJson(String str) => TransactionFee.fromJson(json.decode(str));

String transactionFeeToJson(TransactionFee data) => json.encode(data.toJson());

class TransactionFee {
  String sender;
  String destination;
  String currency;

  TransactionFee({
    required this.sender,
    required this.destination,
    required this.currency,
  });

  factory TransactionFee.fromJson(Map<String, dynamic> json) => TransactionFee(
        sender: json["sender"],
        destination: json["destination"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "destination": destination,
        "currency": currency,
      };
}
