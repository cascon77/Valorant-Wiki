import 'dart:convert';

class AirBurstStats {
  int? shotgunPelletCount;
  double? burstDistance;

  AirBurstStats({
    this.shotgunPelletCount,
    this.burstDistance,
  });
  factory AirBurstStats.fromRawJson(String str) =>
      AirBurstStats.fromJson(json.decode(str));

  factory AirBurstStats.fromJson(Map<String, dynamic> json) => AirBurstStats(
        shotgunPelletCount: json["shotgunPelletCount"],
        burstDistance: json["burstDistance"]?.toDouble(),
      );
}
