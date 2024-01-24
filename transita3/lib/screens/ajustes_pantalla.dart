import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/cambiarcontrasenya_pantalla.dart';
import 'package:transita3/screens/cambiarIdiomaPantalla.dart';

class AjustesPantalla extends StatefulWidget {
  @override
  _AjustesPantallaState createState() => _AjustesPantallaState();
}

class _AjustesPantallaState extends State<AjustesPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
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
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text(S.of(context).changelen),
              leading: Icon(Icons.language),
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CambiarIdiomaPantalla(),
                  ),
                );
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
