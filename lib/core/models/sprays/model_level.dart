import 'dart:convert';

class LevelSpray {
  String uuid;
  int sprayLevel;
  String displayName;
  String? displayIcon;
  String assetPath;

  LevelSpray({
    required this.uuid,
    required this.sprayLevel,
    required this.displayName,
    required this.displayIcon,
    required this.assetPath,
  });

  factory LevelSpray.fromRawJson(String str) =>
      LevelSpray.fromJson(json.decode(str));

  factory LevelSpray.fromJson(Map<String, dynamic> json) => LevelSpray(
        uuid: json["uuid"],
        sprayLevel: json["sprayLevel"],
        displayName: json["displayName"],
        displayIcon: json["displayIcon"],
        assetPath: json["assetPath"],
      );
}
