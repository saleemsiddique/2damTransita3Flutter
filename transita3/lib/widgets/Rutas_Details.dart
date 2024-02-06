import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';

void rutasDetailsSheet(BuildContext context) {
  Mapa_pantalla.selectedPoint1Text = S.of(context).currentLocation;
  Mapa_pantalla.selectedPoint2Text = S.of(context).selectDestinationOnMap;
  Mapa_pantalla.isBottomSheetOpen = true;
  final openRouteService =
      Provider.of<OpenRouteService>(context, listen: false);
  final timerService = Provider.of<TimerService>(context, listen: false);
  showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer<MapaPantallaNotifier>(
              builder: (context, mapaPantallaNotifier, child) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    openRouteService.clearRuta();
                                    timerService.stopRuta(context, false);
                                    mapaPantallaNotifier
                                        .updateLatLngOrigen(LatLng(0, 0));
                                    setState(
                                      () {
                                        Mapa_pantalla.selectedPoint1Text =
                                            S.of(context).currentLocation;
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.my_location,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 22),
                                PuntoSeleccionadoWidget(
                                  isSelected:
                                      Mapa_pantalla.primerPuntoSeleccionado,
                                  onTap: () {
                                    setState(() {
                                      Mapa_pantalla.primerPuntoSeleccionado =
                                          true;
                                      Mapa_pantalla.segundoPuntoSeleccionado =
                                          false;
                                      Mapa_pantalla.selectedPoint1Text =
                                          '${mapaPantallaNotifier.latLngOrigen.latitude.toStringAsFixed(4)},${mapaPantallaNotifier.latLngOrigen.longitude.toStringAsFixed(4)}';
                                    });
                                  },
                                  selectedPointText:
                                      Mapa_pantalla.selectedPoint1Text,
                                ),
                              ],
                            ),
                            limpiarRuta(openRouteService, mapaPantallaNotifier,
                                setState, timerService, context),
                          ]),
                          SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 8),
                          PuntoSeleccionadoWidget(
                            isSelected: Mapa_pantalla.segundoPuntoSeleccionado,
                            onTap: () {
                              setState(() {
                                Mapa_pantalla.primerPuntoSeleccionado = false;
                                Mapa_pantalla.segundoPuntoSeleccionado = true;
                                Mapa_pantalla.selectedPoint2Text =
                                    '${mapaPantallaNotifier.latLngDestino.latitude.toStringAsFixed(4)},${mapaPantallaNotifier.latLngDestino.longitude.toStringAsFixed(4)}';
                              });
                            },
                            selectedPointText: Mapa_pantalla.selectedPoint2Text,
                          ),
                          crearRuta(openRouteService, mapaPantallaNotifier,
                              timerService, context),
                        ],
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

GestureDetector crearRuta(
    OpenRouteService openRouteService,
    MapaPantallaNotifier mapaPantallaNotifier,
    TimerService timerService,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      print(Mapa_pantalla.selectedPoint2Text);
      if (Mapa_pantalla.selectedPoint2Text ==
          S.of(context).selectDestinationOnMap) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).invalidDestination),
          ),
        );
      } else {
        openRouteService.getRuta(Mapa_pantalla.selectedPoint1Text,
            Mapa_pantalla.selectedPoint2Text, context);
        mapaPantallaNotifier.updateRouteChange(false);
        timerService.startRuta(mapaPantallaNotifier.latLngDestino);
        if (!timerService.timer.isActive) {
          timerService.startTimer(context);
        }
      }
    },
    child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.blue, // Example color for the button
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(Icons.send)),
  );
}

GestureDetector limpiarRuta(
    OpenRouteService openRouteService,
    MapaPantallaNotifier mapaPantallaNotifier,
    StateSetter setState,
    TimerService timerService,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      openRouteService.clearRuta();
      mapaPantallaNotifier.updateLatLngOrigen(LatLng(0, 0));
      timerService.stopRuta(context, false);
      setState(
        () {
          Mapa_pantalla.selectedPoint1Text = S.of(context).currentLocation;
          Mapa_pantalla.selectedPoint2Text =
              S.of(context).selectDestinationOnMap;
        },
      );
    },
    child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.red, // Example color for the button
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.clear)),
  );
}

class PuntoSeleccionadoWidget extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String selectedPointText;

  PuntoSeleccionadoWidget({
    required this.isSelected,
    required this.onTap,
    required this.selectedPointText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(selectedPointText),
      ),
    );
  }
}
