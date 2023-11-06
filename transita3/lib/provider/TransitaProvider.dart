import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:transita3/models/incidencia.dart';
import 'package:transita3/helpers/debouncer.dart';

class MoviesProvider extends ChangeNotifier {
  //Preguntar si la ApiKey es el token.
  String _apiKey = 'token';
  String _baseUrl = 'localhost:8083/';
  String _language = 'es-ES';

  List<Incidencia> incidenciasDeUsuario = [];

  int _popularPage = 0;
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    print('MoviesProvider inicializando');
    this.getIncidencias();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(
      _baseUrl,
      endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'},
    );
    final response = await http.get(url);
    return response.body;
  }

// Falta el loggin funcionando para devolver el id del cliente
  getIncidencias() async {
    final jsonData = await this._getJsonData('incidencias/clienteid/{faltaIDloggin}');
    
    final List<dynamic> jsonList = json.decode(jsonData);

    incidenciasDeUsuario = Incidencia.fromJsonList(jsonList);
    notifyListeners();
  }
}
