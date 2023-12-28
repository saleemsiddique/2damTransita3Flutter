import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/services/LoginService.dart';
import '../models/models.dart';
import 'package:transita3/screens/perfil_pantalla.dart';

class OpenRouteService extends ChangeNotifier {
  static getRuta(String latlng1, String latLng2) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('rutas/start/$latlng1/end/$latLng2');

      // Check if the response is successful
      if (jsonData != null) {
        final dynamic jsonResponse = json.decode(jsonData);

        // Check if the response is a map
        if (jsonResponse is Map<String, dynamic>) {
          print(jsonResponse);
        } else {
          // Handle the case when the response is not a map (probably an error)
          print("Error: Unexpected response format");
          print(jsonResponse);
        }
      } else {
        // Handle the case when jsonData is null (error in getting data)
        print("Error: Unable to retrieve JSON data");
      }
    }
  }
}

