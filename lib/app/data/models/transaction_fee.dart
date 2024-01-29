// To parse this JSON data, do
//
//     final transactionFee = transactionFeeFromJson(jsonString);

import 'dart:convert';

TransactionFee transactionFeeFromJson(String str) => TransactionFee.fromJson(json.decode(str));

String transactionFeeToJson(TransactionFee data) => json.encode(data.toJson());

class TransactionFee {
  String senderkeycosttotal;
  String senderkeycosttva;
  String destination;
  String currency;

  TransactionFee({
    required this.senderkeycosttotal,
    required this.senderkeycosttva,
    required this.destination,
    required this.currency,
  });

  factory TransactionFee.fromJson(Map<String, dynamic> json) => TransactionFee(
        senderkeycosttotal: json["senderkeycosttotal"],
        senderkeycosttva: json['senderkeycosttva'],
        destination: json["destination"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "senderkeycosttotal": senderkeycosttotal,
        "senderkeycosttva": senderkeycosttva,
        "destination": destination,
        "currency": currency,
      };
}
