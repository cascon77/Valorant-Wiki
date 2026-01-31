import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderTarjetasJugador with ChangeNotifier {
  Future<List<ModelPlayerCards>> obtenerTarjetas() async {
    final lista = await servicioValorantApi.getPlayerCards();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
