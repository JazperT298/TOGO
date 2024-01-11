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

  History({
    required this.service,
    required this.message,
    required this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
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
