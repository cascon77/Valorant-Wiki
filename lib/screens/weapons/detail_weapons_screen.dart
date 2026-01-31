import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailWeaponsScreen extends StatelessWidget {
  const DetailWeaponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var weapon = ModalRoute.of(context)!.settings.arguments as ModelWeapons;
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro
      appBar: MiAppbar(
        title: weapon.displayName,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del icono del arma con efecto fade
            Center(
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 200),
                image: NetworkImage(weapon.displayIcon),
                placeholder: AssetImage('assets/images/loading.gif'),
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),

            // Nombre y categoría del arma
            Text(
              weapon.displayName,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white, // Texto blanco para contraste
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Categoría: ${weapon.shopData!.categoryText}",
              style: TextStyle(fontSize: 18, color: Colors.grey[400]), // Gris claro
            ),
            SizedBox(height: 20),

            // Estadísticas del arma
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(16),
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
              child: Card(
                color: Colors.grey[850], // Fondo oscuro en las tarjetas
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estadísticas:",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.redAccent, // Rojo para resaltar
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      stats("Tasa de Disparo",
                          "${weapon.weaponStats!.fireRate} disparos/seg"),
                      stats("Tamaño del Cargador",
                          "${weapon.weaponStats!.magazineSize} balas"),
                      stats("Vel. de Corrida",
                          "${(weapon.weaponStats!.runSpeedMultiplier! * 100).toStringAsFixed(0)}%"),
                      stats("Tiempo de Equipar",
                          "${weapon.weaponStats!.equipTimeSeconds}s"),
                      stats("Tiempo de Recarga",
                          "${weapon.weaponStats!.reloadTimeSeconds}s"),
                      stats("Precisión Primer Disparo",
                          "${(weapon.weaponStats!.firstBulletAccuracy! * 100).toStringAsFixed(1)}%"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ...listaDeManiquis(weapon),
            SizedBox(height: 20),

            // Precio del arma y su imagen
            Text(
              "Precio: \$${weapon.shopData!.cost}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // Texto blanco
            ),
            SizedBox(height: 8),
            Center(
              child: FadeInImage(
                image: NetworkImage(weapon.shopData!.newImage!),
                placeholder: AssetImage('assets/images/loading.gif'),
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Función para crear una fila con las estadísticas
  Widget stats(String statName, String statValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            statName,
            style: TextStyle(color: Colors.white, fontSize: 16), // Texto blanco
          ),
          Text(
            statValue,
            style: TextStyle(color: Colors.white, fontSize: 16), // Texto blanco
          ),
        ],
      ),
    );
  }

  List<Widget> listaDeManiquis(var weapon) {
    List<Widget> lista = [];

    for (var i = 0; i < weapon.weaponStats!.damageRanges!.length; i++) {
      var rango = weapon.weaponStats!.damageRanges![i];
      lista.add(Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
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
        child: Card(
          color: Colors.grey[850],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daño desde ${rango.rangeStartMeters} a ${rango.rangeEndMeters} metros:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.redAccent, 
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                maniqui(rango.headDamage!, rango.bodyDamage!, rango.legDamage!),
              ],
            ),
          ),
        ),
      ));
      lista.add(SizedBox(height: 20));
    }

    return lista;
  }

  Widget maniqui(double textoCabeza, int textoCuerpo, double textoPiernas) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: 40,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 55,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 55,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 20,
          height: 80,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text(
                "Cabeza: $textoCabeza",
                style: TextStyle(fontSize: 16, color: Colors.white), // Blanco
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              child: Text(
                "Cuerpo: $textoCuerpo",
                style: TextStyle(fontSize: 16, color: Colors.white), // Blanco
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60,
              child: Text(
                "Piernas: $textoPiernas",
                style: TextStyle(fontSize: 16, color: Colors.white), // Blanco
              ),
            ),
          ],
        ),
      ],
    );
  }
}
