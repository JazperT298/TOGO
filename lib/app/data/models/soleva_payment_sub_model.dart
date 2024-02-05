// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flukit/flukit.dart';

List<SolevaPaymentSubModel> solevaPaymentFromJson(String str) =>
    List<SolevaPaymentSubModel>.from(json.decode(str).map((x) => SolevaPaymentSubModel.fromJson(x)));

String solevaPaymentSubModelToJson(List<SolevaPaymentSubModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SolevaPaymentSubModel {
  String title;
  String description;
  FluIcons icon;

  SolevaPaymentSubModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory SolevaPaymentSubModel.fromJson(Map<dynamic, dynamic> json) => SolevaPaymentSubModel(
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<dynamic, dynamic> toJson() => {
        "title": title,
        "description": description,
        "icon": icon,
      };
}
