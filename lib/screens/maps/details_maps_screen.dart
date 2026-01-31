import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailsMapsScreen extends StatefulWidget {
  const DetailsMapsScreen({super.key});

  @override
  _DetailsMapsScreenState createState() => _DetailsMapsScreenState();
}

class _DetailsMapsScreenState extends State<DetailsMapsScreen> {
  // Variable para gestionar la vista activa
  bool showMinimap = false;

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as ModelMaps;

    return Scaffold(
      appBar: MiAppbar(
        title: map.displayName,
      ),
      body: Stack(
        children: [
          // Fondo con la imagen splash usando CachedNetworkImage
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: map.splash,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.red),
            ),
          ),
          // Contenido principal
          if (showMinimap)
            Center(
              child: Image.network(
                map.displayIcon!, // Mostrar el minimapa
                fit: BoxFit.contain,
              ),
            ),
          if (!showMinimap)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del mapa y descripción
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map.displayName,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lugares',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Lista de Callouts
                Expanded(
                  child: ListView.builder(
                    itemCount: map.callouts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final callout = map.callouts![index];
                      return ListTile(
                        title: Text(
                          callout.regionName,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          callout.superRegionName,
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Icon(Icons.location_on, color: Colors.red),
                        onTap: () {
                          _calloutDetails(context, callout);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white30,
        currentIndex:
            showMinimap ? 1 : 0, // Cambiar el índice según la vista activa
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Lugares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Minimapa',
          ),
        ],
        onTap: (index) {
          // Cambiar entre la vista del minimapa y la vista de detalles
          setState(() {
            showMinimap =
                index == 1; // Si se selecciona "Minimap", se activa el minimapa
          });
        },
      ),
    );
  }

  void _calloutDetails(BuildContext context, Callout callout) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(callout.regionName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Super región: ${callout.superRegionName}'),
            const SizedBox(height: 8),
            Text('Ubicación: (${callout.location.x}, ${callout.location.y})'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
