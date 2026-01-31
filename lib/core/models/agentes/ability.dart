import 'dart:convert';

class Ability {
  String slot;
  String displayName;
  String description;
  String? displayIcon;

  Ability({
    required this.slot,
    required this.displayName,
    required this.description,
    this.displayIcon,
  });

  factory Ability.fromRawJson(String str) => Ability.fromJson(json.decode(str));

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        slot: json["slot"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
      );
}
