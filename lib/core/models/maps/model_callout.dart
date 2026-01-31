import 'dart:convert';

import 'package:wiki_valorant/core/models/maps/model_location.dart';

class Callout {
  String regionName;
  String superRegionName;
  Location location;

  Callout({
    required this.regionName,
    required this.superRegionName,
    required this.location,
  });
  factory Callout.fromRawJson(String str) => Callout.fromJson(json.decode(str));

  factory Callout.fromJson(Map<String, dynamic> json) => Callout(
        regionName: json["regionName"],
        superRegionName: json["superRegionName"],
        location: Location.fromJson(json["location"]),
      );
}
