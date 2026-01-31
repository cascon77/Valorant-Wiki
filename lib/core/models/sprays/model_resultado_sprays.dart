import 'dart:convert';

import 'package:wiki_valorant/core/models/models.dart';

class ModelResultadoSprays {
  List<ModelSprays>? sprays;

  ModelResultadoSprays({
    this.sprays,
  });

  factory ModelResultadoSprays.fromRawJson(String str) =>
      ModelResultadoSprays.fromJson(json.decode(str));

  factory ModelResultadoSprays.fromJson(Map<String, dynamic> json) =>
      ModelResultadoSprays(
        sprays: json['data'] == null
            ? null
            : List<ModelSprays>.from(
                json['data'].map((x) => ModelSprays.fromJson(x))),
      );
}
