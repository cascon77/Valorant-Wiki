import 'dart:convert';

import 'package:wiki_valorant/core/models/weapons/stats/model_weapon_stats.dart';
import 'package:wiki_valorant/core/models/weapons/shopdata/model_shop_data.dart';
import 'package:wiki_valorant/core/models/weapons/skins/model_skins.dart';

class ModelWeapons {
  String? uuid;
  String displayName;
  String category;
  String? defaultSkinUuid;
  String displayIcon;
  String? killStreamIcon;
  String? assetPath;
  WeaponStats? weaponStats;
  ShopDataWeapon? shopData;
  List<Skin>? skins;

  ModelWeapons({
    this.uuid,
    required this.displayName,
    required this.category,
    this.defaultSkinUuid,
    required this.displayIcon,
    this.killStreamIcon,
    this.assetPath,
    this.weaponStats,
    this.shopData,
    this.skins,
  });

  factory ModelWeapons.fromRawJson(String str) =>
      ModelWeapons.fromJson(json.decode(str));

  factory ModelWeapons.fromJson(Map<String, dynamic> json) => ModelWeapons(
        uuid: json["uuid"],
        displayName: json["displayName"],
        category: json["category"]
            .toString()
            .substring("EEquippableCategory::".length),
        defaultSkinUuid: json["defaultSkinUuid"],
        displayIcon: json["displayIcon"],
        killStreamIcon: json["killStreamIcon"],
        assetPath: json["assetPath"],
        weaponStats: json["weaponStats"] == null
            ? null
            : WeaponStats.fromJson(json["weaponStats"]),
        shopData: json["shopData"] == null
            ? null
            : ShopDataWeapon.fromJson(json["shopData"]),
        skins: json["skins"] == null
            ? null
            : List<Skin>.from(json["skins"].map((x) => Skin.fromJson(x))),
      );
}
