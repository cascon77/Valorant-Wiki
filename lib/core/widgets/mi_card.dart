import 'package:flutter/material.dart';
import 'package:wiki_valorant/core/widgets/imagen_popup.dart';

class MiCard extends StatelessWidget {
  final String imagenIcon;
  final String imagenDisplay;
  final String nombre;

  const MiCard({
    super.key,
    required this.imagenIcon,
    required this.imagenDisplay,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.black.withOpacity(0.8),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.7),
              builder: (context) => ImagenPopup(imagen: imagenDisplay),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Imagen redonda con borde
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.redAccent, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      imagenIcon,
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
