import 'dart:convert';

import 'package:wiki_valorant/core/models/agentes/model_agent.dart';

class ModelResultadoAgentes {
  List<ModelAgent> agents;

  ModelResultadoAgentes({
    required this.agents,
  });

  factory ModelResultadoAgentes.fromRawJson(String str) =>
      ModelResultadoAgentes.fromJson(json.decode(str));

  factory ModelResultadoAgentes.fromJson(Map<String, dynamic> json) =>
      ModelResultadoAgentes(
        agents: List<ModelAgent>.from(
          json['data'].map((x) => ModelAgent.fromJson(x)),
        ),
      );
}
