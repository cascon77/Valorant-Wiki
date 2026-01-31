import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderModosDeJuego with ChangeNotifier {
  Future<List<ModelGameMode>> obtenerModos() async {
    final lista = await servicioValorantApi.getModosDeJuego();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
