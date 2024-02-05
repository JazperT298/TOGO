// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flukit/flukit.dart';

List<CashPowerSubModel> cashPowerSubModelFromJson(String str) =>
    List<CashPowerSubModel>.from(json.decode(str).map((x) => CashPowerSubModel.fromJson(x)));

String cashPowerSubModelToJson(List<CashPowerSubModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashPowerSubModel {
  String title;
  String description;
  FluIcons icon;

  CashPowerSubModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory CashPowerSubModel.fromJson(Map<dynamic, dynamic> json) => CashPowerSubModel(
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
