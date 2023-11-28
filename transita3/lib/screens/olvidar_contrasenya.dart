import 'package:flutter/material.dart';

class OlvidarContrasenya extends StatelessWidget {
  final TextEditingController _nuevaContrasenaController = TextEditingController();
  final TextEditingController _confirmarContrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar Contraseña"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/transitaLogoBN.png',
              height: 100.0,
              width: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              "Ingresa tu nueva contraseña:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nuevaContrasenaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _confirmarContrasenaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _enviarNuevaContrasena(context);
              },
              child: Text("Enviar Nueva Contraseña"),
            ),
          ],
        ),
      ),
    );
  }

  void _enviarNuevaContrasena(BuildContext context) {
    String nuevaContrasena = _nuevaContrasenaController.text;
    String confirmarContrasena = _confirmarContrasenaController.text;

    if (nuevaContrasena.isEmpty || confirmarContrasena.isEmpty) {
      _mostrarError(context, "Por favor, completa ambos campos.");
      return;
    }

    if (nuevaContrasena != confirmarContrasena) {
      _mostrarError(context, "Las contraseñas no coinciden.");
      return;
    }

    // Lógica para enviar la nueva contraseña aquí
    // Puedes utilizar el valor de nuevaContrasena

    // Por ahora, simplemente mostraremos un mensaje
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Contraseña Actualizada"),
          content: Text("Tu contraseña ha sido actualizada con éxito."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Puedes agregar lógica adicional aquí, por ejemplo, navegar a la pantalla de inicio de sesión.
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void _mostrarError(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
