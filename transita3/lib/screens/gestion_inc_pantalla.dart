import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:provider/provider.dart';
import 'package:transita3/widgets/widgets.dart';
import 'package:transita3/models/models.dart';

class GestionIncidenciasPage extends StatefulWidget {
  @override
  _GestionIncidencias createState() => _GestionIncidencias();
}

final TextStyle _estiloLetra = TextStyle(fontSize: 13);

class _GestionIncidencias extends State<GestionIncidenciasPage> {
  @override
  Widget build(BuildContext context) {
    final incidenciasService =
        Provider.of<IncidenciaService>(context, listen: true);

    if (incidenciasService.incidenciasDeUsuario.isEmpty) {
      try {
        incidenciasService.getIncidencias();
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(S.of(context).errorobtainingincidences),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      floatingActionButton:
          botonAgregar(context, 'home', null, 80, 80, null, null),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 40),
        children: <Widget>[
          _logo(),
          Container(height: 80),
          _lista(incidenciasService.incidenciasDeUsuario)
        ],
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

  List<Widget> _listaIncidencias(List<Incidencia> data, BuildContext context) {
    final List<Widget> incidencias = [];
    int _cont = 1;
    data.forEach((incidencia) {
      final widgetTemp = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _columnaIzquierda(incidencia.descripcion, incidencia.descripcion,
              incidencia.id, incidencia),
          _columnaDerecha(incidencia.id),
        ],
      );
      incidencias.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'detalleincidencia',
                arguments: incidencia);
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
          Text(S.of(context).noIncidences),
        ],
      );
    } else {
      return Column(
        children: _listaIncidencias(listaIncidencias, context),
      );
    }
  }

  Widget _columnaIzquierda(
      String nombre, String direccion, int id, Incidencia incidencia) {
    if (direccion.length >= 19) direccion = direccion.substring(0, 19);
    if (nombre.length >= 16) nombre = nombre.substring(0, 16);
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: showImage(incidencia)),
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
            _botonEliminar(context, id),
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

  Widget _botonEliminar(BuildContext context, int id) {
    final incidenciasService =
        Provider.of<IncidenciaService>(context, listen: false);

    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).confirmDelete),
              content: Text(
                  S.of(context).confirmDeletIncidence),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                  },
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      // Lógica para la opción 'Eliminar'
                      await incidenciasService.deleteIncidencia(id);
                      setState(() {
                        incidenciasService.getIncidencias();
                      });
                      // Recargar la lista de incidencias después de eliminar
                      Navigator.of(context)
                          .pop(); // Cerrar el cuadro de diálogo
                    } catch (error) {
                      // Mostrar un aviso en caso de error
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(
                                S.of(context).errordeletingincidence),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (route) => false);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(S.of(context).delete),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
