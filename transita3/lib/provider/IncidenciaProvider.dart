import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/LoginFormProvider.dart';

import '../models/LoggedCliente.dart';

class IncidenciaProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';

  static List<Incidencia> incidenciasDeUsuario = [];


  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      this._suggestionStreamController.stream;

  IncidenciaProvider() {
    print('IncidenciaProvider inicializando');
    print(_apiKey);

    this.getIncidencias();
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

getIncidencias() async {
  final cliente = LoginFormProvider.cliente;
  _apiKey = '${cliente.type} ${cliente.token}';
  print('id de clienteIncidencia: ${cliente.id}');
  if (cliente != null) {
    final jsonData = await _getJsonData('incidencias/clienteid/${cliente.id}');

    final List<dynamic> jsonList = json.decode(jsonData);

    incidenciasDeUsuario = Incidencia.fromJsonList(jsonList);
    print("Estas son las incidencias: ${incidenciasDeUsuario.toString()}");
    notifyListeners();
  }
}

}
