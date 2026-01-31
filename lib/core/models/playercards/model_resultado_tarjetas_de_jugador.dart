import 'dart:convert';

import 'package:wiki_valorant/core/models/playercards/model_player_cards.dart';

class ModelResultadoTarjetasDeJugador {
  List<ModelPlayerCards>? playerCards;

  ModelResultadoTarjetasDeJugador({
    this.playerCards,
  });

  factory ModelResultadoTarjetasDeJugador.fromRawJson(String str) =>
      ModelResultadoTarjetasDeJugador.fromJson(json.decode(str));

  factory ModelResultadoTarjetasDeJugador.fromJson(Map<String, dynamic> json) =>
      ModelResultadoTarjetasDeJugador(
        playerCards: json['data'] == null
            ? null
            : List<ModelPlayerCards>.from(
                json['data'].map((x) => ModelPlayerCards.fromJson(x))),
      );
}
