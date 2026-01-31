import 'dart:convert';

class LevelBuddie {
  String uuid;
  int charmLevel;
  bool hideIfNotOwned;
  String displayName;
  String displayIcon;
  String assetPath;

  LevelBuddie({
    required this.uuid,
    required this.charmLevel,
    required this.hideIfNotOwned,
    required this.displayName,
    required this.displayIcon,
    required this.assetPath,
  });
  factory LevelBuddie.fromRawJson(String str) =>
      LevelBuddie.fromJson(json.decode(str));

  factory LevelBuddie.fromJson(Map<String, dynamic> json) => LevelBuddie(
        uuid: json["uuid"],
        charmLevel: json["charmLevel"],
        hideIfNotOwned: json["hideIfNotOwned"],
        displayName: json["displayName"],
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
      );
}
