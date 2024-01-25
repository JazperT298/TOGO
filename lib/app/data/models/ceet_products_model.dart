// To parse this JSON data, do
//
//     final internetProducts = internetProductsFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

List<CeetProducts> CeetProductsFromJson(String str) => List<CeetProducts>.from(json.decode(str).map((x) => CeetProducts.fromJson(x)));

String CeetProductsToJson(List<CeetProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CeetProducts {
  List<Datum> data;
  String description;
  String message;
  int status;

  CeetProducts({
    required this.data,
    required this.description,
    required this.message,
    required this.status,
  });

  factory CeetProducts.fromJson(Map<dynamic, dynamic> json) => CeetProducts(
        data: (json['data'] as List).map((item) => Datum.fromJson(item)).toList(),
        description: json["description"],
        message: json["message"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "description": description,
        "message": message,
        "status": status,
      };
}

List<Datum> CeetDataProductsFromJson(String str) => List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));

String CeetDataProductsToJson(List<Datum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datum {
  String reference;

  Datum({
    required this.reference,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
      };
}
