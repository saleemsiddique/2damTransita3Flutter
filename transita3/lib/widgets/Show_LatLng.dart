import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/widgets.dart';

void showLatLngBottomSheet(BuildContext context, LatLng latLng) async {
  final puntosService = Provider.of<PuntoService>(context, listen: false);

  Punto punto = await puntosService.buscarPuntoPorCoordenadasYCliente(
      latLng.latitude, latLng.longitude, LoginService.cliente.id);

  bool isStarFilled = punto != Punto.empty();

  Mapa_pantalla.isBottomSheetOpen = true;
  // ignore: use_build_context_synchronously
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
                SizedBox(
                    width:
                        10), // Ajusta el espacio entre la información y la estrella
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
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
                            await puntosService.postPuntoConFavorito(puntoData);
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
                      },
                      child: Icon(
                        size: 35,
                        isStarFilled ? Icons.star : Icons.star_border,
                        color: Colors.yellow, // Cambia el color si lo deseas
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
}
