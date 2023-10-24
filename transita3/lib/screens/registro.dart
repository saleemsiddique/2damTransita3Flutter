import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/screens/inicio_sesion.dart';

class RegistroPage extends StatefulWidget {
  @override
  _Registro createState() => _Registro();
}

class _Registro extends State<RegistroPage> {
  String _nombre = '', _apellidos = '', _email = '', _contrasenya = '';
  bool _mostrarContrasenya = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
          children: [
            _logo(),
            Container(
              height: 70,
            ),
            Text(
              'Registrate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _escribeNombre(),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _escribeApellidos(),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _escribirEmail(),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: _escribirContrasenya(),
            ),
            Container(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: _botonRegistro(),
            ),
            Container(
              height: 30,
            ),
            _iniciarSesion()
          ],
        ),
      ),
    );
    ;
  }

  Widget _logo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/transitaPng.png', height: 70, width: 70),
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
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Nombre',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (valor) => setState(() {
        _nombre = valor;
      }),
    );
  }

  Widget _escribeApellidos() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Apellidos',
        labelText: 'Apellidos',
        suffixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (valor) => setState(() {
        _apellidos = valor;
      }),
    );
  }

  Widget _escribirEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        //icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget _escribirContrasenya() {
    return TextField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      obscureText: !_mostrarContrasenya,
      onChanged: (valor) => setState(() {
        _contrasenya = valor;
      }),
    );
  }

  Widget _botonRegistro() {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Color.fromRGBO(14, 100, 209, 1),
            onPressed: () {},
            child: Text('Registrarse'));
      },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IniciarSesionPage()),
                    );
                  }),
          ])),
    );
  }
}
