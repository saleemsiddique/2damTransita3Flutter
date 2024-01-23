import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/widgets.dart';

void showLatLngBottomSheet(BuildContext context, LatLng latLng) async {
  final puntosService = Provider.of<PuntoService>(context, listen: false);

  try {
    Punto punto = await puntosService.buscarPuntoPorCoordenadasYCliente(
        latLng.latitude, latLng.longitude, LoginService.cliente.id);

    bool isStarFilled = punto != Punto.empty();

    Mapa_pantalla.isBottomSheetOpen = true;
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 80,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lat: ${latLng.latitude}'),
                      Text('Lon: ${latLng.longitude}'),
                    ],
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            if (!isStarFilled) {
                              if (punto != Punto.empty()) {
                                await puntosService.agregarClienteAlPunto(
                                    punto.id, LoginService.cliente.id);
                                isStarFilled = true;
                              } else {
                                Map<String, dynamic> puntoData = {
                                  'descripcion': '',
                                  'tipoPunto': 'LUGAR',
                                  'foto': '',
                                  'latitud': latLng.latitude,
                                  'longitud': latLng.longitude,
                                  'accesibilidadPunto': 'ACCESIBLE',
                                  'visibilidadPunto': 'GLOBAL'
                                };
                                await puntosService
                                    .postPuntoConFavorito(puntoData);
                                punto = await puntosService
                                    .buscarPuntoPorCoordenadasYCliente(
                                        latLng.latitude,
                                        latLng.longitude,
                                        LoginService.cliente.id);
                                isStarFilled = punto != Punto.empty();
                              }
                            } else {
                              await puntosService.removeFavorito(
                                  punto.id, LoginService.cliente.id);
                              isStarFilled = false;
                            }
                            await puntosService
                                .getPuntosByIdCliente(LoginService.cliente.id);
                            setState(() {});
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
                                            .pushNamedAndRemoveUntil(
                                                '/', (route) => false);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Icon(
                          size: 35,
                          isStarFilled ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                        ),
                      ),
                      botonAgregar(context, 'creacionincidencia', null, 70, 70,
                          latLng.latitude, latLng.longitude),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).closed.whenComplete(() {
      Mapa_pantalla.isBottomSheetOpen = false;
    });
  } catch (error) {
    // Mostrar un aviso en caso de error
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content:
              Text('Ha ocurrido un error al buscar el punto por coordenadas.'),
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
  }
}
