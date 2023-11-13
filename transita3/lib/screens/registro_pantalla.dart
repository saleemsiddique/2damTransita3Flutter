import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:transita3/screens/inicio_sesion_pantalla.dart';

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
      body: Container(
        child: _registroForm(),
      ),
    );
  }

  Widget _registroForm() {
    return SingleChildScrollView(
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
    return TextField(
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
    );
  }

  Widget _escribeApellidos() {
    return TextField(
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
    );
  }

  Widget _botonRegistro() {
    return Container(
      width: double.infinity,
      height: 50, // Ancho igual al ancho completo disponible
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Color.fromRGBO(14, 100, 209, 1),
        onPressed: () {},
        child: Text('Registrarse', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _iniciarSesion() {
    return Center(
      child:Hero(tag:'registrarDash',
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
          ])),)
    );
  }
}
