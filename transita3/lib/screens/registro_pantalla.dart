import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/services/ClienteService.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/LoginService.dart';

class RegistroPage extends StatefulWidget {
  @override
  _Registro createState() => _Registro();
}

class _Registro extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '', _apellidos = '', _email = '', _contrasenya = '';
  bool _mostrarContrasenya = false;
  ClienteService clienteProvider = new ClienteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _registroForm(),
      ),
    );
  }

  Widget _registroForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            _logo(),
            SizedBox(height: 20),
            Text(
              'Regístrate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  _escribeNombre(),
                  SizedBox(height: 20),
                  _escribeApellidos(),
                  SizedBox(height: 20),
                  _escribirEmail(),
                  SizedBox(height: 20),
                  _escribirContrasenya()
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [_botonRegistro()],
              ),
            ),
            SizedBox(height: 30),
            _iniciarSesion()
          ],
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

  Widget _escribeNombre() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Nombre',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _nombre = valor;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 3) {
          return 'El nombre debe contener al menos 2 caracteres';
        }
        return null;
      },
    );
  }

  Widget _escribeApellidos() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Apellidos',
        labelText: 'Apellidos',
        suffixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _apellidos = valor;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 3) {
          return 'El nombre debe contener al menos 2 caracteres';
        }
        return null;
      },
    );
  }

  Widget _escribirEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        //icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa un correo electrónico';
        }
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);

        return regExp.hasMatch(value) ? null : 'Introduce un email válido';
      },
    );
  }

  Widget _escribirContrasenya() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _mostrarContrasenya = !_mostrarContrasenya;
            });
          },
          child: Icon(
              _mostrarContrasenya ? Icons.visibility : Icons.visibility_off),
        ),
        //icon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      obscureText: !_mostrarContrasenya,
      onChanged: (valor) => setState(() {
        _contrasenya = valor;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'La contraseña debe contener al menos 6 caracteres';
        }
        return null;
      },
    );
  }

  Widget _botonRegistro() {
    return Container(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Color.fromRGBO(14, 100, 209, 1),
        onPressed: () async {
          print("Empezó");
          if (_formKey.currentState?.validate() == true) {
            Map<String, dynamic> credenciales = {
              'nombre': _nombre,
              'apellidos': _apellidos,
              'nombreUsuario': _email,
              'contrasenya': _contrasenya,
              'rol': ["ROLE_USUARIO"],
            };

            try {
              await clienteProvider.signUpCliente(credenciales);
              Map<String, dynamic> credencialesLogIn = {
                'nombreUsuario': _email,
                'contrasenya': _contrasenya,
              };
              await LoginService().signInCliente(credencialesLogIn);
              IncidenciaService();
              Navigator.pushNamed(context, 'home');
            } catch (error) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error de registro'),
                    content: Text(
                        'Una cuenta con este email ya está creada. Por favor, inicia sesión.'),
                    actions: <Widget>[
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
            }
          }
          print("Acabó");
        },
        child: Text('Registrarse', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _iniciarSesion() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: '¿Ya tienes cuenta? Inicia sesión ',
              children: <TextSpan>[
            TextSpan(
                text: 'AQUÍ',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  }),
          ])),
    );
  }
}
