import 'dart:convert';

class Role {
  String uuid;
  String displayName;
  String description;
  String? displayIcon;

  Role({
    required this.uuid,
    required this.displayName,
    required this.description,
    this.displayIcon,
  });

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        uuid: json["uuid"],
        displayName: json["displayName"],
        description: json["description"],
        displayIcon: json["displayIcon"],
      );
}
