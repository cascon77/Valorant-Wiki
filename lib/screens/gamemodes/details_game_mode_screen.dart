import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailsGameModeScreen extends StatelessWidget {
  const DetailsGameModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameMode =
        ModalRoute.of(context)!.settings.arguments as ModelGameMode;

    return Scaffold(
      appBar: MiAppbar(
        title: gameMode.displayName,
      ),
      backgroundColor: Color.fromARGB(255, 18, 18, 18), // Fondo oscuro
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Imagen de fondo si se tiene disponible
          Card(
            color: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                gameMode.displayIcon!,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Descripción del modo de juego
          _buildSectionTitle("Descripción"),
          Text(
            gameMode.description ?? "No disponible.",
            style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
          ),

          const SizedBox(height: 20),

          // Duración y economía
          _buildInfoRow(Icons.timer, "Duración", gameMode.duration),

          const SizedBox(height: 20),

          // Características del juego
          _buildSectionTitle("Características"),
          const SizedBox(height: 20),
          // Otros detalles como roles de equipo y rondas
          _buildInfoRow(
            Icons.people,
            "Roles de Equipo",
            gameMode.teamRoles
                    ?.map((element) => element.substring("EAresTeamRole::".length))
                    .toList()
                    .join("\n") ??
                "N/A",
          ),
          _buildInfoRow(Icons.layers, "Rondas por Mitad", gameMode.roundsPerHalf.toString()),
          _buildInfoRow(Icons.access_time, "Tiempo de Juego", gameMode.duration ?? "No disponible"),
        ],
      ),
    );
  }

  // Widget para construir una fila de información
  Widget _buildInfoRow(IconData icon, String title, String? value) {
    if (value == null || value.isEmpty || value.contains("-1")) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Color.fromARGB(255, 42, 42, 42), 
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }

  // Widget para mostrar el título de una sección
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
