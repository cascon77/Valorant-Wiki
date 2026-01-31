import 'dart:convert';

import 'package:wiki_valorant/core/models/maps/model_callout.dart';

class ModelMaps {
  String uuid;
  String displayName;
  dynamic narrativeDescription;
  String? tacticalDescription;
  String? coordinates;
  String? displayIcon;
  String listViewIcon;
  String? listViewIconTall;
  String splash;
  String? stylizedBackgroundImage;
  String? premierBackgroundImage;
  String assetPath;
  String mapUrl;
  double xMultiplier;
  double yMultiplier;
  double xScalarToAdd;
  double yScalarToAdd;
  List<Callout>? callouts;

  ModelMaps({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    required this.coordinates,
    required this.displayIcon,
    required this.listViewIcon,
    required this.listViewIconTall,
    required this.splash,
    required this.stylizedBackgroundImage,
    required this.premierBackgroundImage,
    required this.assetPath,
    required this.mapUrl,
    required this.xMultiplier,
    required this.yMultiplier,
    required this.xScalarToAdd,
    required this.yScalarToAdd,
    required this.callouts,
  });
  factory ModelMaps.fromRawJson(String str) =>
      ModelMaps.fromJson(json.decode(str));

  factory ModelMaps.fromJson(Map<String, dynamic> json) => ModelMaps(
        uuid: json["uuid"],
        displayName: json["displayName"],
        narrativeDescription: json["narrativeDescription"],
        tacticalDescription: json["tacticalDescription"],
        coordinates: json["coordinates"],
        displayIcon: json["displayIcon"],
        listViewIcon: json["listViewIcon"],
        listViewIconTall: json["listViewIconTall"],
        splash: json["splash"],
        stylizedBackgroundImage: json["stylizedBackgroundImage"],
        premierBackgroundImage: json["premierBackgroundImage"],
        assetPath: json["assetPath"],
        mapUrl: json["mapUrl"],
        xMultiplier: json["xMultiplier"].toDouble(),
        yMultiplier: json["yMultiplier"].toDouble(),
        xScalarToAdd: json["xScalarToAdd"].toDouble(),
        yScalarToAdd: json["yScalarToAdd"].toDouble(),
        callouts: json["callouts"] == null
            ? null
            : List<Callout>.from(
                json["callouts"].map((x) => Callout.fromJson(x))),
      );
}
