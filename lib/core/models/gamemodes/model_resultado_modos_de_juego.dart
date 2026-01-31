import 'dart:convert';

import 'package:wiki_valorant/core/models/gamemodes/model_game_mode.dart';

class ModelResultadoModosDeJuego {
  List<ModelGameMode>? gamemode;

  ModelResultadoModosDeJuego({
    this.gamemode,
  });

  factory ModelResultadoModosDeJuego.fromRawJson(String str) =>
      ModelResultadoModosDeJuego.fromJson(json.decode(str));

  factory ModelResultadoModosDeJuego.fromJson(Map<String, dynamic> json) =>
      ModelResultadoModosDeJuego(
        gamemode: json['data'] == null
            ? null
            : List<ModelGameMode>.from(
                json['data'].map((x) => ModelGameMode.fromJson(x))),
      );
}
