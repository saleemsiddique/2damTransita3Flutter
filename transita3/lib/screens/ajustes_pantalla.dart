import 'package:flutter/material.dart';
import 'package:transita3/screens/cambiarcontrasenya_pantalla.dart';

class AjustesPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Configuraciones'),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color:   Colors.grey.withOpacity(0.5), // Color de fondo gris
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text('Cambiar Contraseña'),
              leading: Icon(Icons.lock), // Icono de candado
              onTap: () {
                // Navega a la pantalla de cambio de contraseña
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CambiarContrasenaPantalla(),
                  ),
                );
              },
            ),
          ),
          // Puedes agregar más opciones de ajustes aquí
        ],
      ),
    );
  }
}
