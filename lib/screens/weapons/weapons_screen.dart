import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_armas.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class WeaponScreen extends StatefulWidget {
  const WeaponScreen({super.key});

  @override
  _WeaponScreenState createState() => _WeaponScreenState();
}

class _WeaponScreenState extends State<WeaponScreen> {
  int selectedIndex = 0;
  final pagina = "weapons";
  List<ModelWeapons>? weapons;

  @override
  void initState() {
    super.initState();
    _loadWeapons();
  }

  Future<void> _loadWeapons() async {
    final provider = Provider.of<ProviderArmas>(context, listen: false);
    try {
      final armas = await provider.obtenerArmas();
      setState(() {
        weapons = armas;
      });
    } catch (e) {
      setState(() {
        weapons = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weapons == null) {
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
          title: "Armas",
        ),
        drawer: MiMenuLateral(pagina: pagina),
        body: const Center(child: CircularProgressIndicator()),
      ),
      );
    }

    if (weapons!.isEmpty) {
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
          title: "Armas",
        ),
        drawer: MiMenuLateral(pagina: pagina),
        body: _widgetNoHayWeapons(),
      )
      );
    }

    return PopScope(
      canPop: false, // Bloquea el cierre directo de la app
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pushReplacementNamed(RoutesValorant.home);
        }
      },
      child: Scaffold(
      appBar: MiAppbar(
        title: "Armas",
      ),
      backgroundColor: Colors.grey[900],
      drawer: MiMenuLateral(pagina: pagina),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                key: ValueKey<int>(selectedIndex),
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.8),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[850],
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.network(
                      weapons![selectedIndex].displayIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botonSkin(weapons![selectedIndex]),
                _botonInfo(weapons![selectedIndex]),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: weapons!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Colors.redAccent.withOpacity(0.2)
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.redAccent
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              weapons![index].displayIcon,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            weapons![index].displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _botonSkin(ModelWeapons weapon) => ElevatedButton(
        style: _estiloboton(Colors.redAccent),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(RoutesValorant.listaSkins, arguments: weapon.skins);
        },
        child: const Text(
          "Skins",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );

  Widget _botonInfo(ModelWeapons weapon) {
    if (weapon.displayName.compareTo("Cuerpo a cuerpo") == 0) {
      return const SizedBox.shrink();
    }
    return ElevatedButton(
      style: _estiloboton(Colors.redAccent),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(RoutesValorant.detailsArmas, arguments: weapon);
      },
      child: const Text(
        "Info",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  ButtonStyle _estiloboton(Color color) => ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  Widget _widgetNoHayWeapons() {
    return const Center(
      child: Text(
        'No hay armas disponibles',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
