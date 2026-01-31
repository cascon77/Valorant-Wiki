import 'dart:convert';

class LevelSkin {
  String? uuid;
  String? displayName;
  String? levelItem;
  String? displayIcon;
  String? streamedVideo;
  String? assetPath;

  LevelSkin({
    this.uuid,
    this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    this.assetPath,
  });
  factory LevelSkin.fromRawJson(String str) =>
      LevelSkin.fromJson(json.decode(str));

  factory LevelSkin.fromJson(Map<String, dynamic> json) => LevelSkin(
        uuid: json["uuid"],
        displayName: json["displayName"],
        levelItem: json["levelItem"],
        displayIcon: json["displayIcon"],
        streamedVideo: json["streamedVideo"],
        assetPath: json["assetPath"],
      );
}
