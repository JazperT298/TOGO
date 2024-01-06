// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:flukit_icons/flukit_icons.dart';
import 'package:ibank/utils/core/products.dart';

/// Product category model
class ShopProductCategory {
  String name, description;
  FluIcons icon;
  Color color;

  ShopProductCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });

  static List<ShopProductCategory> getAll() => categories;
}

/// Product image model.
class ShopProductImage {
  String url;
  String createdAt;
  String? updatedAt;

  ShopProductImage({
    required this.url,
    required this.createdAt,
    this.updatedAt,
  });

  factory ShopProductImage.fromJson(Map<String, dynamic> json) => ShopProductImage(
        url: json["url"] as String,
        createdAt: json["createdAt"] as String,
        updatedAt: json["updatedAt"] as String,
      );
}

/// Product model.
class ShopProduct {
  String id;
  String name;
  String description;
  List<ShopProductImage> images;
  double price;
  int quantity;
  String category;
  String createdAt;
  String? updatedAt;

  ShopProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.quantity,
    required this.category,
    required this.createdAt,
    this.updatedAt,
  });

  factory ShopProduct.fromJson(Map<String, dynamic> json) => ShopProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        images: json["images"]?.map((x) => ShopProductImage.fromJson(x)).toList() ?? [],
        price: json["price"].toDouble(),
        quantity: json["quantity"],
        category: json["category"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "images": images,
        "price": price,
        "quantity": quantity,
        "category": category,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static List<ShopProduct> getAll() => products;
}
