import 'dart:convert';

import 'package:wiki_valorant/core/models/gear/model_detail.dart';
import 'package:wiki_valorant/core/models/gear/model_shop_data.dart';

class ModelGear {
  String uuid;
  String displayName;
  String description;
  List<String> descriptions;
  List<Detail> details;
  String displayIcon;
  String assetPath;
  ShopDataGear shopData;

  ModelGear({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.descriptions,
    required this.details,
    required this.displayIcon,
    required this.assetPath,
    required this.shopData,
  });
  factory ModelGear.fromRawJson(String str) =>
      ModelGear.fromJson(json.decode(str));

  factory ModelGear.fromJson(Map<String, dynamic> json) => ModelGear(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        descriptions: List<String>.from(json["descriptions"].map((x) => x)),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
        shopData: ShopDataGear.fromJson(json["shopData"]),
      );
}
