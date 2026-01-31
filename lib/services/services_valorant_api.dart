import 'package:http/http.dart' as http;
import 'package:wiki_valorant/core/models/models.dart';

class ServicesValorantApi {
  static const _urlPrincipal = "valorant-api.com";
  static const _apiPath = "/v1/";
  static const _language = "es-ES";
  static const _isPlayableCharacter = true;
  static const _agents = "agents";
  static const _buddies = "buddies";
  static const _gamemodes = "gamemodes";
  static const _gear = "gear";
  static const _maps = "maps";
  static const _playercards = "playercards";
  static const _sprays = "sprays";
  static const _weapons = "weapons";
  static const _contenttiers = "contenttiers";

  Future<List<ModelAgent>> getAgentes() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_agents', {
      'language': _language,
      'isPlayableCharacter': "$_isPlayableCharacter"
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelAgentes = ModelResultadoAgentes.fromRawJson(response.body);
      return modelAgentes.agents;
    } else {
      return [];
    }
  }

  Future<List<ModelWeapons>?> getArmas() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_weapons', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelWeapons = ModelResultadoWeapons.fromRawJson(response.body);
      return modelWeapons.weapons;
    } else {
      return [];
    }
  }

  Future<List<ModelGear>?> getEscudos() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_gear', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelGear = ModelResultadoGear.fromRawJson(response.body);
      return modelGear.gears;
    } else {
      return [];
    }
  }

  Future<List<ModelMaps>?> getMapas() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_maps', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelMaps = ModelResultadoMapas.fromRawJson(response.body);
      return modelMaps.maps;
    } else {
      return [];
    }
  }

  Future<List<ModelBuddies>?> getAmuletos() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_buddies', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelbuddies = ModelResultadoAmuletos.fromRawJson(response.body);
      return modelbuddies.buddies;
    } else {
      return [];
    }
  }

  Future<List<ModelGameMode>?> getModosDeJuego() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_gamemodes', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelGameModes =
          ModelResultadoModosDeJuego.fromRawJson(response.body);
      return modelGameModes.gamemode;
    } else {
      return [];
    }
  }

  Future<List<ModelPlayerCards>?> getPlayerCards() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_playercards', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelplayerCards =
          ModelResultadoTarjetasDeJugador.fromRawJson(response.body);
      return modelplayerCards.playerCards;
    } else {
      return [];
    }
  }

  Future<List<ModelSprays>?> getSprays() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_sprays', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelSprays = ModelResultadoSprays.fromRawJson(response.body);
      return modelSprays.sprays;
    } else {
      return [];
    }
  }

  Future<List<ModelContentTiers>?> getContentTiers() async {
    var url = Uri.https(_urlPrincipal, '$_apiPath$_contenttiers', {
      'language': _language,
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var modelContentTiers =
          ModelResultadoContentTiers.fromRawJson(response.body);
      return modelContentTiers.contentTiers;
    } else {
      return [];
    }
  }
}
