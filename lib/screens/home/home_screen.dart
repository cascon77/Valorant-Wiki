import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final pagina = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MiAppbar(title: "Wiki Valorant"),
      drawer: MiMenuLateral(pagina: pagina),
      body: ListaActualizaciones(),
    );
  }
}
