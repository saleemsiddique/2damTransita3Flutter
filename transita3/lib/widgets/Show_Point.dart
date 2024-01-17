import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/widgets.dart';

void showPointDetailsBottomSheet(BuildContext context, Punto punto) async {
  final puntosService = Provider.of<PuntoService>(context, listen: false);

  Mapa_pantalla.isBottomSheetOpen = true;
  Punto puntoN = await puntosService.buscarPuntoPorCoordenadasYCliente(
      punto.latitud, punto.longitud, LoginService.cliente.id);

  bool isStarFilled = puntoN != Punto.empty();

  // ignore: use_build_context_synchronously
  showBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showImagePunto(punto),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descripción: ${punto.descripcion}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Tipo: ${punto.tipoPunto}'),
                            Text('Latitud: ${punto.latitud}'),
                            Text('Longitud: ${punto.longitud}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (isStarFilled) {
                              // Aquí llamas a la función para quitar el punto de favoritos
                              await puntosService.removeFavorito(
                                  punto.id, LoginService.cliente.id);
                              isStarFilled = false;
                            } else {
                              await puntosService.agregarClienteAlPunto(
                                  punto.id, LoginService.cliente.id);
                              isStarFilled = true;
                            }
                            await puntosService
                                .getPuntosByIdCliente(LoginService.cliente.id);
                            setState(() {});
                          },
                          child: Icon(
                            size: 40,
                            isStarFilled ? Icons.star : Icons.star_border,
                            color:
                                Colors.yellow, // Cambia el color si lo deseas
                          ),
                        ),
                        botonAgregar(context, 'creacionincidencia', punto, 60,
                            60, punto.latitud, punto.longitud),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  ).closed.whenComplete(() {
    Mapa_pantalla.isBottomSheetOpen = false;
  });
}
