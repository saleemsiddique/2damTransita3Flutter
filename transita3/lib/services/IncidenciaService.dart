import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/services/LoginService.dart';
import 'package:transita3/provider/TransitaProvider.dart';

class IncidenciaService extends ChangeNotifier {
  static List<Incidencia> incidenciasDeUsuario = [];
  static Incidencia incidencia = Incidencia.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      this._suggestionStreamController.stream;

  IncidenciaService() {
    debugPrint('IncidenciaProvider inicializando');
    debugPrint(TransitaProvider.apiKey);

    getIncidencias();
  }

  getIncidencias() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clienteIncidencia: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData(
          'incidencias/clienteid/${cliente.id}');

      final List<dynamic> jsonList = json.decode(jsonData);

      incidenciasDeUsuario = Incidencia.fromJsonList(jsonList);
      print("Estas son las incidencias: ${incidenciasDeUsuario.toString()}");
      notifyListeners();
    }
  }

  getIncidencia(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clienteIncidencia: ${cliente.id}');
    if (cliente != null) {
      final jsonData =
          await TransitaProvider.getJsonData('incidencia/id/${id}');
      incidencia = Incidencia.fromRawJson(jsonData);
      print("Incidencia recibida: ${incidencia}");
      notifyListeners();
    }
  }
}
