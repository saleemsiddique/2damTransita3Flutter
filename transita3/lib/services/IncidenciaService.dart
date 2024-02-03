import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/provider/TransitaProvider.dart';

class IncidenciaService extends ChangeNotifier {
  List<Incidencia> incidenciasDeUsuario = [];
  Incidencia incidencia = Incidencia.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Incidencia>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Incidencia>> get suggesionStream =>
      _suggestionStreamController.stream;

Future<void> getIncidencias() async {
  final cliente = LoginService.cliente;
  TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
  print('id de clienteIncidencia: ${cliente.id}');
  
  if (cliente != null) {
    final jsonData = await TransitaProvider.getJsonData(
        'incidencias/clienteid/${cliente.id}');

    final List<dynamic> jsonList = json.decode(jsonData);

    List<Incidencia> newIncidencias = Incidencia.fromJsonList(jsonList);

    if (!listEquals(incidenciasDeUsuario, newIncidencias)) {
      incidenciasDeUsuario = newIncidencias;
      print("Estas son las incidencias: $incidenciasDeUsuario");
      notifyListeners();
    }
  }
}


  Future<void> getIncidencia(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clienteIncidencia: ${cliente.id}');
    if (cliente != null) {
      final jsonData =
          await TransitaProvider.getJsonData('incidencia/id/${id}');
      incidencia = Incidencia.fromRawJson(jsonData);
      print("Incidencia recibida: $incidencia");
      notifyListeners();
    }
  }

    Future<Incidencia> getUltimaIncidencia(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clienteIncidencia: ${cliente.id}');
    if (cliente != null) {
      final jsonData =
          await TransitaProvider.getJsonData('incidencia/punto/${id}');
      return Incidencia.fromRawJson(jsonData);
    }
    return Incidencia.empty();
  }

  Future<void> postIncidencia(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData('incidencia', data);
    print("INCIDENCIA CREADA");
    notifyListeners();
  }

  Future<void> deleteIncidencia(int id) async {
    try {
      final response =
          await TransitaProvider.deleteJsonData('incidencia/eliminar/$id');

      if (response.isNotEmpty) {
        print('Incidencia eliminada exitosamente');
        notifyListeners();
      } else {
        print('Error al eliminar la incidencia');
        throw Exception('Error al eliminar la incidencia');
      }
    } catch (error) {
      print('Error durante la solicitud: $error');
      throw Exception('Error durante la solicitud: $error');
    }
  }

  @override
  void dispose() {
    _suggestionStreamController.close();
    super.dispose();
  }
}
