import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_modos_de_juego.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class GameModesScreen extends StatelessWidget {
  const GameModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderModosDeJuego>(context, listen: false);

    return PopScope(
      canPop: false, // Bloquea el cierre directo de la app
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pushReplacementNamed(RoutesValorant.home);
        }
      },
      child: Scaffold(
      drawer: MiMenuLateral(pagina: "gamemodes"),
      backgroundColor: Colors.grey[900],
      appBar: MiAppbar(
        title: 'Modos de Juegos',
      ),
      body: FutureBuilder<List<ModelGameMode>>(
        future: provider
            .obtenerModos(), // Llamada al servicio que trae la lista de modos de juego
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final gameModes = snapshot.data!
                .where((gamemode) => gamemode.displayIcon != null)
                .toList();

            return ListView.builder(
              itemCount: gameModes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          RoutesValorant.detailsGameMode,
                          arguments: gameModes[index]);
                    },
                    child: Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen del modo de juego
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  border: Border.all(
                                      color: Colors.redAccent,
                                      width: 2), // Borde rojo
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.7),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Image.network(
                                    gameModes[index].displayIcon!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Nombre del modo de juego
                            Text(
                              gameModes[index].displayName,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Descripción del modo de juego
                            Text(
                              gameModes[index].description ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 20),
                            gameModes[index].duration != null
                                ?
                                // Duración
                                Row(
                                    children: [
                                      Icon(Icons.timer,
                                          color: Colors.redAccent),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Duración: ${gameModes[index].duration}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      ),
    );
  }
}
