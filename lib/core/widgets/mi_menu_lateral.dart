import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class MiMenuLateral extends StatelessWidget {
  final String pagina;
  const MiMenuLateral({super.key, required this.pagina});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Fondo principal del drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/jettPortada.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: BorderedText(
                  strokeColor: Colors.redAccent,
                  strokeWidth: 3,
                  child: const Text(
                    "Wiki Valorant",
                    style: TextStyle(
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            ...listaDeVentanas(context, pagina),
          ],
        ),
      ),
    );
  }

  List<Widget> listaDeVentanas(BuildContext context, String paginaActual) {
    return [
      _crearListTile(
        context,
        "Home",
        Icons.home,
        "home",
        paginaActual,
        RoutesValorant.home,
      ),
      _crearListTile(
        context,
        "Agentes",
        Icons.person,
        "agents",
        paginaActual,
        RoutesValorant.agentes,
      ),
      _crearListTile(
        context,
        "Armas",
        FontAwesome5.crosshairs,
        "weapons",
        paginaActual,
        RoutesValorant.armas,
      ),
      _crearListTile(
        context,
        "Escudos",
        Icons.shield,
        "gear",
        paginaActual,
        RoutesValorant.escudos,
      ),
      _crearListTile(
        context,
        "Mapas",
        Icons.map,
        "maps",
        paginaActual,
        RoutesValorant.mapas,
      ),
      _crearListTile(
        context,
        "Amuletos",
        Icons.discount,
        "buddies",
        paginaActual,
        RoutesValorant.amuletos,
      ),
      _crearListTile(
        context,
        "Modos de juego",
        FontAwesome5.gamepad,
        "gamemodes",
        paginaActual,
        RoutesValorant.modosDeJuegos,
      ),
      _crearListTile(
        context,
        "Tarjetas de jugador",
        FontAwesome5.id_card_alt,
        "playercards",
        paginaActual,
        RoutesValorant.tarjetas,
      ),
      _crearListTile(
        context,
        "Sprays",
        FontAwesome5.spray_can,
        "sprays",
        paginaActual,
        RoutesValorant.sprays,
      ),
      const Divider(color: Colors.white),
      ListTile(
        title: const Text(
          "Salir",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertaSalidaAplicacion();
            },
          );
        },
      ),
    ];
  }

  Widget _crearListTile(
    BuildContext context,
    String titulo,
    IconData icono,
    String nombrePagina,
    String paginaActual,
    String ruta,
  ) {
    return ListTile(
      title: Text(
        titulo,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      leading: Icon(
        icono,
        color: Colors.grey,
      ),
      onTap: () {
        if (paginaActual.compareTo(nombrePagina) != 0) {
          Navigator.of(context).pushReplacementNamed(ruta);
        }
      },
    );
  }
}
