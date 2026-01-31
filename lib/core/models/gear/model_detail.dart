import 'dart:convert';

class Detail {
  String name;
  String value;

  Detail({
    required this.name,
    required this.value,
  });
  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        value: json["value"],
      );
}
