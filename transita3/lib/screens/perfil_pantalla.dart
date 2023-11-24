import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/services/ClienteService.dart';
import 'package:transita3/models/cliente.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/LoginService.dart';

class PerfilPantalla extends StatefulWidget {
  @override
  State<PerfilPantalla> createState() => _PerfilPantallaState();
}

class _PerfilPantallaState extends State<PerfilPantalla> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  LoginService loginForm = new LoginService();

  @override
  void initState() {
    super.initState();
    final clienteService = Provider.of<LoginService>(context, listen: false);
<<<<<<< Updated upstream
    print("${LoginService.cliente.id}");
  print('Nombre: ${LoginService.cliente.nombre}');
  print('Apellido: ${LoginService.cliente.apellidos}');
  print("Roles: ${LoginService.cliente.roles}");
  //print('Correo: ${LoginService.cliente.nombre}');
    // Configura los controladores con los datos del cliente
=======
>>>>>>> Stashed changes
    _nombreController.text = LoginService.cliente.nombre;
    _correoController.text = LoginService.cliente.nombreUsuario;
    _apellidoController.text = LoginService.cliente.apellidos;
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Perfil'),
    ),
    body: SingleChildScrollView(
      child: Center(
        child: Consumer<ClienteService>(
          builder: (context, clienteService, child) {
            return Container(
              color: const Color.fromARGB(255, 65, 63, 63),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color.fromARGB(255, 65, 63, 63),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo2SinFondo.png',
                          width: 170.0,
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
<<<<<<< Updated upstream
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _apellidoController,
                          decoration: InputDecoration(labelText: 'Apellido'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu apellido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _correoController,
                          decoration: InputDecoration(labelText: 'Correo'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu correo';
                            }
                            // Puedes agregar validaciones de formato de correo electrónico aquí
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Construir un objeto Cliente con los datos del formulario
                              Map<String, dynamic> updatedFields = {
                                'nombre': _nombreController.text,
                                'apellidos': _apellidoController.text,
                                'nombreUsuario': _correoController.text,
                                'rol': ["${LoginService.cliente.roles}"]
                              };

                              // Llamar a la función modifyCliente del servicio
                             await clienteService.modifyCliente(updatedFields, LoginService.cliente.id);
                              LoginService.cliente.nombre = _nombreController.text;
                              LoginService.cliente.apellidos = _apellidoController.text;
                              LoginService.cliente.nombreUsuario = _correoController.text;
                              // Mostrar el SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cambios guardados con éxito'),
=======
                        SizedBox(height: 60.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  labelText: 'Nombre',
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.person),
>>>>>>> Stashed changes
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingresa tu nombre';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 45.0),
                              TextFormField(
                                controller: _apellidoController,
                                decoration: InputDecoration(
                                  labelText: 'Apellido',
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingresa tu apellido';
                                  }
                                  return null;
                                }, 
                              ),
                              SizedBox(height: 45.0),
                              TextFormField(
                                controller: _correoController,
                                decoration: InputDecoration(
                                  labelText: 'Correo',
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingresa tu correo';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 130.0),  // Ajusta la altura según tus necesidades
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    Map<String, dynamic> updatedFields = {
                                      'nombre': _nombreController.text,
                                      'apellidos': _apellidoController.text,
                                      'nombreUsuario': _correoController.text,
                                      'rol': LoginService.cliente.roles
                                    };

                                    clienteService.modifyCliente(
                                      updatedFields,
                                      LoginService.cliente.id,
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Cambios guardados con éxito'),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Guardar cambios',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Otros widgets que desees agregar
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
}