import 'dart:convert';

import 'package:wiki_valorant/core/models/weapons/model_weapons.dart';

class ModelResultadoWeapons {
  List<ModelWeapons>? weapons;

  ModelResultadoWeapons({
    this.weapons,
  });

  factory ModelResultadoWeapons.fromRawJson(String str) =>
      ModelResultadoWeapons.fromJson(json.decode(str));

  factory ModelResultadoWeapons.fromJson(Map<String, dynamic> json) =>
      ModelResultadoWeapons(
        weapons: json['data'] == null
            ? null
            : List<ModelWeapons>.from(
                json['data'].map((x) => ModelWeapons.fromJson(x))),
      );
}
