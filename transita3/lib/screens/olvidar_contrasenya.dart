import 'package:flutter/material.dart';

class OlvidarContrasenya extends StatelessWidget {
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
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              "Correo enviado",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "Hemos enviado un correo con tu nueva contraseña.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
