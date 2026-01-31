import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderEscudos with ChangeNotifier {
  Future<List<ModelGear>> obtenerEscudos() async {
    final lista = await servicioValorantApi.getEscudos();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
