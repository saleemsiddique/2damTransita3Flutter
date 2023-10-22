import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para crear la cuenta y luego redirigir a la página de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
