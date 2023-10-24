import 'package:flutter/material.dart';
import 'package:transita3/incidencias.dart';
import 'package:transita3/screens/inicio_sesion.dart';

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
        children: <Widget>[_logo(), Container(height: 80), _lista()],
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

  List<Widget> _listaIncidencias(List<dynamic> data, BuildContext context) {
    final List<Widget> incidencias = [];
    int _cont = 1;
    data.forEach((incidencia) {
      final widgetTemp = GestureDetector(
          child: Container(
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _columnaIzquierda(incidencia['titulo'], incidencia['imagen'],
                    incidencia['direccion'], _cont),
                Container(width: 25),
                _columnaDerecha()
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IniciarSesionPage()),
            );
          });
      incidencias
        ..add(Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(66, 64, 64, 1),
              ),
              child: widgetTemp,
            ),
          ),
        ))
        ..add(Container(height: 40));
      _cont++;
    });
    return incidencias;
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuIncidencias.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return Column(
          children: _listaIncidencias(snapshot.data!, context),
        );
      },
    );
  }

  Widget _columnaIzquierda(
      String nombre, String imagen, String direccion, int id) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imagen),
          radius: 30,
        ),
        Container(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('id: $id'),
            Container(height: 2),
            Text(nombre),
            Container(height: 5),
            Text(
              direccion,
              style: TextStyle(fontSize: 10),
            )
          ],
        )
      ],
    );
  }

  Widget _columnaDerecha() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(width: 25),
            _botonInspeccionar(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('24-10-2023', style: TextStyle(fontSize: 10)),
            Text('18:10', style: TextStyle(fontSize: 10))
          ],
        )
      ],
    );
  }

  Widget _botonInspeccionar() {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'editar',
          child: Text('Editar'),
        ),
        PopupMenuItem<String>(
          value: 'eliminar',
          child: Text('Eliminar'),
        ),
      ],
      onSelected: (String choice) {
        if (choice == 'editar') {
        } else if (choice == 'eliminar') {}
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
