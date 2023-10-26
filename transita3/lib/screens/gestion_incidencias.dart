import 'package:flutter/material.dart';
import 'package:transita3/incidencias.dart';
import 'package:transita3/screens/creacion_incidencias.dart';
import 'package:transita3/screens/detalle_incidencias.dart';
import 'package:transita3/screens/inicio_sesion.dart';

class GestionIncidenciasPage extends StatefulWidget {
  @override
  _GestionIncidencias createState() => _GestionIncidencias();
}

final TextStyle _estiloLetra = TextStyle(fontSize: 15);

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
          Image.asset('assets/logo2SinFondo.png', height: 70, width: 70),
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
      foregroundColor: Colors.transparent,
      shape: CircleBorder(),
      child: const Icon(
        Icons.add,
        size: 50,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreacionIncIncidenciasPage()));
      },
    );
  }

  List<Widget> _listaIncidencias(List<dynamic> data, BuildContext context) {
    final List<Widget> incidencias = [];
    int _cont = 1;
    data.forEach((incidencia) {
      final widgetTemp = GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _columnaIzquierda(incidencia['titulo'], incidencia['imagen'], incidencia['direccion'], _cont),
              _columnaDerecha(),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => detalle_incidencias()),
            );
          });
      incidencias
        ..add(Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 100,
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

  Widget _columnaIzquierda(String nombre, String imagen, String direccion, int id) {
    if (direccion.length >= 19) direccion = direccion.substring(0, 19);
    if (nombre.length >= 16) nombre = nombre.substring(0, 16);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('id: $id', style: _estiloLetra),
            Container(height: 2),
            Text(nombre, style: _estiloLetra),
            Container(height: 5),
            Text(
              direccion,
              style: _estiloLetra,
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
            SizedBox(width: 25),
            _botonInspeccionar(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Text('24-10-2023', style: _estiloLetra), Text('18:10', style: _estiloLetra)],
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
