import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_mapas.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class MapsScreen extends StatelessWidget {
  final pagina = "maps";
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderMapas>(context, listen: false);
    return PopScope(
      canPop: false, // Bloquea el cierre directo de la app
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pushReplacementNamed(RoutesValorant.home);
        }
      },
      child: Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MiAppbar(
        title: 'Mapas',
      ),
      body: FutureBuilder(
        future: provider.obtenerMapas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error al cargar los mapas",
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }

          // Eliminar mapas de entrenamiento
          var mapas = snapshot.data!
              .where((mapa) => mapa.stylizedBackgroundImage != null)
              .toList();

          return ListView.builder(
            itemCount: mapas.length,
            itemBuilder: (context, index) {
              final mapa = mapas[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Colors.black.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    mapa.displayName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  subtitle: Text(
                    mapa.tacticalDescription ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 100,
                      child: CachedNetworkImage(
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        ),
                        imageUrl: mapa.splash,
                        errorWidget: (_, __, ___) => Icon(
                          Icons.error,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RoutesValorant.detailsMapa,
                      arguments: mapa,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      drawer: MiMenuLateral(pagina: pagina),
      ),
    );
  }
}
