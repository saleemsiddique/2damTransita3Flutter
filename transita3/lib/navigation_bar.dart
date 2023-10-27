import 'package:flutter/material.dart';
import 'package:transita3/screens/creacion_incidencias.dart';
import 'package:transita3/screens/gestion_incidencias.dart';
import 'package:transita3/screens/inicio_sesion.dart';
import 'package:transita3/screens/registro.dart';

class BottomNavigationBarProvider extends StatefulWidget {
  const BottomNavigationBarProvider({super.key});

  @override
  State<BottomNavigationBarProvider> createState() => _BottomNavigationBarProviderState();
}

class _BottomNavigationBarProviderState extends State<BottomNavigationBarProvider> {
  int _selectedIndex = 0;
  final screens = [
    IniciarSesionPage(),
    RegistroPage(),
    GestionIncidenciasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
