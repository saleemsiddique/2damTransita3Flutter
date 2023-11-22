import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/registro_pantalla.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/LoginService.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _InicioSesion createState() => _InicioSesion();
}

class _InicioSesion extends State<IniciarSesionPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _contrasenya = '';
  bool _mostrarContrasenya = false;
  LoginService loginForm = new LoginService();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _cambiarIdioma(context);
              },
              child: Text('Cambiar Idioma'),
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
      ),
    );
  }
void _cambiarIdioma(BuildContext context) {
  final currentLocale = Localizations.localeOf(context);
  final newLocale = currentLocale.languageCode == 'es' ? Locale('en', 'US') : Locale('es', 'ES');

  // Cambiar el idioma
  S.load(newLocale);
  
  // Forzar una reconstrucción de la pantalla
  setState(() {});
}

  TextFormField _escribirEmail() {
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
        if (value == null || value.length < 6) {
          return S.of(context).validatorPassword;
        }
        return null;
      },
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
        onPressed: () async {
          if (_formKey.currentState?.validate() == true) {
            Map<String, dynamic> credenciales = {
              'nombreUsuario': loginForm.email,
              'contrasenya': loginForm.password,
            };

            try {
              await loginForm.signInCliente(credenciales);
              Navigator.pushNamed(context, 'home');
              print("Ha llegado aqui");
            } catch (error) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(S.of(context).loginErrorTitle),
                  content: Text(S.of(context).loginErrorMessage),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(S.of(context).acceptIncorrectLoginData),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
        child: Text(S.of(context).loginButton, style: TextStyle(color: Colors.white)),
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
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Colors.white,
        onPressed: () => Navigator.pushNamed(context, 'home'),
        child: Row(
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage('assets/googleLogo.png'),
              width: 30,
            ),
            SizedBox(
              width: 48.79,
            ),
            Text(S.of(context).loginWithGoogleButton, style: TextStyle(color: const Color.fromARGB(255, 124, 122, 122))),
          
          ],
        ),
      ),
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
