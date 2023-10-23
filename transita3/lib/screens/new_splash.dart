import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transita3/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage())));
    return Scaffold(
      appBar: null,
      body: Container(
        color: Color.fromRGBO(25, 25, 25, 1),
        child: Center(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/transitaPng.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 100),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logo2.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 250),
              Text('la via accesible', style: TextStyle(color: Colors.white, fontSize: 40)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
