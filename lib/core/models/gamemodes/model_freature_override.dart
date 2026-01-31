import 'dart:convert';

class GameFeatureOverride {
  String featureName;
  bool state;

  GameFeatureOverride({
    required this.featureName,
    required this.state,
  });

  factory GameFeatureOverride.fromRawJson(String str) =>
      GameFeatureOverride.fromJson(json.decode(str));

  factory GameFeatureOverride.fromJson(Map<String, dynamic> json) =>
      GameFeatureOverride(
        featureName: json["featureName"],
        state: json["state"],
      );
}
