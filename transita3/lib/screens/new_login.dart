import 'package:flutter/material.dart';
import 'package:transita3/screens/signin_page.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _InicioSesion createState() => _InicioSesion();
}

class _InicioSesion extends State<IniciarSesionPage> {
  String _email = '';
  String _contrasenya = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 250, 5, 0),
        children: [
          _escribirEmail(),
          Divider(),
          _escribirContrasenya(),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: _botonLogin(),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _escribirEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget _escribirContrasenya() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (valor) => setState(() {
        _contrasenya = valor;
      }),
    );
  }

  Widget _botonLogin() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Colors.pink,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Iniciar Sesión'));
      },
    );
  }

  Widget _loginExtra() {
    return Row();
  }
}
