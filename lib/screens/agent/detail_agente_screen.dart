import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailAgenteScreen extends StatelessWidget {
  const DetailAgenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el agente desde los argumentos de navegación
    final ModelAgent agent =
        ModalRoute.of(context)!.settings.arguments as ModelAgent;

    return Scaffold(
      appBar: MiAppbar(title: agent.displayName,),
      body: Stack(
        children: [
          _buildBackground(agent),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _personaje(agent),
                  const SizedBox(height: 16),
                  _habilidades(agent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(ModelAgent agent) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: agent.backgroundGradientColors != null
              ? agent.backgroundGradientColors!
                  .map((hex) => Color(
                      int.parse('0xFF${hex.substring(0, hex.length - 2)}')))
                  .toList()
              : [Colors.black, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _personaje(ModelAgent agent) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (agent.fullPortrait != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                agent.fullPortrait!,
                width: 120,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.displayName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                        width: 26,
                        child: Image.network(agent.role.displayIcon!)),
                    const SizedBox(width: 8),
                    Text(
                      agent.role.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(agent.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _habilidades(ModelAgent agent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Habilidades",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 8),
          ...agent.abilities.map((ability) => _buildAbilityCard(ability)),
        ],
      ),
    );
  }

  Widget _buildAbilityCard(ability) {
    return Card(
      color: Colors.black54,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (ability.displayIcon != null)
              Image.network(
                ability.displayIcon!,
                width: 50,
                height: 50,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ability.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ability.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
