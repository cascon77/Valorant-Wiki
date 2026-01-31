import 'dart:convert';

import 'package:wiki_valorant/core/models/sprays/model_level.dart';

class ModelSprays {
  String uuid;
  String displayName;
  String? category;
  String? themeUuid;
  bool isNullSpray;
  bool hideIfNotOwned;
  String displayIcon;
  String? fullIcon;
  String? fullTransparentIcon;
  String? animationPng;
  String? animationGif;
  String assetPath;
  List<LevelSpray> levels;

  ModelSprays({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.themeUuid,
    required this.isNullSpray,
    required this.hideIfNotOwned,
    required this.displayIcon,
    required this.fullIcon,
    required this.fullTransparentIcon,
    required this.animationPng,
    required this.animationGif,
    required this.assetPath,
    required this.levels,
  });

  factory ModelSprays.fromRawJson(String str) =>
      ModelSprays.fromJson(json.decode(str));

  factory ModelSprays.fromJson(Map<String, dynamic> json) => ModelSprays(
        uuid: json["uuid"],
        displayName: json["displayName"],
        category: json["category"],
        themeUuid: json["themeUuid"],
        isNullSpray: json["isNullSpray"],
        hideIfNotOwned: json["hideIfNotOwned"],
        displayIcon: json["displayIcon"],
        fullIcon: json["fullIcon"],
        fullTransparentIcon: json["fullTransparentIcon"],
        animationPng: json["animationPng"],
        animationGif: json["animationGif"],
        assetPath: json["assetPath"],
        levels: List<LevelSpray>.from(
            json["levels"].map((x) => LevelSpray.fromJson(x))),
      );
}
