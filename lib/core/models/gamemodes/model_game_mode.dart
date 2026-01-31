import 'dart:convert';

import 'package:wiki_valorant/core/models/gamemodes/model_freature_override.dart';
import 'package:wiki_valorant/core/models/gamemodes/model_game_rule_bool_override.dart';

class ModelGameMode {
  String uuid;
  String displayName;
  String? description;
  String? duration;
  String? economyType;
  bool allowsMatchTimeouts;
  bool isTeamVoiceAllowed;
  bool isMinimapHidden;
  int orbCount;
  int roundsPerHalf;
  List<String>? teamRoles;
  List<GameFeatureOverride>? gameFeatureOverrides;
  List<GameRuleBoolOverride>? gameRuleBoolOverrides;
  String? displayIcon;
  String? listViewIconTall;
  String assetPath;

  ModelGameMode({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.duration,
    required this.economyType,
    required this.allowsMatchTimeouts,
    required this.isTeamVoiceAllowed,
    required this.isMinimapHidden,
    required this.orbCount,
    required this.roundsPerHalf,
    required this.teamRoles,
    required this.gameFeatureOverrides,
    required this.gameRuleBoolOverrides,
    required this.displayIcon,
    required this.listViewIconTall,
    required this.assetPath,
  });

  factory ModelGameMode.fromRawJson(String str) =>
      ModelGameMode.fromJson(json.decode(str));

  factory ModelGameMode.fromJson(Map<String, dynamic> json) => ModelGameMode(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        duration: json["duration"],
        economyType: json["economyType"],
        allowsMatchTimeouts: json["allowsMatchTimeouts"],
        isTeamVoiceAllowed: json["isTeamVoiceAllowed"],
        isMinimapHidden: json["isMinimapHidden"],
        orbCount: json["orbCount"],
        roundsPerHalf: json["roundsPerHalf"],
        teamRoles: json["teamRoles"] == null
            ? null
            : List<String>.from(json["teamRoles"]),
        gameFeatureOverrides: json["gameFeatureOverrides"] == null
            ? null
            : List<GameFeatureOverride>.from(json["gameFeatureOverrides"]
                .map((x) => GameFeatureOverride.fromJson(x))),
        gameRuleBoolOverrides: json["gameRuleBoolOverrides"] == null
            ? null
            : List<GameRuleBoolOverride>.from(json["gameRuleBoolOverrides"]
                .map((x) => GameRuleBoolOverride.fromJson(x))),
        displayIcon: json["displayIcon"],
        listViewIconTall: json["listViewIconTall"],
        assetPath: json["assetPath"],
      );
}
