import 'package:flutter/material.dart';

class GestionIncidenciasPage extends StatefulWidget {
  @override
  _GestionIncidencias createState() => _GestionIncidencias();
}

class _GestionIncidencias extends State<GestionIncidenciasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _botonAgregar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 40),
        children: <Widget>[
          _logo(),
          Container(height: 7),
        ],
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/transitaPng.png', height: 70, width: 70),
          SizedBox(width: 25),
          Text(
            'Transita',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _botonAgregar() {
    return FloatingActionButton(
        backgroundColor: Color.fromRGBO(14, 100, 209, 1),
        foregroundColor: Color.fromRGBO(41, 39, 39, 0.68),
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 50,
        ),
        onPressed: () {});
  }

  /*List<Widget> _listaIncidencias(List<dynamic> data, BuildContext context) {
    final List<Widget> incidencias = [];
    data.forEach((incidencia) {
      final widgetTemp = ListTile(title: Text(incidencia['titulo']));
    });
  }*/
}
