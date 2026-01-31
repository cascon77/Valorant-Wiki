import 'package:flutter/material.dart';
import 'package:wiki_valorant/screens/screens.dart';

class RoutesValorant {
  static const String home = "home";
  static const String agentes = "agents";
  static const String detailsAgentes = "detailagents";
  static const String amuletos = "buddies";
  static const String packSkins = "bundles";
  static const String modosDeJuegos = "gamemodes";
  static const String escudos = "gear";
  static const String detailsEscudos = "detailsgear";
  static const String mapas = "maps";
  static const String tarjetas = "playercards";
  static const String sprays = "sprays";
  static const String armas = "weapons";
  static const String detailsArmas = "detailweapons";
  static const String listaSkins = "listskins";
  static const String detailsMapa = "detailsMapa";
  static const String detailsGameMode = "detailsgamemode";
  static const String detailsSkin = "detailsskin";
  static const String ruleta = "ruleta";

  static Map<String, WidgetBuilder> getRoutes() => {
        home: (_) => HomeScreen(),
        agentes: (_) => AgenteScreen(),
        detailsAgentes: (_) => DetailAgenteScreen(),
        armas: (_) => WeaponScreen(),
        detailsArmas: (_) => DetailWeaponsScreen(),
        listaSkins: (_) => SkinsScreen(),
        escudos: (_) => GearScreen(),
        detailsEscudos: (_) => DetailsGearScreen(),
        mapas: (_) => MapsScreen(),
        amuletos: (_) => BuddiesScreen(),
        modosDeJuegos: (_) => GameModesScreen(),
        tarjetas: (_) => PlayerCardsScreen(),
        sprays: (_) => SpraysScreen(),
        detailsMapa: (_) => DetailsMapsScreen(),
        detailsGameMode: (_) => DetailsGameModeScreen(),
        detailsSkin: (_) => DetailSkinScreen(),
        ruleta: (_) => RuletaAgenteScreen(),
      };
}
