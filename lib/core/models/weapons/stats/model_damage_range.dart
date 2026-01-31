import 'dart:convert';

class DamageRange {
  int? rangeStartMeters;
  int? rangeEndMeters;
  double? headDamage;
  int? bodyDamage;
  double? legDamage;

  DamageRange({
    this.rangeStartMeters,
    this.rangeEndMeters,
    this.headDamage,
    this.bodyDamage,
    this.legDamage,
  });
  factory DamageRange.fromRawJson(String str) =>
      DamageRange.fromJson(json.decode(str));

  factory DamageRange.fromJson(Map<String, dynamic> json) => DamageRange(
        rangeStartMeters: json["rangeStartMeters"],
        rangeEndMeters: json["rangeEndMeters"],
        headDamage: json["headDamage"]?.toDouble(),
        bodyDamage: json["bodyDamage"],
        legDamage: json["legDamage"]?.toDouble(),
      );
}
