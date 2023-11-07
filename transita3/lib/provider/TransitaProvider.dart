import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/helpers/debouncer.dart';

class TransitaProvider extends ChangeNotifier {
  //Preguntar si la ApiKey es el token.
  String _apiKey = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcnVlYmEwQGVtYWlsLmNvbSIsImlhdCI6MTY5OTM0Mjc3OCwiZXhwIjoxNjk5NDI5MTc4fQ.FXp5XYVa49X5uxQ3CwW7Xuwtso9C_qDuYNqHZzaPEjhblTzsekZ1yE0mnEMWhb2mYODRDvmL_TvxOAu18MX4Dw';
  String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';

  static List<Incidencia> incidenciasDeUsuario = [];

  int _popularPage = 0;
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      this._suggestionStreamController.stream;

  TransitaProvider() {
    print('TransitaProvider inicializando');
    this.getIncidencias();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(
      _baseUrl,
      endpoint
    );
    Map<String,String> headers = {
      'Authorization': _apiKey,
      };
    final response = await http.get(url, headers: headers);
    print(response.body);
    return response.body;
  }

// Falta el loggin funcionando para devolver el id del cliente
  getIncidencias() async {
    final jsonData = await this._getJsonData('incidencias/clienteid/1');
    
    final List<dynamic> jsonList = json.decode(jsonData);

    incidenciasDeUsuario = Incidencia.fromJsonList(jsonList);
    print("Estas son las incidencias: ${incidenciasDeUsuario.toString()}");
    notifyListeners();
  }
}
