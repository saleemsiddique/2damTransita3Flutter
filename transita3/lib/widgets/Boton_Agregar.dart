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

  if (routeName == 'home') {
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, routeName);
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

  try {
    if ((punto == null || punto == Punto.empty()) &&
        routeName == 'creacionincidencia') {
      print("Entro en punto null y gestion incidencias");

      if (lat != null && lon != null) {
        // Llamar a la función getPuntoByCoordenadas del servicio
        puntosService.getPuntoByCoordenadas(lat, lon);
        if (punto != null && punto.latitud != 0.0 && punto.longitud != 0) {
          print("Entro en puntoselected not null");
          return GestureDetector(
            onTap: () async {
              // Llamar a la función getPuntos del servicio
              await puntosService.getPuntos();
              Navigator.pushNamed(context, routeName,
                  arguments: {'lat': lat, 'lon': lon, 'punto': punto});
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
        onTap: () async {
          // Llamar a la función getPuntoByCoordenadas del servicio
          await puntosService.getPuntoByCoordenadas(lat!, lon!);
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
          Navigator.pushNamed(context, routeName, arguments: {
            'punto': punto,
            'lat': punto!.latitud,
            'lon': punto!.longitud,
          });
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
  } catch (error) {
    // Mostrar un aviso en caso de error
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error, esta sesion ha expirado.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    // Puedes retornar un contenedor vacío o un widget alternativo en caso de error
    return Container();
  }
}
