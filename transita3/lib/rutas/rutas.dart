import 'package:flutter/material.dart';
import 'package:transita3/navigation_bar.dart';
import 'package:transita3/provider/IncidenciaProvider.dart';
import 'package:transita3/screens/creacion_inc_pantalla.dart';
import 'package:transita3/screens/detalle_inc_pantalla.dart';
import 'package:transita3/screens/gestion_inc_pantalla.dart';
import 'package:transita3/screens/inicio_sesion_pantalla.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/screens/registro_pantalla.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => IniciarSesionPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'home': (BuildContext context) => BottomNavigationBarProvider(),
    'mapa': (BuildContext context) => Mapa_pantalla(),
    'gestionincidencia': (BuildContext context) => GestionIncidenciasPage(),
    'creacionincidencia': (BuildContext context) => CreacionIncidenciasPage(),
    'detalleincidencia': (BuildContext context) => detalle_incidencias(),
  };
}