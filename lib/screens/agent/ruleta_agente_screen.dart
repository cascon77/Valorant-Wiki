import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class RuletaAgenteScreen extends StatelessWidget {
  const RuletaAgenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ModelAgent> agents =
        ModalRoute.of(context)!.settings.arguments as List<ModelAgent>;
    return Scaffold(
      appBar: MiAppbar(title: "Agente Aleatorio",
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Pulsa la ruleta para que gire y seleccione un personaje aleatorio")));
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: RuletaAgentes(list: agents),
            ),
          ],
        ),
      ),
    );
  }
}

class RuletaAgentes extends StatefulWidget {
  final List<ModelAgent> list;
  const RuletaAgentes({super.key, required this.list});

  @override
  State<RuletaAgentes> createState() => _RuletaAgentesState();
}

class _RuletaAgentesState extends State<RuletaAgentes> {
  StreamController<int> controller = StreamController<int>();
  bool estaGirando = false;
  ModelAgent? agenteSeleccionado; // Variable para almacenar el personaje seleccionado

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: estaGirando
          ? null
          : () {
              setState(() {
                final randomIndex = Fortune.randomInt(0, widget.list.length);
                controller.add(randomIndex);
                agenteSeleccionado = widget.list[randomIndex];
                estaGirando = true;
              });
            },
      child: FortuneBar(
        duration: Duration(seconds: 3),
        rotationCount: 14,
        height: double.infinity,
        animateFirst: false,
        styleStrategy: UniformStyleStrategy(
          color: Colors.black.withAlpha(70),
          borderColor: Colors.black,
        ),
        selected: controller.stream,
        items: [
          for (var agente in widget.list)
            FortuneItem(
              child: Image.network(agente.displayIcon!),
            ),
        ],
        onAnimationEnd: () {
          // Mostrar el diálogo con el personaje seleccionado
          if (agenteSeleccionado != null) {
            showDialog(
              context: context,
              builder: (context) => GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Dialog(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Colors.redAccent, 
                      width: 2,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3), // Sombra hacia abajo
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (agenteSeleccionado!.fullPortrait != null)
                          FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image: agenteSeleccionado!.fullPortrait!,
                            fit: BoxFit.cover,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            agenteSeleccionado!.displayName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          setState(() {
            estaGirando = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
