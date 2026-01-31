import 'package:flutter/material.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

class AlertaSalidaAplicacion extends StatelessWidget {
  const AlertaSalidaAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("¿Estas seguro?"),
      content: Text("¿Estas seguro que quieres cerrar la Wiki Valorant?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            if (Platform.isAndroid) {
                SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          child: const Text('Si'),
        ),
      ],
    );
  }
}
