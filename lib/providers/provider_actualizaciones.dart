import 'package:flutter/material.dart';
import 'package:wiki_valorant/services/services_valorant_scrapping.dart';

class ProviderActualizaciones with ChangeNotifier {
  final _scrappingService = ServicesValorantScrapping();
  List<Map<String, dynamic>> _actualizaciones = [];

  List<Map<String, dynamic>> get actualizaciones => _actualizaciones;

  Future<void> obtenerActualizaciones() async {
    _actualizaciones = await _scrappingService.getActualizaciones();
    notifyListeners();
  }

  Future<String> obtenerImagen(String link) async {
    return await _scrappingService.extractImage(link);
  }
}
