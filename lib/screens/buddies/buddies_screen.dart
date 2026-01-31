import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_amuletos.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class BuddiesScreen extends StatefulWidget {
  const BuddiesScreen({super.key});

  @override
  _BuddiesScreenState createState() => _BuddiesScreenState();
}

class _BuddiesScreenState extends State<BuddiesScreen> {
  List<ModelBuddies> allBuddies = [];
  List<ModelBuddies> filteredBuddies = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAmuletos>(context, listen: false);

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
          'Amuletos',
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
                  filteredBuddies = allBuddies
                      .where((buddy) => buddy.displayName
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
      drawer: MiMenuLateral(pagina: "buddies"),
      body: FutureBuilder<List<ModelBuddies>>(
        future: provider.obtenerAmuletos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          } else {
            if (allBuddies.isEmpty) {
              allBuddies = snapshot.data!;
              filteredBuddies = allBuddies;
            }

            return ListView.builder(
              itemCount: filteredBuddies.length,
              itemBuilder: (context, index) {
                var buddie = filteredBuddies[index];

                return MiCard(
                    imagenIcon: buddie.displayIcon,
                    imagenDisplay: buddie.displayIcon,
                    nombre: buddie.displayName);
              },
            );
          }
        },
      ),
      ),
    );
  }
}
