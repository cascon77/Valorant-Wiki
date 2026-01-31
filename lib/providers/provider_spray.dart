import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderSpray with ChangeNotifier {
  Future<List<ModelSprays>> obtenerSprays() async {
    final lista = await servicioValorantApi.getSprays();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
