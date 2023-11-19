import 'dart:convert';

import 'package:transita3/models/models.dart';

class Incidencia {
    int id;
    String descripcion;
    String estado;
    String duracion;
    DateTime fechaHora;
    String fotos;
    Punto punto;
    Cliente cliente;

    Incidencia({
        required this.id,
        required this.descripcion,
        required this.estado,
        required this.duracion,
        required this.fechaHora,
        required this.fotos,
        required this.punto,
        required this.cliente,
    });

    Incidencia.empty()
      : id = 0,
        descripcion = '',
        estado = '',
        duracion = '',
        fechaHora = DateTime.now(),
        fotos = '',
        punto = Punto.empty(),
        cliente = Cliente.empty();

    factory Incidencia.fromRawJson(String str) => Incidencia.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Incidencia.fromJson(Map<String, dynamic> json) => Incidencia(
        id: json["id"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        duracion: json["duracion"],
        fechaHora: DateTime.parse(json["fechaHora"]),
        fotos: json["fotos"],
        punto: Punto.fromJson(json["punto"]),
        cliente: Cliente.fromJson(json["cliente"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
        "duracion": duracion,
        "fechaHora": "${fechaHora.year.toString().padLeft(4, '0')}-${fechaHora.month.toString().padLeft(2, '0')}-${fechaHora.day.toString().padLeft(2, '0')}",
        "fotos": fotos,
        "punto": punto.toJson(),
        "cliente": cliente.toJson(),
    };

     static List<Incidencia> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Incidencia.fromJson(json)).toList();
  }
}