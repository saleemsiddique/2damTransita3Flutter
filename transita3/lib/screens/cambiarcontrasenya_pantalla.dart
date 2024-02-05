import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/Error_TokenExpired.dart';

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

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).changepass),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        TextFormField(
                          // Contraseña actual
                          decoration: InputDecoration(
                            labelText: S.of(context).currentpassword,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value != loginService.password) {
                              return S.of(context).actualpassincorrect;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _contrasenaController,
                          decoration: InputDecoration(
                            labelText: S.of(context).newPassword,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.length < 6 ||
                                value.isEmpty) {
                              return S.of(context).validatorPassword;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _confirmarContrasenaController,
                          decoration: InputDecoration(
                            labelText: S.of(context).confirmNewPassword,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != _contrasenaController.text) {
                              return S.of(context).passwordsDoNotMatch;
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
                                    'currentPassword':
                                        _contrasenaController.text,

                                    'contrasenya': _contrasenaController
                                        .text, // Nueva contraseña
                                  },
                                  LoginService.cliente.id,
                                );

                                // Mostrar el SnackBar si la modificación de la contraseña es exitosa
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(S
                                        .of(context)
                                        .passwordChangedSuccessfully),
                                  ),
                                );
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'home', (route) => false);
                              } catch (error) {
                                errorTokenExpired(context);
                              }
                            }
                          },
                          child: Text(S.of(context).changepass),
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
