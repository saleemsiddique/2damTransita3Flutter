import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';

import 'package:transita3/services/PuntoService.dart';

Widget botonAgregar(BuildContext context, String routeName, Punto? punto,
    double width, double height, double? lat, double? lon) {
  final puntosService = Provider.of<PuntoService>(context, listen: false);

  print(routeName);
  print(lat);
  print(lon);
  if ((punto == null || punto == Punto.empty()) &&
      routeName == 'creacionincidencia') {
    print("Entro en punto null y gestion incidencias");

    if (lat != null && lon != null) {
      puntosService.getPuntoByCoordenadas(lat, lon);
      if (puntosService.puntoSelected != null &&
          puntosService.puntoSelected!.latitud != 0.0 &&
          puntosService.puntoSelected!.longitud != 0) {
        print("Entro en puntoselected not null");
        return GestureDetector(
          onTap: () async {
            await puntosService.getPuntos();
            Navigator.pushNamed(context, routeName,
                arguments: puntosService.puntoSelected);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/boton.png'),
              ),
              borderRadius: BorderRadius.circular(0.50),
            ),
            width: width,
            height: height,
          ),
        );
      }
    } else {
      print("Latitud o longitud es null");
    }
    print("Entro en puntoselected null");
    return GestureDetector(
      onTap: () {
        puntosService.getPuntoByCoordenadas(lat!, lon!);
        Navigator.pushNamed(context, routeName,
            arguments: {'lat': lat, 'lon': lon});
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/boton.png'),
          ),
          borderRadius: BorderRadius.circular(0.50),
        ),
        width: width,
        height: height,
      ),
    );
  } else {
    print("No entro en punto null y gestion incidencias");
    return GestureDetector(
      onTap: () async {
        punto = puntosService.puntoSelected;
        Navigator.pushNamed(context, routeName, arguments: punto);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/boton.png'),
          ),
          borderRadius: BorderRadius.circular(0.50),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
