import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/services/services_valorant_api.dart';

class ProviderAmuletos with ChangeNotifier {
  Future<List<ModelBuddies>> obtenerAmuletos() async {
    final lista = await servicioValorantApi.getAmuletos();
    return lista!;
  }
}

final servicioValorantApi = ServicesValorantApi();
