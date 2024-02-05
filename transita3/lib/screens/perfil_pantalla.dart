import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/services/Services.dart';

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
    _nombreController.text = LoginService.cliente.nombre;
    _correoController.text = LoginService.cliente.nombreUsuario;
    _apellidoController.text = LoginService.cliente.apellidos;
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
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
                          SizedBox(height: 60.0),
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nombreController,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).name,
                                    border: OutlineInputBorder(),
                                    icon: Icon(Icons.person),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).pleaseentername;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 45.0),
                                TextFormField(
                                  controller: _apellidoController,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).secondName,
                                    border: OutlineInputBorder(),
                                    icon: Icon(Icons.person),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S
                                          .of(context)
                                          .pleaseentersecondname;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 45.0),
                                TextFormField(
                                  enabled: false,
                                  controller: _correoController,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).email,
                                    border: OutlineInputBorder(),
                                    icon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).enterEmailPlease;
                                    }
                                    String pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regExp = new RegExp(pattern);

                                    return regExp.hasMatch(value)
                                        ? null
                                        : S.of(context).validatorEmail;
                                  },
                                ),
                                SizedBox(
                                    height:
                                        130.0), // Ajusta la altura según tus necesidades
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      try {
                                        Map<String, dynamic> updatedFields = {
                                          'nombre': _nombreController.text,
                                          'apellidos': _apellidoController.text,
                                          'nombreUsuario':
                                              _correoController.text,
                                          'rol': LoginService.cliente.roles
                                        };

                                        // Llamar a la función modifyCliente del servicio
                                        await clienteService.modifyCliente(
                                          updatedFields,
                                          LoginService.cliente.id,
                                        );

                                        Map<String, dynamic> credenciales = {
                                          'nombreUsuario':
                                              _correoController.text,
                                          'contrasenya': loginForm.password,
                                        };

                                        await loginForm
                                            .signInCliente(credenciales);
                                        print("Pass: ${loginForm.password}");

                                        // Mostrar el SnackBar si la modificación del cliente es exitosa
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .changesSavedCorrectly),
                                          ),
                                        );
                                      } catch (error) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Error'),
                                              content: Text(S
                                                  .of(context)
                                                  .errorsaveChanges),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            '/',
                                                            (route) => false);
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
                                  child: Text(
                                    S.of(context).saveChanges,
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
