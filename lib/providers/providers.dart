import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/material_wiki_valorant.dart';
import 'package:wiki_valorant/providers/provider_actualizaciones.dart';
import 'package:wiki_valorant/providers/provider_agentes.dart';
import 'package:wiki_valorant/providers/provider_amuletos.dart';
import 'package:wiki_valorant/providers/provider_armas.dart';
import 'package:wiki_valorant/providers/provider_escudos.dart';
import 'package:wiki_valorant/providers/provider_mapas.dart';
import 'package:wiki_valorant/providers/provider_modos_de_juego.dart';
import 'package:wiki_valorant/providers/provider_spray.dart';
import 'package:wiki_valorant/providers/provider_tarjetas_jugador.dart';

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderAgentes()),
        ChangeNotifierProvider(create: (_) => ProviderArmas()),
        ChangeNotifierProvider(create: (_) => ProviderEscudos()),
        ChangeNotifierProvider(create: (_) => ProviderMapas()),
        ChangeNotifierProvider(create: (_) => ProviderAmuletos()),
        ChangeNotifierProvider(create: (_) => ProviderModosDeJuego()),
        ChangeNotifierProvider(create: (_) => ProviderTarjetasJugador()),
        ChangeNotifierProvider(create: (_) => ProviderSpray()),
        ChangeNotifierProvider(create: (_) => ProviderActualizaciones()),
      ],
      child: MaterialWikiValorant(),
    );
  }
}
