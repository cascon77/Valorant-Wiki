import 'dart:convert';

class AdsStats {
  double? zoomMultiplier;
  double? fireRate;
  double? runSpeedMultiplier;
  int? burstCount;
  double? firstBulletAccuracy;

  AdsStats({
    this.zoomMultiplier,
    this.fireRate,
    this.runSpeedMultiplier,
    this.burstCount,
    this.firstBulletAccuracy,
  });
  factory AdsStats.fromRawJson(String str) =>
      AdsStats.fromJson(json.decode(str));

  factory AdsStats.fromJson(Map<String, dynamic> json) => AdsStats(
        zoomMultiplier: json["zoomMultiplier"]?.toDouble(),
        fireRate: json["fireRate"]?.toDouble(),
        runSpeedMultiplier: json["runSpeedMultiplier"]?.toDouble(),
        burstCount: json["burstCount"],
        firstBulletAccuracy: json["firstBulletAccuracy"]?.toDouble(),
      );
}
