import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class TimerService extends ChangeNotifier {
  Location location = Location();
  LatLng currentLocation = LatLng(0, 0);
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
    double x1 = point1.latitude;
    double y1 = point1.longitude;

    double x2 = point2.latitude;
    double y2 = point2.longitude;

    distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
    print("la distancia es $distance");
    if (distance < 0.0002) {
      print("RUTA STOPPED");
      stopRuta(context);
    }
    notifyListeners();
  }

  void startTimer(BuildContext context, LatLng? destino) {
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

  void startRuta() {
    isRutaActive = true;
    notifyListeners();
  }

  void stopRuta(BuildContext context) {
    isRutaActive = false;
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
    notifyListeners();
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
