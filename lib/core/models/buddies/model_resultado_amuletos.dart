import 'dart:convert';

import 'package:wiki_valorant/core/models/buddies/model_buddies.dart';

class ModelResultadoAmuletos {
  List<ModelBuddies>? buddies;

  ModelResultadoAmuletos({
    this.buddies,
  });

  factory ModelResultadoAmuletos.fromRawJson(String str) =>
      ModelResultadoAmuletos.fromJson(json.decode(str));

  factory ModelResultadoAmuletos.fromJson(Map<String, dynamic> json) =>
      ModelResultadoAmuletos(
        buddies: json['data'] == null
            ? null
            : List<ModelBuddies>.from(
                json['data'].map((x) => ModelBuddies.fromJson(x))),
      );
}
