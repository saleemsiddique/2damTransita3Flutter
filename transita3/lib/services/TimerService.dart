import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/OpenRouteService.dart';

class TimerService extends ChangeNotifier {
  Location location = Location();
  LatLng currentLocation = LatLng(0, 0);
  LatLng? destino;
  late double distance;
  Timer timer = Timer(Duration(seconds: 0), () {});
  int cont = 0;
  bool isRutaActive = false;

  Future<void> _getLocation() async {
    try {
      var userLocation = await location.getLocation();
      currentLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
      notifyListeners();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void calculateDistance(LatLng point1, LatLng point2, BuildContext context) {
    final mapaPantallaNotifier =
        Provider.of<MapaPantallaNotifier>(context, listen: false);
    final openRouteService =
        Provider.of<OpenRouteService>(context, listen: false);

    double x1 = point1.latitude;
    double y1 = point1.longitude;

    double x2 = point2.latitude;
    double y2 = point2.longitude;

    distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
    print("la distancia es $distance");
    if (distance < 0.0002) {
      print("RUTA STOPPED");
      openRouteService.clearRuta();
      mapaPantallaNotifier.updateLatLngDestino(LatLng(0, 0));
      stopRuta(context, true);

      Mapa_pantalla.selectedPoint1Text = 'Ubicacion Actual';
      Mapa_pantalla.selectedPoint2Text = 'Seleccionar un destino en el mapa';
    }
    notifyListeners();
  }

  void startTimer(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _getLocation();
      cont += 2;

      if (isRutaActive) {
        if (currentLocation != null) {
          if (destino != null) {
            calculateDistance(currentLocation, destino!, context);
          }
        }
      }
      print(cont);
    });
    notifyListeners();
  }

  void startRuta(LatLng proximoDestino) {
    destino = proximoDestino;
    isRutaActive = true;
    notifyListeners();
  }

  void stopRuta(BuildContext context, bool hasLlegado) {
    isRutaActive = false;
    destino = null;
    if (hasLlegado) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Destino alcanzado!'),
            content: Text('¡Has llegado a tu destino!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el AlertDialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    notifyListeners();
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
