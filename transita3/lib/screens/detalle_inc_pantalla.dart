import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/widgets/Show_Image.dart';

class detalle_incidencias extends StatefulWidget {
  @override
  _detalleIincidencias createState() => _detalleIincidencias();
}

class _detalleIincidencias extends State<detalle_incidencias> {
  int id = 0;
  String descripcion = '';
  String duracion = '';
  String estado = '';
  DateTime fecha = DateTime.now();
  String cliente = '';
  String punto = '';
  String imagenIncidencia = '';
  DateTime? fechaIncidencia = null;

  @override
  Widget build(BuildContext context) {
    Incidencia incidencia =
        ModalRoute.of(context)?.settings.arguments as Incidencia;
    setState(() {
      id = incidencia.id;
      descripcion = incidencia.descripcion;
      duracion = incidencia.duracion;
      estado = incidencia.estado;
      fecha = incidencia.fechaHora;
      cliente = incidencia.cliente.toString();
      punto = incidencia.punto.toString();
      imagenIncidencia = incidencia.punto.foto!;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(
            255, 31, 25, 25), // Ajusta este color según tus necesidades
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(S.of(context).incidentNumber + ' $id'),
      ),
      body: Container(
        color: Color.fromARGB(
            255, 31, 25, 25), // Ajusta este color según tus necesidades
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 500,
                    height: 500,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: showImage(incidencia)),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 70, 67, 67),
                  borderRadius: BorderRadius.all(Radius.circular(
                      20)), // Bordes con radio de 20 en todos los lados
                ),
                margin: EdgeInsets.all(20), // Margen en todos los lados de 20
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).description + ': $descripcion',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).date + ': $fecha',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).status + ': $estado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).duration + ': $duracion ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).client + ': ${cliente.toString()} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            punto.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage('assets/transitaPng.png'),
              fadeInDuration: Duration(milliseconds: 200),
              height: 70,
              width: 70),
          SizedBox(width: 25),
          const Text(
            'Transita',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
