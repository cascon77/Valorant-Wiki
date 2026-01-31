import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/models/models.dart';
import 'package:wiki_valorant/core/widgets/widgets.dart';

class DetailsGearScreen extends StatelessWidget {
  const DetailsGearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dato = ModalRoute.of(context)!.settings.arguments as ModelGear;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MiAppbar(
        title: dato.displayName,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.5),
                    blurRadius: 8.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  dato.displayIcon,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      height: 200,
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.black.withOpacity(0.6),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        dato.displayName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      dato.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 16),
                    _buildSectionTitle("Precio:", Colors.redAccent),
                    Text(
                      "${dato.shopData.cost} créditos",
                      style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                    ),
                    SizedBox(height: 16),
                    _buildSectionTitle("Detalles:", Colors.redAccent),
                    SizedBox(height: 8),
                    ..._buildDetailList(dato.details),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  List<Widget> _buildDetailList(List<Detail> details) {
    return details.map((detail) {
      return Card(
        elevation: 3,
        color: Colors.black.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(Icons.info_outline, color: Colors.redAccent),
          title: Text(
            detail.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
          subtitle: Text(
            detail.value,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
      );
    }).toList();
  }
}
