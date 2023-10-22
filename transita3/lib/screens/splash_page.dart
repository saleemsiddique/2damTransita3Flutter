import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, 
      body: Container(
        color: Colors.black, 
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
                  'assets/transitaLogo.png',
                  width: 150, 
                  height: 150, 
                ),
              ),
              
              SizedBox(height: 300), 
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
