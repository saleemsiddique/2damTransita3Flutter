import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';

void rutasDetailsSheet(BuildContext context) {
  Mapa_pantalla.isBottomSheetOpen = true;
  final openRouteService =
      Provider.of<OpenRouteService>(context, listen: false);
  showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer<MapaPantallaNotifier>(
              builder: (context, mapaPantallaNotifier, child) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Mapa_pantalla.primerPuntoSeleccionado = true;
                            Mapa_pantalla.segundoPuntoSeleccionado = false;
                            Mapa_pantalla.selectedPoint1Text =
                                '${mapaPantallaNotifier.latLngOrigen.latitude},${mapaPantallaNotifier.latLngOrigen.longitude}';
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Mapa_pantalla.primerPuntoSeleccionado
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(Mapa_pantalla.selectedPoint1Text),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Mapa_pantalla.primerPuntoSeleccionado = false;
                            Mapa_pantalla.segundoPuntoSeleccionado = true;
                            Mapa_pantalla.selectedPoint2Text =
                                '${mapaPantallaNotifier.latLngDestino.latitude},${mapaPantallaNotifier.latLngDestino.longitude}';
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Mapa_pantalla.segundoPuntoSeleccionado
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(Mapa_pantalla.selectedPoint2Text),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () {
                          print("vale");
                          openRouteService.getRuta(
                              Mapa_pantalla.selectedPoint1Text,
                              Mapa_pantalla.selectedPoint2Text);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.blue, // Example color for the button
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Crear ruta',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }).closed.whenComplete(() {
    Mapa_pantalla.isBottomSheetOpen = false;
    Mapa_pantalla.primerPuntoSeleccionado = false;
    Mapa_pantalla.segundoPuntoSeleccionado = false;
  });
}
