import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/olvidar_contrasenya.dart';
import 'package:transita3/services/LoginService.dart';

class OlvidarContrasenyaScreen extends StatefulWidget {
  @override
  _OlvidarContrasenyaScreenState createState() =>
      _OlvidarContrasenyaScreenState();
}

class _OlvidarContrasenyaScreenState extends State<OlvidarContrasenyaScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey =
      GlobalKey<FormState>(); // Añadido un GlobalKey para el formulario
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).forgotPassword),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asigna la clave del formulario
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80),
              Image.asset(
                'assets/transitaLogoBN.png',
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(height: 20),
              if (_isLoading)
                Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      'Esto puede llevar un momento...',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              _buildEmailTextField(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: Text(S.of(context).cancel),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();

                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                print(_emailController.text);
                                final response = await loginForm
                                    .forgotPassword(_emailController.text);

                                print(
                                    "Ya dio error"); // Este mensaje debería imprimirse solo si la línea anterior no lanza excepciones

                                if (response
                                    .contains('Internal Server Error')) {
                                  throw Exception('No hay cuenta Transita asociada a este correo');
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OlvidarContrasenya(),
                                  ),
                                );
                              } catch (error) {
                                print("Dentro catch");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                        'No hay cuenta Transita asociada a este correo'
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Aceptar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } finally {
                                print(
                                    "Finally block executed"); // Agrega este print para verificar si se ejecuta el bloque finally
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    child: Text("Enviar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Correo electrónico",
      ),
      enabled:
          !_isLoading, // Deshabilitar el TextFormField cuando isLoading es true
      onChanged: (value) {
        // Puedes realizar alguna acción cuando cambia el valor del TextField
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un correo electrónico';
        } else if (!RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        return null;
      },
    );
  }
}
