import 'dart:convert';

import 'package:wiki_valorant/core/models/weapons/skins/model_chroma.dart';
import 'package:wiki_valorant/core/models/weapons/skins/model_level.dart';

class Skin {
  String? uuid;
  String displayName;
  String? themeUuid;
  String? contentTierUuid;
  String? displayIcon;
  String? wallpaper;
  String? assetPath;
  List<Chroma>? chromas;
  List<LevelSkin>? levels;

  Skin({
    this.uuid,
    required this.displayName,
    this.themeUuid,
    this.contentTierUuid,
    this.displayIcon,
    this.wallpaper,
    this.assetPath,
    this.chromas,
    this.levels,
  });
  factory Skin.fromRawJson(String str) => Skin.fromJson(json.decode(str));

  factory Skin.fromJson(Map<String, dynamic> json) => Skin(
        uuid: json["uuid"],
        displayName: json["displayName"],
        themeUuid: json["themeUuid"],
        contentTierUuid: json["contentTierUuid"],
        displayIcon: json["displayIcon"],
        wallpaper: json["wallpaper"],
        assetPath: json["assetPath"],
        chromas:
            List<Chroma>.from(json["chromas"]?.map((x) => Chroma.fromJson(x))),
        levels: List<LevelSkin>.from(
            json["levels"]?.map((x) => LevelSkin.fromJson(x))),
      );
}
