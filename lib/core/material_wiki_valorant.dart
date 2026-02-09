import 'package:flutter/material.dart';
import 'package:wiki_valorant/routes/routes_valorant.dart';

class MaterialWikiValorant extends StatelessWidget {
  const MaterialWikiValorant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RoutesValorant.getRoutes(),
      initialRoute: RoutesValorant.home,
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              elevation: 0)),
    );
  }
}
