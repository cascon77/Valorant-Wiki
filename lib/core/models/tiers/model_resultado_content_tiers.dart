import 'dart:convert';
import 'package:wiki_valorant/core/models/models.dart';

class ModelResultadoContentTiers {
  List<ModelContentTiers>? contentTiers;

  ModelResultadoContentTiers({
    this.contentTiers,
  });

  factory ModelResultadoContentTiers.fromRawJson(String str) =>
      ModelResultadoContentTiers.fromJson(json.decode(str));

  factory ModelResultadoContentTiers.fromJson(Map<String, dynamic> json) =>
      ModelResultadoContentTiers(
        contentTiers: json['data'] == null
            ? null
            : List<ModelContentTiers>.from(
                json['data'].map((x) => ModelContentTiers.fromJson(x))),
      );
}
