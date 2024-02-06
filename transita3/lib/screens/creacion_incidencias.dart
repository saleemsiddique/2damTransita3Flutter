import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transita3/services/Services.dart';
import 'dart:io';
import 'package:transita3/widgets/Error_TokenExpired.dart';

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
  String? _selectedImage;
  String? _imageDisplay;
  String _selectedAccesibilidad = "";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    double lat = args?['lat'];
    double lon = args?['lon'];

    // Lista de opciones para el ComboBox
    List<String> opcionesAccesibilidad = [
      S.of(context).parcialmenteAccesible,
      S.of(context).noAccesible
    ];

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _logo(),
                Container(height: 20),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _escribeDescripcion(),
                ),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _seleccionarDuracion(),
                ),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _seleccionarPunto(lat, lon),
                ),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _buildImageOrButton(),
                ),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: _buildAccesibilidadDropdown(opcionesAccesibilidad),
                ),
                Container(height: 20),
                Container(
                  width: 325,
                  child: _botonCrear(lat, lon),
                ),
                Container(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: 325,
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

  Widget _seleccionarPunto(double lat, double lon) {
    String formattedLat = lat.toStringAsFixed(4);
    String formattedLon = lon.toStringAsFixed(4);

    return Row(
      children: [
        Text('Punto - lat: $formattedLat, lon: $formattedLon',
            style: TextStyle(color: Colors.grey)),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget _escribeDescripcion() {
    return TextFormField(
      maxLength: 100,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: S.of(context).description,
        labelText: S.of(context).incidencedesc,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _descripcion = valor;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 10) {
          return S.of(context).descriptionInfo;
        }
        return null;
      },
    );
  }

  Widget _seleccionarDuracion() {
    return TextFormField(
      maxLength: 30,
      decoration: InputDecoration(
        labelText: S.of(context).specifyDuration,
        hintText: S.of(context).enterDuration,
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
          return S.of(context).specifyDuration;
        }
        return null;
      },
    );
  }

  Widget _buildAccesibilidadDropdown(List<String> opcionesAccesibilidad) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: S.of(context).accessibility,
        border: OutlineInputBorder(),
      ),
      items: opcionesAccesibilidad.map((String opcion) {
        return DropdownMenuItem(
          value: opcion,
          child: Text(opcion),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedAccesibilidad = newValue!;
        });
      },
      validator: (_selectedvalue) {
        if (_selectedvalue == null || _selectedvalue.isEmpty) {
          return S.of(context).selectAccessibilityLevel;
        }
        return null;
      },
    );
  }

  Widget _botonCrear(double lat, double lon) {
    final puntosService = Provider.of<PuntoService>(context, listen: true);
    final incidenciaService =
        Provider.of<IncidenciaService>(context, listen: true);
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      color: Color.fromRGBO(14, 100, 209, 1),
      onPressed: () async {
        if (_selectedAccesibilidad == "Not Accessible" ||
            _selectedAccesibilidad == "No Accesible" ||
            _selectedAccesibilidad == "No Accessible") {
          _selectedAccesibilidad = "NO_ACCESIBLE";
        } else if (_selectedAccesibilidad == "Partially Accessible" ||
            _selectedAccesibilidad == "Parcialmente Accesible" ||
            _selectedAccesibilidad == "Parcialment Accessible") {
          _selectedAccesibilidad = "PARCIALMENTE_ACCESIBLE";
        }
        try {
          print("This is Descripcion: $_descripcion");
          if (_formKey.currentState?.validate() ?? false) {
            Map<String, dynamic> puntoData = {
              'descripcion': '',
              'tipoPunto': 'LUGAR',
              'foto': '',
              'latitud': lat,
              'longitud': lon,
              'accesibilidadPunto': _selectedAccesibilidad,
              'visibilidadPunto': 'GLOBAL'
            };
            // Llamar a la función postPunto del servicio
            await puntosService.postPunto(puntoData);

            Map<String, dynamic> incidenciaData = {
              'descripcion': _descripcion,
              'estado': _estado,
              'duracion': _duracion,
              'fechaHora': _fecha,
              "fotos": "$_selectedImage",
              'punto': puntosService.puntoNuevo.toJson(),
              'cliente': LoginService.cliente.toJson(),
            };
            // Llamar a la función postIncidencia del servicio
            await incidenciaService.postIncidencia(incidenciaData);

            // Llamar a la función getIncidencias del servicio
            await incidenciaService.getIncidencias();

            // Mostrar el SnackBar si la creación de la incidencia es exitosa
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).incidentCreatedSuccessfully),
              ),
            );
            Navigator.pop(context);
          }
        } catch (error) {
          errorTokenExpired(context);
        }
      },
      child: Text(S.of(context).create),
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
              S.of(context).cancel,
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
                title: Text(S.of(context).selectFromGallery),
                onTap: () async {
                  Navigator.pop(context,
                      await picker.pickImage(source: ImageSource.gallery));
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(S.of(context).takeAPhoto),
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
                    S.of(context).changeImage,
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
              S.of(context).uploadPhoto,
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
              title: Text(S.of(context).selectFromGallery),
              onTap: () async {
                Navigator.pop(context,
                    await picker.pickImage(source: ImageSource.gallery));
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(S.of(context).takeAPhoto),
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
