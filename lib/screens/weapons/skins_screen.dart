import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';
import 'package:wiki_valorant/providers/provider_armas.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({super.key});

  @override
  State<SkinsScreen> createState() => _SkinsScreenState();
}

class _SkinsScreenState extends State<SkinsScreen> {
  late List<Skin> allSkins;
  late List<Skin> filteredSkins;

  @override
  void initState() {
    super.initState();
    allSkins = [];
    filteredSkins = [];
  }

  @override
  Widget build(BuildContext context) {
    // Obtención de datos pasados por la ruta.
    if (allSkins.isEmpty) {
      allSkins = (ModalRoute.of(context)!.settings.arguments as List<Skin>)
          .where((skin) => skin.contentTierUuid != null)
          .toList();
      filteredSkins = List.from(allSkins);
    }

    final provider = Provider.of<ProviderArmas>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.grey[900],
      appBar: MiAppbar(
        title: 'Skins',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SkinSearchDelegate(allSkins),
              ).then((result) {
                if (result != null) {
                  setState(() {
                    filteredSkins =
                        result.isNotEmpty ? result : List.from(allSkins);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: provider.obtenerContentTiers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay datos disponibles',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else {
            var tier = snapshot.data!;
            return Container(
              color: Colors.grey[900],
              child: ListView.separated(
                itemCount: filteredSkins.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.redAccent.withOpacity(0.4),
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                itemBuilder: (context, index) {
                  final skin = filteredSkins[index];
                  final categoria = tier
                      .singleWhere(
                          (element) => element.uuid == skin.contentTierUuid!)
                      .displayIcon;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RoutesValorant.detailsSkin,
                        arguments: skin,
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: skin.chromas![0].fullRender!,
                              width: 150,
                              height: 60,
                              fit: BoxFit.contain,
                              errorWidget: (_, __, ___) =>
                                  const Icon(Icons.error, color: Colors.redAccent),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  skin.displayName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: categoria,
                            width: 40,
                            height: 40,
                            placeholder: (_, __) => const CircularProgressIndicator(),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class SkinSearchDelegate extends SearchDelegate<List<Skin>> {
  final List<Skin> skins;

  SkinSearchDelegate(this.skins);

  @override
  String? get searchFieldLabel => 'Buscar skins...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.grey[900],
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filtered = skins.where((skin) {
      return skin.displayName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildList(filtered);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = skins.where((skin) {
      return skin.displayName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildList(suggestions);
  }

  Widget _buildList(List<Skin> items) {
    return Container(
      color: Colors.grey[900],
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final skin = items[index];
          return ListTile(
            title: Text(
              skin.displayName,
              style: const TextStyle(color: Colors.white),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: skin.chromas![0].fullRender!,
                width: 60,
                height: 40,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.error, color: Colors.redAccent),
              ),
            ),
            onTap: () {
              close(context, items);
            },
          );
        },
      ),
    );
  }
}
