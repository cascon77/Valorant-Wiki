import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/providers/provider_tarjetas_jugador.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class PlayerCardsScreen extends StatefulWidget {
  const PlayerCardsScreen({super.key});

  @override
  State<PlayerCardsScreen> createState() => _PlayerCardsScreenState();
}

class _PlayerCardsScreenState extends State<PlayerCardsScreen> {
  final pagina = "playercards";
  List<ModelPlayerCards> allPlayercards = [];
  List<ModelPlayerCards> filteredPlayercards = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProviderTarjetasJugador>(context, listen: false);

    return PopScope(
      canPop: false, // Bloquea el cierre directo de la app
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pushReplacementNamed(RoutesValorant.home);
        }
      },
      child: Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Tarjetas de Jugadores',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/banner.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                  filteredPlayercards = allPlayercards
                      .where((tarjeta) => tarjeta.displayName
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Nombre de tarjeta de jugador',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: MiMenuLateral(pagina: pagina),
      body: FutureBuilder<List<ModelPlayerCards>>(
        future: provider.obtenerTarjetas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          } else {
            if (allPlayercards.isEmpty) {
              allPlayercards = snapshot.data!;
              filteredPlayercards = allPlayercards;
            }

            return ListView.builder(
              itemCount: filteredPlayercards.length,
              itemBuilder: (context, index) {
                var playercard = filteredPlayercards[index];

                return MiCard(
                    imagenIcon: playercard.displayIcon,
                    imagenDisplay: playercard?.largeArt ?? playercard.wideArt,
                    nombre: playercard.displayName);
              },
            );
          }
        },
      ),
      ),
    );
  }
}
