import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/services/LoginService.dart';

class PuntoService extends ChangeNotifier {
  static List<Punto> puntos = [];
  static Punto punto = Punto.empty();

  PuntoService() {
    debugPrint('PuntoService inicializando');
    getPuntos();
    print(puntos);
  }

  getPuntos() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('puntos');

      final List<dynamic> jsonList = json.decode(jsonData);

      puntos = jsonList.map((json) => Punto.fromJson(json)).toList();
      print("Estos son los puntos: ${puntos.toString()}");
      notifyListeners();
    }
  }

  static getPunto(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData =
          await TransitaProvider.getJsonData('puntos/id/$id');

      final dynamic jsonPunto = json.decode(jsonData);

      punto = Punto.fromJson(jsonPunto);
      print("Este es el punto: ${punto.toString()}");
    }
  }
}
