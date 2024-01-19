// To parse this JSON data, do
//
//     final internetProducts = internetProductsFromJson(jsonString);

import 'dart:convert';

List<InternetProducts> internetProductsFromJson(String str) =>
    List<InternetProducts>.from(
        json.decode(str).map((x) => InternetProducts.fromJson(x)));

String internetProductsToJson(List<InternetProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InternetProducts {
  String productid;
  String price;
  String description;

  InternetProducts({
    required this.productid,
    required this.price,
    required this.description,
  });

  factory InternetProducts.fromJson(Map<String, dynamic> json) =>
      InternetProducts(
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
