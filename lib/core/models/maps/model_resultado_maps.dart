import 'dart:convert';

import 'package:wiki_valorant/core/models/models.dart';

class ModelResultadoMapas {
  List<ModelMaps>? maps;

  ModelResultadoMapas({
    this.maps,
  });

  factory ModelResultadoMapas.fromRawJson(String str) =>
      ModelResultadoMapas.fromJson(json.decode(str));

  factory ModelResultadoMapas.fromJson(Map<String, dynamic> json) =>
      ModelResultadoMapas(
        maps: json['data'] == null
            ? null
            : List<ModelMaps>.from(
                json['data'].map((x) => ModelMaps.fromJson(x))),
      );
}
