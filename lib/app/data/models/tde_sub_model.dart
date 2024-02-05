// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:flukit/flukit.dart';

List<TDESubModel> tdeSubModelFromJson(String str) => List<TDESubModel>.from(json.decode(str).map((x) => TDESubModel.fromJson(x)));

String tdeSubModelToJson(List<TDESubModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TDESubModel {
  String title;
  String description;
  FluIcons icon;

  TDESubModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory TDESubModel.fromJson(Map<dynamic, dynamic> json) => TDESubModel(
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
