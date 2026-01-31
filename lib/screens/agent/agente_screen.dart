import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_agentes.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class AgenteScreen extends StatefulWidget {
  const AgenteScreen({super.key});

  @override
  _AgenteScreenState createState() => _AgenteScreenState();
}

class _AgenteScreenState extends State<AgenteScreen> {
  final pagina = "agents";
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.3);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAgentes>(context, listen: false);
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
        title: "Agentes",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed("ruleta",
                      arguments: await provider.obtenerAgentes());
                },
                icon: Icon(
                  FontAwesome5.dice,
                  size: 20,
                )),
          ),
        ],
      ),
      drawer: MiMenuLateral(pagina: pagina),
      body: FutureBuilder<List<ModelAgent>>(
        future: provider.obtenerAgentes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los agentes'));
          }

          final agents = snapshot.data ?? [];

          return Stack(
            children: [
              // Fondo dinámico
              ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, _) {
                  return _fondoDinamico(agents[selectedIndex]);
                },
              ),
              // Contenido principal
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Retrato principal
                  Expanded(
                    flex: 11,
                    child: ValueListenableBuilder<int>(
                      valueListenable: _selectedIndex,
                      builder: (context, selectedIndex, _) {
                        final agent = agents[selectedIndex];
                        return agent.fullPortrait != null
                            ? CachedNetworkImage(
                                imageUrl: agent.fullPortrait!,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) =>
                                    const Icon(Icons.error),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  // Avatares inferiores
                  Expanded(
                    flex: 3,
                    child: _avatares(agents),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
    );
  }

  // Widget para el fondo dinámico
  Widget _fondoDinamico(ModelAgent agent) {
    final gradientColors = agent.backgroundGradientColors != null
        ? agent.backgroundGradientColors!
            .map(
              (color) => Color(
                  int.parse(color.substring(0, color.length - 2), radix: 16) |
                      0xFF000000),
            )
            .toList()
        : [Colors.black, Colors.grey];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: agent.background != null
          ? CachedNetworkImage(
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              imageUrl: agent.background!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            )
          : null,
    );
  }

  // Widget para los avatares con PageView
  Widget _avatares(List<ModelAgent> agents) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          _selectedIndex.value = index; // Actualiza solo el índice seleccionado
        },
        itemCount: agents.length,
        itemBuilder: (context, index) {
          final agent = agents[index];
          return ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, selectedIndex, _) {
              final isSelected = index == selectedIndex;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          RoutesValorant.detailsAgentes,
                          arguments: agent);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: isSelected
                          ? 70
                          : 55, // Ajusta la altura según el seleccionado
                      width: isSelected
                          ? 70
                          : 55, // Ajusta el ancho según el seleccionado
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                        image: agent.displayIconSmall != null
                            ? DecorationImage(
                                image: NetworkImage(agent.displayIconSmall!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  BorderedText(
                    strokeColor: Colors.black,
                    child: Text(
                      agent.displayName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
