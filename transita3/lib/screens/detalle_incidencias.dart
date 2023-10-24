import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/screens/inicio_sesion.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
import 'dart:io'; // Para trabajar con archivos

class detalle_incidencias extends StatefulWidget {
  @override
  _detalleIincidencias createState() => _detalleIincidencias();
}
class _detalleIincidencias extends State<detalle_incidencias> {
  
  String tituloIncidencia = '', descripcion = ' choque de coches en la via san martin, calle no accesible',calle = "X", 
  estado = "En progreso",fechaIncidenciaString = '11/02/2002',razonIncidencia = "Obras calle x";
  FileImage ?imagenIncidencia = null;
  DateTime ?fechaIncidencia = null;
  
  @override
Widget build(BuildContext context) {
    String calle = " ";
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
          child: Column(
            children: [
               Stack(
                children: [
                  Container(
                    width: 500,
                    height: 400,
                    child: Image.asset('assets/logo2.png'), 
                  ),
                  Positioned(
                    top: 0, 
                    left: 0, 
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child:  Text(
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
                padding:  EdgeInsets.all(10),
                child:  Row(
                  children: [
                    Text(
                      'Razon: $razonIncidencia',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),

            
              Container(
                padding:  EdgeInsets.all(10),
                child:  Row(
                  children: [
                    Text(
                      'Fecha: $fechaIncidenciaString',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),

             
              Container(
                padding:  EdgeInsets.all(10),
                child:  Row(
                  children: [
                    Text(
                      'Estado: $estado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),

             Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Descripción:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 243, 242, 242),
                  ),
                ),
              ),

              // Texto de descripción en Dart
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  descripcion,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
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