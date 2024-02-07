import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/services/LoginService.dart';

class PuntoService extends ChangeNotifier {
  List<Punto> puntos = [];
  List<Punto> puntosForMap = [];
  List<Punto> favsForMap = [];
  List<Punto> parkingForMap = [];
  Punto punto = Punto.empty();
  Punto puntoSelected = Punto.empty();
  Punto puntoNuevo = Punto.empty();

  Future<void> getPuntosForMap() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData(
          '/global-con-incidencias-aceptadas');

      final List<dynamic> jsonList = json.decode(jsonData);
      List<Punto> newPuntosForMap =
          jsonList.map((json) => Punto.fromJson(json)).toList();

      if (!listEquals(puntosForMap, newPuntosForMap)) {
        puntosForMap = newPuntosForMap;
        notifyListeners();
      }
    }
  }

  clearMap() {
    puntosForMap.clear();
    notifyListeners();
  }

  clearAccesiblesMap() {
    puntosForMap
        .removeWhere((punto) => punto.accesibilidadPunto == 'ACCESIBLE');
    notifyListeners();
  }

  clearIncidencesMap() {
    puntosForMap.removeWhere((punto) =>
        punto.accesibilidadPunto == 'NO_ACCESIBLE' ||
        punto.accesibilidadPunto == 'PARCIALMENTE_ACCESIBLE');
    notifyListeners();
  }

  clearFavsMap() {
    favsForMap.clear();
    notifyListeners();
  }

  clearParkingMap() {
    parkingForMap.clear();
    notifyListeners();
  }

  Future<void> getPuntosForMapFiltered() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData(
          '/puntos/accesibilidad/ACCESIBLE/visibilidad/GLOBAL');

      final List<dynamic> jsonList = json.decode(jsonData);
      List<Punto> newPuntosForMap =
          jsonList.map((json) => Punto.fromJson(json)).toList();

      if (!listEquals(puntosForMap, newPuntosForMap)) {
        puntosForMap = newPuntosForMap;
        notifyListeners();
      }
    }
  }

  Future<void> getPuntosParkingForMapFiltered() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('/puntos/tipo/2');
      final List<dynamic> jsonList = json.decode(jsonData);
      List<Punto> newPuntosForMap =
          jsonList.map((json) => Punto.fromJson(json)).toList();

      if (!listEquals(parkingForMap, newPuntosForMap)) {
        parkingForMap = newPuntosForMap;
        notifyListeners();
      }
    }
  }

  Future<void> getPuntos() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('puntos');

      final List<dynamic> jsonList = json.decode(jsonData);
      puntos = [];
      puntos = jsonList.map((json) => Punto.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> getPunto(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('puntos/id/$id');

      final dynamic jsonPunto = json.decode(jsonData);

      punto = Punto.fromJson(jsonPunto);
      print("Este es el punto: ${punto.toString()}");
      notifyListeners();
    }
  }

  Future<void> getPuntoByCoordenadas(double latitud, double longitud) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');

    if (cliente != null) {
      try {
        final jsonData = await TransitaProvider.getJsonData(
            'punto/coordenadas/$latitud/$longitud');

        final dynamic jsonPunto = json.decode(jsonData);

        puntoSelected = Punto.fromJson(jsonPunto);
        print("Este es el punto seleccionado: ${puntoSelected.toString()}");
        notifyListeners();
      } catch (error) {
        print("No se ha encontrado este punto");
        // You might want to handle the error or perform additional actions here.
      }
    } else {
      print("No se ha encontrado este punto");
    }
  }

  Future<void> postPunto(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData('puntos', data);
    puntoNuevo = Punto.fromRawJson(jsonData);
    print("puntoNuevo: $puntoNuevo");
    print("PUNTO CREADO");
    notifyListeners();
  }

  Future<void> postPuntoConFavorito(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData(
        'puntos/${LoginService.cliente.id}', data);
    puntoNuevo = Punto.fromRawJson(jsonData);
    print("puntoNuevo: $puntoNuevo");
    print("PUNTO CREADO CON FAVORITO");
    notifyListeners();
  }

  Future<void> getPuntosByIdCliente(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('favoritos/$id');
      final List<dynamic> jsonList = json.decode(jsonData);
      List<Punto> newFavsForMap =
          jsonList.map((json) => Punto.fromJson(json)).toList();

      if (!listEquals(favsForMap, newFavsForMap)) {
        favsForMap = newFavsForMap;
        notifyListeners();
      }
    }
  }

  Future<Punto> buscarPuntoPorCoordenadasYCliente(
      double latitud, double longitud, int idCliente) async {
    print("buscarPuntoPorCoordenadasYCliente");
    final cliente = LoginService.cliente;

    if (cliente != null) {
      try {
        TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
        print('lat: $latitud lon: $longitud');

        final jsonData = await TransitaProvider.getJsonData(
            'favoritos/$latitud/$longitud/$idCliente');
        final dynamic jsonPunto = json.decode(jsonData);

        Punto punto = Punto.fromJson(jsonPunto);
        print("El punto favorito escogido es $punto");

        notifyListeners();
        print(punto.toString());
        return punto;
      } catch (error) {}
    } else {
      print("No se ha encontrado este punto");
    }

    return Punto.empty();
  }

  Future<Punto> agregarClienteAlPunto(int puntoId, int clienteId) async {
    final jsonData =
        await TransitaProvider.putJsonData('favorito/$puntoId/$clienteId', {});
    final dynamic jsonPunto = json.decode(jsonData);
    Punto punto = Punto.fromJson(jsonPunto);
    print("Añadido a favorito");
    notifyListeners();
    return punto;
  }

  Future<Punto> removeFavorito(int puntoId, int clienteId) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';

    try {
      final jsonData = await TransitaProvider.deleteJsonData(
          'favorito/eliminar/$puntoId/$clienteId');
      final dynamic jsonPunto = json.decode(jsonData);

      Punto punto = Punto.fromJson(jsonPunto);
      print("Cliente eliminado del punto: $punto");

      notifyListeners();
      return punto;
    } catch (error) {
      print("Error al eliminar el cliente del punto: $error");
      // Puedes manejar el error de alguna manera aquí.
      throw Exception("Error al eliminar el cliente del punto: $error");
    }
  }
}
