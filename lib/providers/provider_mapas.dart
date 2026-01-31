import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderMapas with ChangeNotifier {
  Future<List<ModelMaps>> obtenerMapas() async {
    final lista = await servicioValorantApi.getMapas();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
