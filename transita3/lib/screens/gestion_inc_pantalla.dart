import 'package:flutter/material.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:provider/provider.dart';


import '../models/models.dart';

class GestionIncidenciasPage extends StatefulWidget {
  @override
  _GestionIncidencias createState() => _GestionIncidencias();
}

final TextStyle _estiloLetra = TextStyle(fontSize: 13);

class _GestionIncidencias extends State<GestionIncidenciasPage> {
  @override
  Widget build(BuildContext context) {
    final incidenciasService = Provider.of<IncidenciaService>(context, listen: true);
    incidenciasService.getIncidencias();
    return Scaffold(
      floatingActionButton: _botonAgregar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 40),
        children: <Widget>[_logo(), Container(height: 80), _lista(incidenciasService.incidenciasDeUsuario)],
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'creacionincidencia');
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/boton.png'),
            ),
            borderRadius: BorderRadius.circular(0.50)),
        width: 80,
        height: 80,
      ),
    );
  }

List<Widget> _listaIncidencias(List<Incidencia> data, BuildContext context) {
  final List<Widget> incidencias = [];
  int _cont = 1;
  data.forEach((incidencia) {
    final widgetTemp = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _columnaIzquierda(incidencia.descripcion, incidencia.punto.foto,
            incidencia.punto.descripcion, incidencia.id),
        _columnaDerecha(incidencia.id),
      ],
    );
    incidencias.add(
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detalleincidencia', arguments: incidencia); 
       },
        child: Container(
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
        ),
      ),
    );
    incidencias.add(Container(height: 40));
    _cont++;
  });
  return incidencias;
}



Widget _lista(List<Incidencia> listaIncidencias) {
    if (listaIncidencias.isEmpty) {
    return Column(
      children: [
        Text("No hay Incidencias"),
      ],
    );
  } else {
    print("Estas son las incidencias de la lista: ${listaIncidencias.toString()}");
    return Column(
      children: _listaIncidencias(listaIncidencias, context),
    );
  }
}




  Widget _columnaIzquierda(
      String nombre, String imagen, String direccion, int id) {
    if (direccion.length >= 19) direccion = direccion.substring(0, 19);
    if (nombre.length >= 16) nombre = nombre.substring(0, 16);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: FadeInImage(
            fit: BoxFit.cover,
            width: 60,
            height: 80,
            placeholder: AssetImage('assets/loading.gif'),
            imageErrorBuilder: (context, error, stackTrace) => Image(image: AssetImage('assets/loading.gif'), width: 60, height: 80,),
            image: NetworkImage(imagen),
            fadeInDuration: Duration(milliseconds: 200),
          ),
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

  Widget _columnaDerecha(int id) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 25),
            _botonInspeccionar(id),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('24-10-2023', style: _estiloLetra),
            Text('18:10', style: _estiloLetra)
          ],
        )
      ],
    );
  }

 Widget _botonInspeccionar(int id) {
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
      onSelected: (String choice) async {
        if (choice == 'editar') {
          // Lógica para la opción 'Editar'
        } else if (choice == 'eliminar') {
           IncidenciaService.deleteIncidencia(id).then((value) {
             setState(() {
          });
           });
          // Recargar la lista de incidencias después de eliminar
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
