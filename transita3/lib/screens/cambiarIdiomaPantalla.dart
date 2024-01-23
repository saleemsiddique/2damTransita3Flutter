import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';

class CambiarIdiomaPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambiar Idioma"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildLanguageOption(context, 'ES', 'Español', 'assets/BanderaEspanyaV2.png'), // Puedes agregar la bandera correspondiente
          _buildLanguageOption(context, 'EN', 'English', 'assets/BanderaInglesaV2.png'),
          _buildLanguageOption(context, 'VAL', 'Valencià', 'assets/BanderaValenciaV2.png'), // Otra bandera
        ],
      ),
    );
  }

 
  Widget _buildLanguageOption(BuildContext context, String languageCode, String languageName, String flagImage) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(
            flagImage,
            width: 35,
            height: 35,
          ),
          SizedBox(width: 10.0),
          Text(languageName),
        ],
      ),
      onTap: () {
        _cambiarIdioma(context, languageCode);
        Navigator.pop(context);
      },
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

    S.load(idiomaLoad).then((_) {
      // Puedes realizar acciones adicionales si es necesario
    });
  }
}