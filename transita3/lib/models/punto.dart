import 'dart:convert';

import 'package:transita3/models/zona.dart';

class Punto {
    String descripcion;
    String tipoPunto;
    String foto;
    double latitud;
    double longitud;
    String accesibilidadPunto;
    String visibilidadPunto;
    Zona zona;
    int id;

    Punto({
        required this.descripcion,
        required this.tipoPunto,
        required this.foto,
        required this.latitud,
        required this.longitud,
        required this.accesibilidadPunto,
        required this.visibilidadPunto,
        required this.zona,
        required this.id,
    });

    Punto.empty()
      : descripcion = '',
        tipoPunto = '',
        foto = '',
        latitud = 0.0,
        longitud = 0.0,
        accesibilidadPunto = '',
        visibilidadPunto = '',
        zona = Zona.empty(),
        id = 0;

    factory Punto.fromRawJson(String str) => Punto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        descripcion: json["descripcion"],
        tipoPunto: json["tipoPunto"],
        foto: json["foto"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        accesibilidadPunto: json["accesibilidadPunto"],
        visibilidadPunto: json["visibilidadPunto"],
        zona: Zona.fromJson(json["zona"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "tipoPunto": tipoPunto,
        "foto": foto,
        "latitud": latitud,
        "longitud": longitud,
        "accesibilidadPunto": accesibilidadPunto,
        "visibilidadPunto": visibilidadPunto,
        "zona": zona.toJson(),
        "id": id,
    };

      @override
  String toString() {
    return 'Punto{'
        'descripcion: $descripcion, '
        'tipoPunto: $tipoPunto, '
        'foto: $foto, '
        'latitud: $latitud, '
        'longitud: $longitud, '
        'accesibilidadPunto: $accesibilidadPunto, '
        'visibilidadPunto: $visibilidadPunto, '
        'zona: $zona, '
        'id: $id}';
  }
}