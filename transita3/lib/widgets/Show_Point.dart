import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/Error_TokenExpired.dart';
import 'package:transita3/widgets/widgets.dart';

void showPointDetailsBottomSheet(BuildContext context, Punto punto) async {
  final puntosService = Provider.of<PuntoService>(context, listen: false);

  try {
    Mapa_pantalla.isBottomSheetOpen = true;
    Punto puntoN = await puntosService.buscarPuntoPorCoordenadasYCliente(
        punto.latitud, punto.longitud, LoginService.cliente.id);

    bool isStarFilled = puntoN != Punto.empty();

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
                                S.of(context).description + ': ${punto.descripcion}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                               S.of(context).accessibilityDegree + ': ${punto.accesibilidadPunto}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                S.of(context).latitude + ': ${punto.latitud.toStringAsFixed(5)}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                S.of(context).longitude + ': ${punto.longitud.toStringAsFixed(5)}',
                                style: TextStyle(fontSize: 14),
                              ),
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
                              try {
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
                                await puntosService.getPuntosByIdCliente(
                                    LoginService.cliente.id);
                                setState(() {});
                              } catch (error) {
                                // Mostrar un aviso en caso de error
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text(S.of(context).sessionExpiredError),
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
                              size: 40,
                              isStarFilled ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
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
  } catch (error) {
    // Mostrar un aviso en caso de error
    errorTokenExpired(context);
  }
}
