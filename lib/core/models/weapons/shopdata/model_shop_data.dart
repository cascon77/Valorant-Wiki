import 'dart:convert';

import 'package:wiki_valorant/core/models/weapons/shopdata/model_grip_position.dart';

class ShopDataWeapon {
  int? cost;
  String? category;
  int? shopOrderPriority;
  String? categoryText;
  GridPosition? gridPosition;
  bool? canBeTrashed;
  dynamic image;
  String? newImage;
  dynamic newImage2;
  String? assetPath;

  ShopDataWeapon({
    this.cost,
    this.category,
    this.shopOrderPriority,
    this.categoryText,
    this.gridPosition,
    this.canBeTrashed,
    this.image,
    this.newImage,
    this.newImage2,
    this.assetPath,
  });
  factory ShopDataWeapon.fromRawJson(String str) =>
      ShopDataWeapon.fromJson(json.decode(str));

  factory ShopDataWeapon.fromJson(Map<String, dynamic> json) => ShopDataWeapon(
        cost: json["cost"],
        category: json["category"],
        shopOrderPriority: json["shopOrderPriority"],
        categoryText: json["categoryText"],
        gridPosition: json["gridPosition"] == null
            ? null
            : GridPosition.fromJson(json["gridPosition"]),
        canBeTrashed: json["canBeTrashed"],
        image: json["image"],
        newImage: json["newImage"],
        newImage2: json["newImage2"],
        assetPath: json["assetPath"],
      );
}
