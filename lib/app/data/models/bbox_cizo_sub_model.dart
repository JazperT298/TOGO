// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flukit/flukit.dart';

List<BBoxCizoSubModel> bBoxCizoSubModelFromJson(String str) => List<BBoxCizoSubModel>.from(json.decode(str).map((x) => BBoxCizoSubModel.fromJson(x)));

String bBoxCizoSubModelToJson(List<BBoxCizoSubModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BBoxCizoSubModel {
  String title;
  String description;
  FluIcons icon;

  BBoxCizoSubModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory BBoxCizoSubModel.fromJson(Map<dynamic, dynamic> json) => BBoxCizoSubModel(
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
