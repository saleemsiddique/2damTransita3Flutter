import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'dart:io';

import 'package:transita3/services/LoginService.dart';
import 'package:transita3/services/PuntoService.dart';

class CreacionIncidenciasPage extends StatefulWidget {
  @override
  _creacionIncidencia createState() => _creacionIncidencia();
}

class _creacionIncidencia extends State<CreacionIncidenciasPage> {
  final _formKey = GlobalKey<FormState>();
  String _descripcion = '';
  String _duracion = '';
  String _estado = 'ENVIADO';
  String _idCliente = LoginService.cliente.id.toString();
  String _fecha = DateTime.now().toLocal().toString().split(' ')[0];
  late Punto? _selectedPunto = null;
  String? _selectedImage;
  String? _imageDisplay;
  String _selectedDuration = '1 hora';

  @override
  Widget build(BuildContext context) {
    PuntoService();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _logo(),
                Container(
                  height: 20,
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
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _seleccionarDuracion(),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _seleccionarPunto(),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _buildImageOrButton(),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  width: 325,
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
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Image.asset('assets/transitaLogoBN.png', height: 120, width: 120),
        ],
      ),
    );
  }

  Widget _sacarFoto() {
    return Column(
      children: [
        //_mostrarImagen(),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () async {
            await _tomarFoto();
          },
        ),
      ],
    );
  }

  /*Widget _mostrarImagen() {
    return _selectedImage != null
        ? Image.file(_selectedImage!, height: 100, width: 100)
        : Container();
  }*/

  Future<void> _tomarFoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = getBase64FormateFile(pickedFile.path);
      });
    }
  }

   static String getBase64FormateFile(String path) {
    File file = File(path);
    print('File is = ' + file.toString());
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  Widget _seleccionarPunto() {
    return Row(
      children: [
        Text('Seleccionar Punto', style: TextStyle(color: Colors.grey)),
        SizedBox(
          width: 20,
        ),
        DropdownButton<int>(
          value: _selectedPunto?.id,
          items: PuntoService.puntos.map((punto) {
            return DropdownMenuItem<int>(
              value: punto.id,
              child: Text('${punto.id}'),
            );
          }).toList(),
          onChanged: (int? newValue) async {
            if (newValue != null) {
              await PuntoService.getPunto(newValue);
              setState(() {
                _selectedPunto = PuntoService.puntos
                    .firstWhere((punto) => punto.id == newValue);
              });
              print("Este es el punto que acabas de escoger $_selectedPunto");
            }
          },
        ),
      ],
    );
  }

  Widget _escribeDescripcion() {
    return TextFormField(
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 10) {
          return 'La descripcion debe contener mas informacion';
        }
        return null;
      },
    );
  }

  Widget _seleccionarDuracion() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Duración estimada',
        hintText: 'Ingrese la duración',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (String value) {
        setState(() {
          _duracion = value;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 10) {
          return 'Indique una duracion';
        }
        return null;
      },
    );
  }

  Widget _botonCrear() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      color: Color.fromRGBO(14, 100, 209, 1),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          Map<String, dynamic> incidenciaData = {
            'descripcion': _descripcion,
            'estado': _estado,
            'duracion': _duracion,
            'fechaHora': _fecha,
            "fotos": "$_selectedImage",
            'punto': _selectedPunto?.toJson(),
            'cliente': LoginService.cliente.toJson(),
          };
          await IncidenciaService.postIncidencia(incidenciaData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incidencia creada exitosamente'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarProvider()),
          );
        }
      },
      child: Text('Crear'),
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
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Color.fromRGBO(14, 100, 209, 1)),
            ));
      },
    );
  }

  Future<void> _getImage() async {
  final picker = ImagePicker();
  final pickedFile = await showModalBottomSheet<XFile?>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        // Evitar que el toque en el fondo cierre el modal
        onTap: () {
          Navigator.pop(context, null);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Seleccionar de la galería'),
              onTap: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.gallery));
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Sacar una foto'),
              onTap: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.camera));
              },
            ),
          ],
        ),
      );
    },
  );

  // Solo actualiza la imagen si el usuario selecciona una nueva
  if (pickedFile != null) {
    setState(() {
      _imageDisplay = pickedFile!.path;
      _selectedImage = getBase64FormateFile(pickedFile!.path);
    });
  }
}

  Widget _buildImageOrButton() {
    if (_selectedImage != null) {
      return GestureDetector(
      onTap: () {
        _changeImage();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(
              File(_imageDisplay!),
              fit: BoxFit.cover,
              width: 300,
              height: 200,
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.camera,
                  size: 48.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Cambiar Imagen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    } else {
      return Container(
        alignment: Alignment.center, // Para centrar el botón en la columna
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(18.0),
          color: Color(0x8069a2f2),
          strokeWidth: 2.0,
          dashPattern: [8, 8],
          child: ElevatedButton.icon(
            onPressed: () {
              _getImage();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  vertical: 60.0,
                  horizontal: 116.0)), // Ajusta la altura del botón
            ),
            icon: Icon(
              Icons.camera_alt,
              color: Color(0x8069a2f2),
            ),
            label: Text(
              'Subir Foto',
              style: TextStyle(color: Color(0x8069a2f2)),
            ),
          ),
        ),
      );
    }
  }

  void _changeImage() async {
    final picker = ImagePicker();
    final pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Seleccionar de la galería'),
              onTap: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.gallery));
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Sacar una foto'),
              onTap: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.camera));
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _selectedImage = getBase64FormateFile(pickedFile!.path);
    });
  }
}
