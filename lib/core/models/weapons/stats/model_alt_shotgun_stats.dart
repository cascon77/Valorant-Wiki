import 'dart:convert';

class AltShotgunStats {
  int? shotgunPelletCount;
  double? burstRate;

  AltShotgunStats({
    this.shotgunPelletCount,
    this.burstRate,
  });

  factory AltShotgunStats.fromRawJson(String str) =>
      AltShotgunStats.fromJson(json.decode(str));

  factory AltShotgunStats.fromJson(Map<String, dynamic> json) =>
      AltShotgunStats(
        shotgunPelletCount: json["shotgunPelletCount"],
        burstRate: json["burstRate"]?.toDouble(),
      );
}
