// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  String service;
  String message;
  DateTime date;

  TransactionResponse({
    required this.service,
    required this.message,
    required this.date,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
        service: json["service"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "message": message,
        "date": date.toIso8601String(),
      };
}
