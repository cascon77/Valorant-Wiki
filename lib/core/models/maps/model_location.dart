import 'dart:convert';

class Location {
  double x;
  double y;

  Location({
    required this.x,
    required this.y,
  });
  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
      );
}
