// To parse this JSON data, do
//
//     final internetProducts = internetProductsFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<VoiceProducts> VoiceProductsFromJson(String str) => List<VoiceProducts>.from(json.decode(str).map((x) => VoiceProducts.fromJson(x)));

String VoiceProductsToJson(List<VoiceProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VoiceProducts {
  String productid;
  String price;
  String description;

  VoiceProducts({
    required this.productid,
    required this.price,
    required this.description,
  });

  factory VoiceProducts.fromJson(Map<String, dynamic> json) => VoiceProducts(
        productid: json["productid"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "productid": productid,
        "price": price,
        "description": description,
      };
}
