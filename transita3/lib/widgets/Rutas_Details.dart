import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/services/TimerService.dart';

void rutasDetailsSheet(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      PuntoSeleccionadoWidget(
                        isSelected: Mapa_pantalla.primerPuntoSeleccionado,
                        onTap: () {
                          setState(() {
                            Mapa_pantalla.primerPuntoSeleccionado = true;
                            Mapa_pantalla.segundoPuntoSeleccionado = false;
                            Mapa_pantalla.selectedPoint1Text =
                                '${mapaPantallaNotifier.latLngOrigen.latitude},${mapaPantallaNotifier.latLngOrigen.longitude}';
                          });
                        },
                        selectedPointText: Mapa_pantalla.selectedPoint1Text,
                      ),
                      SizedBox(height: 16.0),
                      PuntoSeleccionadoWidget(
                        isSelected: Mapa_pantalla.segundoPuntoSeleccionado,
                        onTap: () {
                          setState(() {
                            Mapa_pantalla.primerPuntoSeleccionado = false;
                            Mapa_pantalla.segundoPuntoSeleccionado = true;
                            Mapa_pantalla.selectedPoint2Text =
                                '${mapaPantallaNotifier.latLngDestino.latitude},${mapaPantallaNotifier.latLngDestino.longitude}';
                          });
                        },
                        selectedPointText: Mapa_pantalla.selectedPoint2Text,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          limpiarRuta(openRouteService, mapaPantallaNotifier,
                              setState, timerService, context),
                          SizedBox(
                            width: 8,
                          ),
                          crearRuta(openRouteService, mapaPantallaNotifier,
                              timerService, context),
                          SizedBox(
                            width: 8,
                          ),
                          fijarRuta(context)
                        ],
                      )
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

GestureDetector fijarRuta(BuildContext context) {
  return GestureDetector(
    onTap: !MapaPantallaNotifier.routeChange
        ? () {
            Navigator.pop(context);
          }
        : null, // Si no está habilitado, onTap es null
    child: Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: !MapaPantallaNotifier.routeChange
            ? Colors.blue
            : Colors.grey, // Color según estado
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        S.of(context).Attachroute,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

GestureDetector crearRuta(
    OpenRouteService openRouteService,
    MapaPantallaNotifier mapaPantallaNotifier,
    TimerService timerService,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (Mapa_pantalla.selectedPoint2Text ==
          S.of(context).selectDestinationOnMapMessage) {
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
      child: Text(
        S.of(context).createRoute,
        style: TextStyle(color: Colors.white),
      ),
    ),
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
      mapaPantallaNotifier.updateLatLngDestino(LatLng(0, 0));
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
        color: Colors.blue, // Example color for the button
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        S.of(context).clearRouteMessage,
        style: TextStyle(color: Colors.white),
      ),
    ),
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
