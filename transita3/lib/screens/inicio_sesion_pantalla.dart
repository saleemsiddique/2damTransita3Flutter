import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/recupera_contrasenya_pantalla.dart';
import 'package:transita3/screens/registro_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/Error_TokenExpired.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _InicioSesion createState() => _InicioSesion();
}

class _InicioSesion extends State<IniciarSesionPage> {
  final _formKey = GlobalKey<FormState>();
  bool _mostrarContrasenya = false;
  late String _selectedLanguage = 'EN';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    _cambiarIdioma(context, newValue!);
                  },
                  items: ['EN', 'ES', 'VAL'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
              height: 40,
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
                  _botonOlvidarContrasena(),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            _crearCuenta()
          ],
        ),
      ),
    );
  }

  void _cambiarIdioma(BuildContext context, String idioma) {
    Locale idiomaLoad;
    if (idioma == 'ES') {
      idiomaLoad = Locale('es', 'ES');
    } else if (idioma == 'EN') {
      idiomaLoad = Locale('en', 'US');
    } else {
      idiomaLoad = Locale('val', 'VAl');
    }

    S.load(idiomaLoad);
    setState(() {
      _selectedLanguage = idioma;
    });
  }

  TextFormField _escribirEmail() {
    final loginForm = Provider.of<LoginService>(context, listen: false);

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: S.of(context).email,
        labelText: S.of(context).email,
        suffixIcon: Icon(Icons.alternate_email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onChanged: (value) => loginForm.email = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).enterEmailPlease;
        }
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);

        return regExp.hasMatch(value) ? null : S.of(context).validatorEmail;
      },
    );
  }

  TextFormField _escribirContrasenya() {
    final loginForm = Provider.of<LoginService>(context, listen: false);

    return TextFormField(
      decoration: InputDecoration(
        hintText: S.of(context).password,
        labelText: S.of(context).password,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _mostrarContrasenya = !_mostrarContrasenya;
            });
          },
          child: Icon(
            _mostrarContrasenya ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      obscureText: !_mostrarContrasenya,
      onChanged: (value) => loginForm.password = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.length < 6 || value.isEmpty) {
          return S.of(context).validatorPassword;
        }
        return null;
      },
    );
  }

  Widget _botonLogin(BuildContext context) {
    final loginForm = Provider.of<LoginService>(context, listen: false);

    final puntosService = Provider.of<PuntoService>(context, listen: true);

    return Container(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Color.fromRGBO(14, 100, 209, 1),
        onPressed: () async {
          if (_formKey.currentState?.validate() == true) {
            Map<String, dynamic> credenciales = {
              'nombreUsuario': loginForm.email,
              'contrasenya': loginForm.password,
            };

            try {
              await loginForm.signInCliente(credenciales);
              print("Pass: ${loginForm.password}");

              puntosService.getPuntosForMap();

              puntosService.getPuntosByIdCliente(LoginService.cliente.id);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('home', (route) => false);
            } catch (error) {
              errorTokenExpired(context);
            }
          }
        },
        child: Text(S.of(context).loginButton,
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _botonOlvidarContrasena() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OlvidarContrasenyaScreen(),
          ),
        );
      },
      child: Text(S.of(context).Didyouforgetyourpassword),
    );
  }

  Widget _crearCuenta() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: ((S.of(context).createAccountText)),
          children: <TextSpan>[
            TextSpan(
              text: ((S.of(context).createAccountLink)),
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
                },
            ),
            TextSpan(text: ((S.of(context).createAccountLinkText)))
          ],
        ),
      ),
    );
  }
}
