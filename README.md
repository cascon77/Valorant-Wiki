# Valorant Wiki

Una aplicación tipo wiki para Valorant, desarrollada principalmente para Android, que consolida información de múltiples fuentes: mediante llamadas a una API y web scraping de notas de parches oficiales, con el fin de mantener un historial de cambios, así como datos sobre agentes, mapas, armas y otros elementos del juego.

## Contenidos
- [Descripción](#descripción)
- [Características](#características)
- [Stack tecnológico](#stack-tecnológico)
- [Arquitectura (resumen)](#arquitectura-resumen)
- [Instalación rápida](#instalación-rápida)
- [Consideraciones de scraping y cumplimiento legal](#consideraciones-de-scraping-y-cumplimiento-legal)
- [Contribuir](#contribuir)
- [Aviso legal](#Aviso-legal)
## Descripción

Este proyecto sirve como referencia y cliente multiplataforma (principalmente Flutter) para explorar datos de Valorant. Integra:

- Consumo de una API (pública) para obtener datos estructurados.
- Webscraping de las notas de parches oficiales para capturar cambios de balance, versiones, y texto histórico.

El objetivo es ofrecer una fuente unificada, navegable y versionada de información relevante para jugadores, creadores de contenido y análisis históricos.

## Características

- Agregación de datos desde API(s) y scraping de notas de parche.
- Historial de parches.
- Cache local y/o en servidor para reducir llamadas externas.
- Cliente móvil en Flutter (Dart) con rutas y pantallas ya estructuradas.
- Módulos backend para ETL y tareas programadas (scraper).

## Stack tecnológico

- Frontend: Flutter / Dart
- Backend ETL / Scraper
- Build: Gradle (Android), Flutter tooling (pub)

## Arquitectura (resumen)

1. Scraper: extrae notas de parche.
2. Normalizador/ETL: fusiona datos de la API y del scraping, aplica transformaciones y persistencia.
3. API interna / caché: sirve los datos a la app Flutter.
4. Cliente Flutter: consume la API y muestra la wiki con navegación por agentes, armas, mapas y parches.

## Instalación rápida

A continuación se muestra una guía rápida para desarrollar y ejecutar las piezas principales. Ajusta según los módulos que uses en tu repositorio.

1. Clonar el repositorio:

```bash  
git clone <URL_DEL_REPOSITORIO>cd valorant_wiki
```  

2. Frontend (Flutter):

```bash  
# Obtener dependencias  
flutter pub get  
# Ejecutar en dispositivo o emulador  
flutter run  
```  

Nota: adapta las rutas y comandos según la estructura del repositorio y los módulos que vayas a usar.

## Consideraciones de scraping y cumplimiento legal

El scraping de páginas públicas está sujeto a condiciones legales y técnicas. Antes de usar el scraper, ten en cuenta:

- Revisa y respeta el archivo `robots.txt` del sitio objetivo.
- Consulta los Términos de Servicio del propietario del contenido.
- Evita descargar de forma masiva recursos pesados (imágenes, vídeos) salvo que sea necesario.

Si la fuente explícitamente prohíbe scraping o redistribución, no realices esas acciones. Cuando sea posible, prefiere el uso de APIs oficiales.

## Contribuir

Gracias por querer contribuir. Sugerencias:

1. Abre un issue describiendo el cambio o bug.
2. Crea una rama con un nombre claro (`feature/`, `fix/`, `chore/`).
3. Añade pruebas que cubran la funcionalidad cuando sea posible.
4. Sigue el estilo y linters definidos en el repo.
5. Envía un pull request con una descripción clara y el contexto necesario.

Si existe un `CONTRIBUTING.md`, síguelo como fuente principal.

## Aviso legal

Este proyecto es independiente y no está afiliado ni patrocinado por Riot Games. Respeta siempre los Términos de Servicio de las fuentes que consultes. No uses el proyecto para fines que violen leyes o acuerdos.  