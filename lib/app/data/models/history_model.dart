// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

List<History> historyFromJson(String str) =>
    List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  String service;
  String message;
  DateTime date;
  String beneficiary;
  String amount;
  String fees;
  String tax;
  String ttc;
  String operationDate;
  String operationHour;
  String txnID;
  String newBalance;
  bool status;

  History({
    required this.service,
    required this.message,
    required this.date,
    required this.beneficiary,
    required this.amount,
    required this.fees,
    required this.tax,
    required this.ttc,
    required this.operationDate,
    required this.operationHour,
    required this.txnID,
    required this.newBalance,
    required this.status,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        service: json["service"],
        message: json["message"],
        beneficiary: json["beneficiary"],
        amount: json["amount"],
        fees: json["fees"],
        tax: json["tax"],
        ttc: json["ttc"],
        operationDate: json["operationDate"],
        operationHour: json["operationHour"],
        txnID: json["txnID"],
        newBalance: json["newBalance"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "message": message,
        "beneficiary": beneficiary,
        "amount": amount,
        "fees": fees,
        "tax": tax,
        "ttc": ttc,
        "operationDate": operationDate,
        "operationHour": operationHour,
        "txnID": txnID,
        "newBalance": newBalance,
        "date": date.toIso8601String(),
        "status": status,
      };
}
