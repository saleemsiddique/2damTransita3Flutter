import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/services/LoginService.dart';

class PuntoService extends ChangeNotifier {
  static List<Punto> puntos = [];
  static List<Punto> puntosForMap = [];
  static Punto punto = Punto.empty();
  static Punto puntoSelected = Punto.empty();

  static getPuntosForMap() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('/global-con-incidencias-aceptadas');

      final List<dynamic> jsonList = json.decode(jsonData);
      puntosForMap = [];
      puntosForMap = jsonList.map((json) => Punto.fromJson(json)).toList();
      print("Estos son los puntos: ${puntos.toString()}");
    }
  }

  static getPuntos() async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('puntos');

      final List<dynamic> jsonList = json.decode(jsonData);
      puntos = [];
      puntos = jsonList.map((json) => Punto.fromJson(json)).toList();
      print("Estos son los puntos: ${puntos.toString()}");
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

static getPuntoByCoordenadas(double latitud, double longitud) async {
  final cliente = LoginService.cliente;
  TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
  print('id de clientePunto: ${cliente.id}');
  
  if (cliente != null) {
    try {
      final jsonData = await TransitaProvider.getJsonData('punto/coordenadas/$latitud/$longitud');

      final dynamic jsonPunto = json.decode(jsonData);

      puntoSelected = Punto.fromJson(jsonPunto);
      print("Este es el punto seleccionado: ${puntoSelected.toString()}");
    } catch (error) {
      print("No se ha encontrado este punto");
      // You might want to handle the error or perform additional actions here.
    }
  } else {
    print("No se ha encontrado este punto");
  }
}


    static postPunto(Map<String, dynamic> data) async {
      final jsonData = await TransitaProvider.postJsonData('puntos', data);
      print("PUNTO CREADO");
  }

    static Future<Set<Punto>> getPuntoByIdCliente(int id) async {
    final cliente = LoginService.cliente;
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print('id de clientePunto: ${cliente.id}');
    if (cliente != null) {
      final jsonData = await TransitaProvider.getJsonData('punto/favoritos/$id');
      final List<dynamic> jsonList = json.decode(jsonData);
      Set<Punto> puntos = jsonList.map((json) => Punto.fromJson(json)).toSet();
      return puntos;
    }
    return Set<Punto>();
  }

static Future<Punto> buscarPuntoPorCoordenadasYCliente(double latitud, double longitud, int idCliente) async {
  print("buscarPuntoPorCoordenadasYCliente");
  final cliente = LoginService.cliente;

  if (cliente != null) {
    try {
      TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
      print('lat: $latitud lon: $longitud');
      
      final jsonData = await TransitaProvider.getJsonData('favoritos/$latitud/$longitud/$idCliente');
      final dynamic jsonPunto = json.decode(jsonData);
      
      Punto punto = Punto.fromJson(jsonPunto);
      print("El punto favorito escogido es $punto");
      
      return punto;
    } catch (error) {
      print("Error al buscar el punto: $error");
      // You might want to handle the error or perform additional actions here.
    }
  } else {
    print("No se ha encontrado este punto");
  }
  
  return Punto.empty();
}


  static Future<Punto> agregarClienteAlPunto(int puntoId, int clienteId) async {
    final jsonData = await TransitaProvider.putJsonData('favorito/$puntoId/$clienteId', {});
    final dynamic jsonPunto = json.decode(jsonData);
    Punto punto = Punto.fromJson(jsonPunto);
    print("Añadido a favorito");
    return punto;
  }
}
