import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderAgentes with ChangeNotifier {
  Future<List<ModelAgent>> obtenerAgentes() async {
    final lista = await servicioValorantApi.getAgentes();
    return lista;
  }
}

final servicioValorantApi = ServicesValorantApi();
