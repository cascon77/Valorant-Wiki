import 'dart:convert';

import 'package:wiki_valorant/core/models/buddies/model_level.dart';

class ModelBuddies {
  String uuid;
  String displayName;
  bool isHiddenIfNotOwned;
  String? themeUuid;
  String displayIcon;
  String assetPath;
  List<LevelBuddie> levels;

  ModelBuddies({
    required this.uuid,
    required this.displayName,
    required this.isHiddenIfNotOwned,
    required this.themeUuid,
    required this.displayIcon,
    required this.assetPath,
    required this.levels,
  });
  factory ModelBuddies.fromRawJson(String str) =>
      ModelBuddies.fromJson(json.decode(str));

  factory ModelBuddies.fromJson(Map<String, dynamic> json) => ModelBuddies(
        uuid: json["uuid"],
        displayName: json["displayName"],
        isHiddenIfNotOwned: json["isHiddenIfNotOwned"],
        themeUuid: json["themeUuid"],
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
        levels: List<LevelBuddie>.from(
            json["levels"].map((x) => LevelBuddie.fromJson(x))),
      );
}
