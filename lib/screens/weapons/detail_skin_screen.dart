import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailSkinScreen extends StatefulWidget {
  const DetailSkinScreen({super.key});

  @override
  _DetailSkinScreenState createState() => _DetailSkinScreenState();
}

class _DetailSkinScreenState extends State<DetailSkinScreen> {
  late Skin skin;
  int currentChromaIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener el objeto Skin de los argumentos
    skin = ModalRoute.of(context)!.settings.arguments as Skin;
  }

  void _nextChroma() {
    setState(() {
      if (currentChromaIndex < skin.chromas!.length - 1) {
        currentChromaIndex++;
      }
    });
  }

  void _previousChroma() {
    setState(() {
      if (currentChromaIndex > 0) {
        currentChromaIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chromas = skin.chromas;
    if (chromas == null || chromas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(skin.displayName),
        ),
        body: const Center(
          child: Text('No hay variantes disponibles para esta skin.'),
        ),
      );
    }

    final currentChroma = chromas[currentChromaIndex];

    return Scaffold(
      appBar: MiAppbar(
        title: skin.displayName,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (currentChroma.fullRender != null)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Image.network(
                              currentChroma.fullRender!,
                              key: ValueKey(currentChroma.fullRender),
                              fit: BoxFit.contain,
                            ),
                          )
                        else
                          const Text(
                            "Imagen no disponible",
                            style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, size: 40, color: Colors.redAccent),
                  onPressed: currentChromaIndex > 0 ? _previousChroma : null,
                ),
                Text(
                  'Variante ${currentChromaIndex + 1}/${chromas.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 40, color: Colors.redAccent),
                  onPressed: currentChromaIndex < chromas.length - 1 ? _nextChroma : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 75,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  currentChroma.displayName ?? 'Variante desconocida',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
