import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/services/LoginService.dart';
import '../models/models.dart';
import 'package:transita3/screens/perfil_pantalla.dart';

class OpenRouteService extends ChangeNotifier {
  static List<List<double>> routeCoordinates = [];

  Future<void> getRuta(String latlng1, String latLng2) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';

    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('rutas/start/$latlng1/end/$latLng2');

      // Check if the response is successful
      if (jsonData != null) {
        // Parse the JSON response
        List<dynamic> jsonResponse = json.decode(jsonData);
        print("Json Response: $jsonResponse");
        // Explicitly cast the dynamic list to List<List<double>>
        List<List<double>> coordinates = List<List<double>>.from(
            jsonResponse.map((list) => List<double>.from(list)));
        print("Coordinates: $coordinates");
        // Store the coordinates for further use
        routeCoordinates = coordinates;
        MapaPantallaNotifier.routeChange = false;
        // Notify listeners about the change
        notifyListeners();
      } else {
        // Handle the case when jsonData is null (error in getting data)
        print("Error: Unable to retrieve JSON data");
      }
    }
  }
}

