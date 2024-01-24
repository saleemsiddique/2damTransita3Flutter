import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';

class CambiarIdiomaPantalla extends StatefulWidget {
  @override
  _CambiarIdiomaPantallaState createState() => _CambiarIdiomaPantallaState();
}

class _CambiarIdiomaPantallaState extends State<CambiarIdiomaPantalla> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedLanguage with the default language code.
    _selectedLanguage = 'ES';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).changelen),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildLanguageOption(
              context, 'ES', 'Español', 'assets/BanderaEspanyaV2.png'),
          _buildLanguageOption(
              context, 'EN', 'English', 'assets/BanderaInglesaV2.png'),
          _buildLanguageOption(
              context, 'VAL', 'Valencià', 'assets/BanderaValenciaV2.png'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String languageCode,
      String languageName, String flagImage) {
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

    // Utiliza Localizations para obtener una nueva instancia de S para el nuevo idioma
    S.load(idiomaLoad);
    setState(() {
      _selectedLanguage = idioma;
    });
  }
}
