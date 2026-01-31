import 'dart:convert';

class GameRuleBoolOverride {
  String ruleName;
  bool state;

  GameRuleBoolOverride({
    required this.ruleName,
    required this.state,
  });

  factory GameRuleBoolOverride.fromRawJson(String str) =>
      GameRuleBoolOverride.fromJson(json.decode(str));

  factory GameRuleBoolOverride.fromJson(Map<String, dynamic> json) =>
      GameRuleBoolOverride(
        ruleName: json["ruleName"],
        state: json["state"],
      );
}
