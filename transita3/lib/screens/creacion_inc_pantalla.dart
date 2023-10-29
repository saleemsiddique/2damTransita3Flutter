import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/screens/inicio_sesion_pantalla.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreacionIncidenciasPage extends StatefulWidget {
  @override
  _creacionIncidencia createState() => _creacionIncidencia();
}

class _creacionIncidencia extends State<CreacionIncidenciasPage> {
  String _tituloIncidencia = '', _descripcion = '';
  double _duracion = 0;
  File? _selectedImage;
  String _selectedDuration = '1 hora';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
          child: Column(
            children: [
              _logo(),
              Container(
                height: 70,
              ),
              Container(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: _escribeTitulo(),
              ),
              Container(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: _seleccionarDuracion(),
              ),
              Container(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: _seleccionarFoto(),
              ),
              Container(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: _escribeDescripcion(),
              ),
              Container(
                height: 20,
              ),
              Container(
                width: 325,
                //margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: _botonCrear(),
              ),
              Container(
                height: 20,
              ),
              Container(
                width: 325,
                //margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: _botonCancelar(),
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

  Widget _escribeTitulo() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Titulo',
        labelText: 'Titulo de la incidencia',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _tituloIncidencia = valor;
      }),
    );
  }

  Widget _escribeDescripcion() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Descripcion',
        labelText: 'Descripcion de la incidencia',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _descripcion = valor;
      }),
    );
  }

  Widget _seleccionarFoto() {
    return Column(
      children: [
        MaterialButton(
            color: Colors.blue,
            child: const Text("Seleccionar Imagen",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            onPressed: () {
              _pickImageFromGalery();
            })
      ],
    );
  }

  Future _pickImageFromGalery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.name);
    });
  }

  Widget _seleccionarDuracion() {
    return DropdownButton<String>(
      value: _selectedDuration,
      items: ['1 hora', '2 horas', '3 horas', '4 horas', '5 horas', '6 horas']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedDuration = newValue ?? '';
        });
      },
    );
  }

  Widget _botonCrear() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            color: Color.fromRGBO(14, 100, 209, 1),
            onPressed: () {},
            child: Text('Crear'));
      },
    );
  }

  Widget _botonCancelar() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            color: Color.fromRGBO(255, 255, 255, 1),
            onPressed: () {
              setState(() {
                _descripcion = "";
                _tituloIncidencia = "";
                _selectedDuration = '1 hora';
                _selectedImage = null;
              });
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Color.fromRGBO(14, 100, 209, 1)),
            ));
      },
    );
  }
}
