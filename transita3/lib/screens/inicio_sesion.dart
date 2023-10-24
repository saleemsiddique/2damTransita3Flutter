import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transita3/screens/gestion_incidencias.dart';
import 'package:transita3/screens/registro.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _InicioSesion createState() => _InicioSesion();
}

class _InicioSesion extends State<IniciarSesionPage> {
  String _email = '';
  String _contrasenya = '';
  bool _mostrarContrasenya = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        children: [
          Image.asset(
            'assets/logo2SinFondo.png',
            width: 250,
            height: 250,
          ),
          Container(
            height: 70,
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
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: _botonLogin(),
          ),
          Container(
            height: 10,
          ),
          _loginExtra(),
          Container(
            height: 50,
          ),
          _crearCuenta()
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
        //icon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
          child: Icon(_mostrarContrasenya ? Icons.visibility : Icons.visibility_off),
        ),
        //icon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      obscureText: !_mostrarContrasenya,
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            color: Color.fromRGBO(14, 100, 209, 1),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GestionIncidenciasPage()));
            },
            child: Text('Iniciar Sesión'));
      },
    );
  }

  Widget _loginExtra() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_botonGoogle()],
      ),
    );
  }

  Widget _botonGoogle() {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          side: BorderSide(color: Colors.grey),
        ),
      ),
      icon: Image.asset(
        'assets/googleLogo.png',
        height: 20,
      ),
      label: Text(
        'Iniciar Sesión con Google',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _crearCuenta() {
    return Center(
      child: RichText(
          text: TextSpan(text: '¿No tienes cuenta? Pulsa ', children: <TextSpan>[
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
                  MaterialPageRoute(builder: (context) => RegistroPage()),
                );
              }),
        TextSpan(text: ' para crearla')
      ])),
    );
  }

  Widget _logo() {
    return Center();
  }

  //TODO: TAL VEZ NUEVOS BOTONES DE INICIO DE SESION COMO FB, IG O TWITTER
}
