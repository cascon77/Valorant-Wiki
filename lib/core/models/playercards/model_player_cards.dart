import 'dart:convert';

class ModelPlayerCards {
  String uuid;
  String displayName;
  bool isHiddenIfNotOwned;
  String? themeUuid;
  String displayIcon;
  String smallArt;
  String wideArt;
  String? largeArt;
  String assetPath;

  ModelPlayerCards({
    required this.uuid,
    required this.displayName,
    required this.isHiddenIfNotOwned,
    required this.themeUuid,
    required this.displayIcon,
    required this.smallArt,
    required this.wideArt,
    required this.largeArt,
    required this.assetPath,
  });

  factory ModelPlayerCards.fromRawJson(String str) =>
      ModelPlayerCards.fromJson(json.decode(str));

  factory ModelPlayerCards.fromJson(Map<String, dynamic> json) =>
      ModelPlayerCards(
        uuid: json["uuid"],
        displayName: json["displayName"],
        isHiddenIfNotOwned: json["isHiddenIfNotOwned"],
        themeUuid: json["themeUuid"],
        displayIcon: json["displayIcon"],
        smallArt: json["smallArt"],
        wideArt: json["wideArt"],
        largeArt: json["largeArt"],
        assetPath: json["assetPath"],
      );
}
