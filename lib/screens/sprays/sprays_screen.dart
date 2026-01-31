import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/providers/provider_spray.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class SpraysScreen extends StatefulWidget {
  const SpraysScreen({super.key});

  @override
  State<SpraysScreen> createState() => _SpraysScreenState();
}

class _SpraysScreenState extends State<SpraysScreen> {
  final pagina = "sprays";
  List<ModelSprays> allSprays = [];
  List<ModelSprays> filteredSprays = [];
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSpray>(context, listen: false);
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
          'Grafitis',
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
                  filteredSprays = allSprays
                      .where((sprays) => sprays.displayName
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Escribe el nombre del amuleto',
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
      body: FutureBuilder<List<ModelSprays>>(
        future: provider.obtenerSprays(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          } else {
            if (allSprays.isEmpty) {
              allSprays = snapshot.data!;
              filteredSprays = allSprays;
            }

            return ListView.builder(
              itemCount: filteredSprays.length,
              itemBuilder: (context, index) {
                var spray = filteredSprays[index];

                String imagenDisplay;
                if (spray.animationPng != null) {
                  imagenDisplay = spray.animationPng!;
                } else if (spray.fullTransparentIcon != null) {
                  imagenDisplay = spray.fullTransparentIcon!;
                } else {
                  imagenDisplay = spray.displayIcon;
                }

                return MiCard(
                    imagenIcon: spray.displayIcon,
                    imagenDisplay: imagenDisplay,
                    nombre: spray.displayName);
              },
            );
          }
        },
      ),
      ),
    );
  }
}
