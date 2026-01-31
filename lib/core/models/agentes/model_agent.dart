import 'dart:convert';

import 'package:wiki_valorant/core/models/agentes/ability.dart';
import 'package:wiki_valorant/core/models/agentes/role.dart';

class ModelAgent {
  String uuid;
  String displayName;
  String description;
  String developerName;
  String? displayIcon;
  String? displayIconSmall;
  String? bustPortrait;
  String? fullPortrait;
  String? killfeedPortrait;
  String? background;
  List<String>? backgroundGradientColors;
  bool isFullPortraitRightFacing;
  bool isPlayableCharacter;
  Role role;
  List<Ability> abilities;

  ModelAgent({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.developerName,
    this.displayIcon,
    this.displayIconSmall,
    this.bustPortrait,
    this.fullPortrait,
    this.killfeedPortrait,
    this.background,
    this.backgroundGradientColors,
    required this.isFullPortraitRightFacing,
    required this.isPlayableCharacter,
    required this.role,
    required this.abilities,
  });

  factory ModelAgent.fromRawJson(String str) =>
      ModelAgent.fromJson(json.decode(str));

  factory ModelAgent.fromJson(Map<String, dynamic> json) => ModelAgent(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        developerName: json["developerName"],
        displayIcon: json["displayIcon"],
        displayIconSmall: json["displayIconSmall"],
        bustPortrait: json["bustPortrait"],
        fullPortrait: json["fullPortrait"],
        killfeedPortrait: json["killfeedPortrait"],
        background: json["background"],
        backgroundGradientColors: json["backgroundGradientColors"] != null
            ? List<String>.from(json["backgroundGradientColors"])
            : null,
        isFullPortraitRightFacing: json["isFullPortraitRightFacing"],
        isPlayableCharacter: json["isPlayableCharacter"],
        role: Role.fromJson(json["role"]),
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
      );
}
