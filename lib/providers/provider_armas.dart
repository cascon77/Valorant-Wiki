import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderArmas with ChangeNotifier {
  Future<List<ModelWeapons>> obtenerArmas() async {
    final lista = await servicioValorantApi.getArmas();
    return lista!;
  }
  Future<List<ModelContentTiers>> obtenerContentTiers() async {
    final lista = await servicioValorantApi.getContentTiers();
    return lista!;
  }
}



final servicioValorantApi = ServicesValorantApi();
