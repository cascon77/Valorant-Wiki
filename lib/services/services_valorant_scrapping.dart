import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class ServicesValorantScrapping {
  static const String URL = "https://www.playvalorant.com";

  Future<List<Map<String, dynamic>>> getActualizaciones() async {
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse(
            '${ServicesValorantScrapping.URL}/es-es/news/tags/patch-notes/'),
      );

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        final List<Map<String, dynamic>> nuevasTarjetas = [];

        final sectionNews = document.querySelector('section#news');
        if (sectionNews == null) {
          return nuevasTarjetas;
        }

        final botonCard = sectionNews.querySelectorAll(
          'a[data-testid="articlefeaturedcard-component"]',
        );

        for (final cardElement in botonCard) {
          final href = cardElement.attributes['href'];
          if (href == null) continue;

          final link = "${ServicesValorantScrapping.URL}$href";
          print("Link: $link");

          // card principal
          final card = cardElement.querySelector('[data-testid="card"]');
          if (card == null) continue;

          // body
          final cardBody = card.querySelector('[data-testid="card-body"]');
          if (cardBody == null) continue;

          // categoría
          final categoria = cardBody
              .querySelector('[data-testid="card-category"]')
              ?.text
              .trim();

          // fecha
          final fechaTimeElement =
          cardBody.querySelector('[data-testid="card-date"] time');

          final fecha = fechaTimeElement?.attributes['datetime'] != null
              ? DateTime.tryParse(fechaTimeElement!.attributes['datetime']!)
              : null;

          // título
          final titulo = cardBody
              .querySelector('[data-testid="card-title"]')
              ?.text
              .trim();

          // descripción
          final descripcion = cardBody
              .querySelector('[data-testid="card-description"]')
              ?.text
              .trim();

          nuevasTarjetas.add({
            'link': link,
            'categoria': categoria,
            'fecha': fecha,
            'titulo': titulo,
            'descripcion': descripcion,
          });
        }
        return nuevasTarjetas;
      } else {
//       print("Eror HTTP: ${response.statusCode}");
        return [];
      }
    } catch (e) {
//      print("Error al realizar la solicitud HTTP: $e");
      return [];
    } finally {
      client.close();
    }
  }

  Future<String> extractImage(String link) async {
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(link));

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final richTextHtml =
        document.getElementsByClassName("sc-4225abdc-0 lnNUuw");

        for (final element in richTextHtml) {
          final tagImg = element.getElementsByTagName("img");
          if (tagImg.isNotEmpty) {
            return tagImg.first.attributes["src"] ?? "";
          }
        }
      }
      return "";
    } catch (e) {
//      print("Error al extraer la imagen: $e");
      return "";
    } finally {
      client.close();
    }
  }
}
