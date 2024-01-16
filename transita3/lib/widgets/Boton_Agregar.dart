import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transita3/models/models.dart';

import 'package:transita3/services/PuntoService.dart';

Widget botonAgregar(BuildContext context, String routeName, Punto? punto,
    double width, double height, double? lat, double? lon) {
  print(routeName);
  print(lat);
  print(lon);
  if ((punto == null || punto == Punto.empty()) &&
      routeName == 'creacionincidencia') {
    print("Entro en punto null y gestion incidencias");

    if (lat != null && lon != null) {
      PuntoService.getPuntoByCoordenadas(lat, lon);
      if (PuntoService.puntoSelected != null &&
          PuntoService.puntoSelected!.latitud != 0.0 &&
          PuntoService.puntoSelected!.longitud != 0) {
        print("Entro en puntoselected not null");
        return GestureDetector(
          onTap: () async {
            await PuntoService.getPuntos();
            Navigator.pushNamed(context, routeName,
                arguments: PuntoService.puntoSelected);
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
        PuntoService.getPuntoByCoordenadas(lat!, lon!);
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
        punto = PuntoService.puntoSelected;
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
