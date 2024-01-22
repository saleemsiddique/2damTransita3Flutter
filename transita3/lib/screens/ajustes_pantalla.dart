import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/cambiarcontrasenya_pantalla.dart';

class AjustesPantalla extends StatefulWidget {
  @override
  _AjustesPantallaState createState() => _AjustesPantallaState();
}

class _AjustesPantallaState extends State<AjustesPantalla> {
  late String _selectedLanguage = 'ES';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    _cambiarIdioma(context, newValue!);
                  },
                  items: ['EN', 'ES', 'VAL'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(S.of(context).configurations),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text(S.of(context).changepass),
              leading: Icon(Icons.lock),
              onTap: () {
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

  void _cambiarIdioma(BuildContext context, String idioma) {
    Locale idiomaLoad;
    if (idioma == 'ES') {
      idiomaLoad = Locale('es', 'ES');
    } else if (idioma == 'EN') {
      idiomaLoad = Locale('en', 'US');
    } else {
      idiomaLoad = Locale('val', 'VAL');
    }

    // Aquí deberías implementar la lógica para cambiar el idioma en tu aplicación

    S.load(idiomaLoad).then((_) {
    setState(() {
      _selectedLanguage = idioma;
    });
  });
  }
}
