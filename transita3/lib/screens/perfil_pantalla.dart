import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/services/ClienteService.dart';
import 'package:transita3/models/cliente.dart';
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

  @override
  void initState() {
    super.initState();
    // Aquí, obtén la instancia de ClienteService usando Consumer
    final clienteService = Provider.of<LoginService>(context, listen: false);
print('Nombre: ${LoginService.cliente.nombre}');
  print('Apellido: ${LoginService.cliente.apellidos}');
  //print('Correo: ${LoginService.cliente.nombre}');
    // Configura los controladores con los datos del cliente
    _nombreController.text = LoginService.cliente.nombre;
    _correoController.text = LoginService.cliente.nombreUsuario;
    _apellidoController.text = LoginService.cliente.apellidos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ClienteService>(
            builder: (context, clienteService, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/transitaLogoBN.png',
                    height: 100.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(labelText: 'Nombre'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
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
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Construir un objeto Cliente con los datos del formulario
                              Map<String, dynamic> updatedFields = {
                                'nombre': _nombreController.text,
                                'apellidos': _apellidoController.text,
                                'nombreUsuario': _correoController.text,
                                'rol':LoginService.cliente.roles
                                // Agrega más campos según sea necesario
                              };

                              // Llamar a la función modifyCliente del servicio
                             clienteService.modifyCliente(updatedFields, LoginService.cliente.id);

                              // Mostrar el SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cambios guardados con éxito'),
                                ),
                              );
                            }
                          },
                          child: Text('Guardar cambios'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
