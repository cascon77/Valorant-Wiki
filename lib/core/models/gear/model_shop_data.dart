import 'dart:convert';

class ShopDataGear {
  int cost;
  String category;
  int shopOrderPriority;
  String categoryText;
  dynamic gridPosition;
  bool canBeTrashed;
  dynamic image;
  String newImage;
  dynamic newImage2;
  String assetPath;

  ShopDataGear({
    required this.cost,
    required this.category,
    required this.shopOrderPriority,
    required this.categoryText,
    required this.gridPosition,
    required this.canBeTrashed,
    required this.image,
    required this.newImage,
    required this.newImage2,
    required this.assetPath,
  });
  factory ShopDataGear.fromRawJson(String str) =>
      ShopDataGear.fromJson(json.decode(str));

  factory ShopDataGear.fromJson(Map<String, dynamic> json) => ShopDataGear(
        cost: json["cost"],
        category: json["category"],
        shopOrderPriority: json["shopOrderPriority"],
        categoryText: json["categoryText"],
        gridPosition: json["gridPosition"],
        canBeTrashed: json["canBeTrashed"],
        image: json["image"],
        newImage: json["newImage"],
        newImage2: json["newImage2"],
        assetPath: json["assetPath"],
      );
}
