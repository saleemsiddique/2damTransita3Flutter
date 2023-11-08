import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/helpers/debouncer.dart';

import '../models/LoggedCliente.dart';

class TransitaProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';

  static LoggedCliente cliente = new LoggedCliente.empty();
  static List<Incidencia> incidenciasDeUsuario = [];


  int _popularPage = 0;
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      this._suggestionStreamController.stream;

  TransitaProvider(Map<String, dynamic> data) {
    print('TransitaProvider inicializando');
    print(_apiKey);

  signInCliente(data).then((_) {
    this.getIncidencias();
  });
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': _apiKey,
    };
    final response = await http.get(url, headers: headers);
    print(response.body);
    return response.body;
  }

  Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': _apiKey,
      'Content-Type':
          'application/json', 
    };

    String jsonData = json.encode(data);

    final response = await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      print('Solicitud exitosa');
      print(response.body);
      return response.body;
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

  getIncidencias() async {
    final jsonData = await _getJsonData('incidencias/clienteid/${cliente.id}');

    final List<dynamic> jsonList = json.decode(jsonData);

    incidenciasDeUsuario = Incidencia.fromJsonList(jsonList);
    print("Estas son las incidencias: ${incidenciasDeUsuario.toString()}");
    notifyListeners();
  }

  signInCliente(Map<String, dynamic> data) async {
    final jsonData = await postJsonData('api/auth/signin/cliente', data);

    cliente = LoggedCliente.fromJson(json.decode(jsonData));
    _apiKey = '${cliente.type} ${cliente.token}';
    print(_apiKey);
    print("Este es el usuario creado: $cliente");
    notifyListeners();
}

}
