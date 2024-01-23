import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/services/ClienteService.dart';
import 'package:transita3/services/LoginService.dart';

class CambiarContrasenaPantalla extends StatefulWidget {
  @override
  _CambiarContrasenaPantallaState createState() =>
      _CambiarContrasenaPantallaState();
}

class _CambiarContrasenaPantallaState extends State<CambiarContrasenaPantalla> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _contrasenaController = TextEditingController();
  TextEditingController _confirmarContrasenaController =
      TextEditingController();

  LoginService loginService = new LoginService();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final clienteService = Provider.of<LoginService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
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
                          controller: _contrasenaController,
                          decoration: InputDecoration(
                            labelText: 'Nueva Contraseña',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa la nueva contraseña';
                            }
                            // Puedes agregar validaciones adicionales aquí
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _confirmarContrasenaController,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Nueva Contraseña',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != _contrasenaController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              try {
                                // Llamar a la función modifyContrasenya del servicio
                                await clienteService.modifyContrasenya(
                                  {
                                    'currentPassword': clienteService
                                        .password, // Contraseña actual
                                    'contrasenya': _contrasenaController
                                        .text, // Nueva contraseña
                                  },
                                  LoginService.cliente.id,
                                );

                                // Mostrar el SnackBar si la modificación de la contraseña es exitosa
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Contraseña modificada con éxito'),
                                  ),
                                );
                              } catch (error) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Tu cuenta ha expirado.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/', (route) => false);
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text('Cambiar Contraseña'),
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
