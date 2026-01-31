import 'dart:convert';

import 'package:wiki_valorant/core/models/weapons/stats/model_ads_stats.dart';
import 'package:wiki_valorant/core/models/weapons/stats/model_damage_range.dart';
import 'package:wiki_valorant/core/models/weapons/stats/model_air_burst_stats.dart';
import 'package:wiki_valorant/core/models/weapons/stats/model_alt_shotgun_stats.dart';

class WeaponStats {
  double? fireRate;
  int? magazineSize;
  double? runSpeedMultiplier;
  double? equipTimeSeconds;
  double? reloadTimeSeconds;
  double? firstBulletAccuracy;
  int? shotgunPelletCount;
  String? wallPenetration;
  String? feature;
  String? fireMode;
  String? altFireType;
  AdsStats? adsStats;
  AltShotgunStats? altShotgunStats;
  AirBurstStats? airBurstStats;
  List<DamageRange>? damageRanges;

  WeaponStats({
    this.fireRate,
    this.magazineSize,
    this.runSpeedMultiplier,
    this.equipTimeSeconds,
    this.reloadTimeSeconds,
    this.firstBulletAccuracy,
    this.shotgunPelletCount,
    this.wallPenetration,
    this.feature,
    this.fireMode,
    this.altFireType,
    this.adsStats,
    this.altShotgunStats,
    this.airBurstStats,
    this.damageRanges,
  });

  factory WeaponStats.fromRawJson(String str) =>
      WeaponStats.fromJson(json.decode(str));

  factory WeaponStats.fromJson(Map<String, dynamic> json) => WeaponStats(
        fireRate: json["fireRate"]?.toDouble(),
        magazineSize: json["magazineSize"],
        runSpeedMultiplier: json["runSpeedMultiplier"]?.toDouble(),
        equipTimeSeconds: json["equipTimeSeconds"]?.toDouble(),
        reloadTimeSeconds: json["reloadTimeSeconds"]?.toDouble(),
        firstBulletAccuracy: json["firstBulletAccuracy"]?.toDouble(),
        shotgunPelletCount: json["shotgunPelletCount"],
        wallPenetration: json["wallPenetration"]
            .toString()
            .substring("EWallPenetrationDisplayType::".length),
        feature: json["feature"],
        fireMode: json["fireMode"],
        altFireType: json["altFireType"],
        adsStats: json["adsStats"] == null
            ? null
            : AdsStats.fromJson(json["adsStats"]),
        altShotgunStats: json["altShotgunStats"] == null
            ? null
            : AltShotgunStats.fromJson(json["altShotgunStats"]),
        airBurstStats: json["airBurstStats"] == null
            ? null
            : AirBurstStats.fromJson(json["airBurstStats"]),
        damageRanges: json["damageRanges"] == null
            ? null
            : List<DamageRange>.from(
                json["damageRanges"].map((x) => DamageRange.fromJson(x))),
      );
}
