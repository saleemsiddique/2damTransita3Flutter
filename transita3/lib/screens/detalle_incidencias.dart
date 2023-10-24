import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/screens/inicio_sesion.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'dart:io'; 

class detalle_incidencias extends StatefulWidget {
  @override
  _detalleIincidencias createState() => _detalleIincidencias();
}
class _detalleIincidencias extends State<detalle_incidencias> {
  
  String tituloIncidencia = '', descripcion = ' choque de coches en la via san martin, calle no accesibl,hoque de coches encoches en la via san martin, calle no accesiblee',calle = "X", 
  estado = "En progreso",fechaIncidenciaString = '11/02/2002',razonIncidencia = "Obras calle x";
  FileImage ?imagenIncidencia = null;
  DateTime ?fechaIncidencia = null;
  
  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
               Stack(
               children: [
              Container(
                width: 500,
                height: 500,
                 margin: EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/obras.png',
                    width: 500, 
                    height: 500, 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Indicencia calle $calle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                      Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 70, 67, 67),
                  borderRadius: BorderRadius.all(Radius.circular(20)), // Bordes con radio de 20 en todos los lados
                ),
                margin: EdgeInsets.all(20), // Margen en todos los lados de 20
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'Razon: $razonIncidencia',
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
                            'Fecha: $fechaIncidenciaString',
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
                            'Estado: $estado',
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
                            'Descripción: ',
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
                      padding: EdgeInsets.all(9),
                      child: Flexible(
                        child: Text(
                          descripcion,
                          style: TextStyle(
                            color: Colors.white,
                        ),
                      ),
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
          Image.asset('assets/transitaPng.png', height: 70, width: 70),
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