import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transita3/navigation_bar.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/screens/registro_pantalla.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: AssetImage('assets/transitaLogoBN.png'),
            width: 250,
            height: 250,
            fadeInDuration: Duration(milliseconds: 200),
          ),
          Container(
            height: 70,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [
                _escribirEmail(),
                SizedBox(height: 20),
                _escribirContrasenya(),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [
                _botonLogin(context),
                SizedBox(height: 10),
                _botonGoogle()
              ],
            ),
          ),
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

  Widget _botonLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Color.fromRGBO(14, 100, 209, 1),
        onPressed: () {
          Map<String, dynamic> credenciales = {
            'nombreUsuario': _email,
            'contrasenya': _contrasenya,
          };
          TransitaProvider(credenciales);
          Navigator.pushNamed(context, 'home');
        },
        child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _botonGoogle() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 124, 122, 122),
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      height: 50, // Ancho igual al ancho completo disponible
      child: MaterialButton(
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Colors.white,
        onPressed: () => Navigator.pushNamed(context, 'home'),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage('assets/googleLogo.png'),
              width: 30,
            ),
            SizedBox(
              width: 48.79,
            ),
            Text(
              'Iniciar sesión con Google',
              style: TextStyle(color: const Color.fromARGB(255, 124, 122, 122)),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearCuenta() {
    return Center(
      child: RichText(
          text:
              TextSpan(text: '¿No tienes cuenta? Pulsa ', children: <TextSpan>[
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
}
