import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiki_valorant/providers/provider_actualizaciones.dart';

class ListaActualizaciones extends StatefulWidget {
  const ListaActualizaciones({super.key});

  @override
  State<ListaActualizaciones> createState() => _ListaActualizacionesState();
}

class _ListaActualizacionesState extends State<ListaActualizaciones> {
  bool _tiempoAgotado = false;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() {
    final provider = Provider.of<ProviderActualizaciones>(context, listen: false);

    if (provider.actualizaciones.isEmpty) {
      provider.obtenerActualizaciones();

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && provider.actualizaciones.isEmpty) {
          setState(() {
            _tiempoAgotado = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderActualizaciones>(
      builder: (context, provider, _) {
        if (_tiempoAgotado && provider.actualizaciones.isEmpty) {
          return _buildNoDataWidget();
        }

        if (provider.actualizaciones.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: provider.actualizaciones.length,
          itemBuilder: (context, index) {
            final item = provider.actualizaciones[index];
            return tarjetaActualizacion(
              urlDestino: item['link'],
              fechaformateada: item['fecha'],
              categoria: item['categoria'],
              titulo: item['titulo'],
              descripcion: item['descripcion'],
              provider: provider,
            );
          },
        );
      },
    );
  }

  Widget _buildNoDataWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.asset(
          "assets/images/valorant-logo.jpg",
          fit: BoxFit.cover,
        ),

        // Capa de oscurecimiento para mejorar la legibilidad
        Container(
          color: Colors.black.withOpacity(0.6),
        ),

        // Contenido centrado
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No se encontraron actualizaciones",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildRetryButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRetryButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tiempoAgotado = false;
        });
        _cargarDatos();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.refresh, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Reintentar",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fecha(DateTime fechaformateada) {
    final DateFormat formatter = DateFormat('d/M/yyyy');
    return formatter.format(fechaformateada);
  }

  Widget tarjetaActualizacion({
    required String urlDestino,
    required DateTime fechaformateada,
    required String categoria,
    required String titulo,
    required String descripcion,
    required ProviderActualizaciones provider,
  }) {
    final esNuevaActualizacion = fechaformateada.isAfter(
      DateTime.now().subtract(
        const Duration(days: 15),
      ),
    );



    return InkWell(
      onTap: () async {
        final uri = Uri.parse(urlDestino);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          border: Border.all(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.7),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (esNuevaActualizacion)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Nueva Actualización",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 10),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: FutureBuilder<String>(
                      future: provider.obtenerImagen(urlDestino),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Image.asset(
                            "assets/images/loading.gif",
                            fit: BoxFit.contain,
                          );
                        }
                        if (snapshot.hasError || snapshot.data!.isEmpty) {
                          return Image.asset(
                            "assets/images/actualizacion1.png",
                            fit: BoxFit.contain,
                          );
                        }
                        return FadeInImage(
                          image: NetworkImage(snapshot.data!),
                          placeholder:
                              const AssetImage("assets/images/loading.gif"),
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor: Colors.redAccent.withOpacity(0.2),
                    label: Text(
                      categoria.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _fecha(fechaformateada),
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                descripcion,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.link,
                      size: 20,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Leer más",
                      style: TextStyle(
                        color: Colors.redAccent.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
