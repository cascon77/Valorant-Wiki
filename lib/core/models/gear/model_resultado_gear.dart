import 'dart:convert';

import 'package:wiki_valorant/core/models/gear/model_gear.dart';

class ModelResultadoGear {
  List<ModelGear>? gears;

  ModelResultadoGear({
    this.gears,
  });

  factory ModelResultadoGear.fromRawJson(String str) =>
      ModelResultadoGear.fromJson(json.decode(str));

  factory ModelResultadoGear.fromJson(Map<String, dynamic> json) =>
      ModelResultadoGear(
        gears: json['data'] == null
            ? null
            : List<ModelGear>.from(
                json['data'].map((x) => ModelGear.fromJson(x))),
      );
}
