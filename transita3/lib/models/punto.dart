import 'dart:convert';
import 'package:transita3/models/models.dart';

class Punto {
  String descripcion;
  String tipoPunto;
  String foto;
  double latitud;
  double longitud;
  String accesibilidadPunto;
  Zona zona;
  int id;

  Punto({
    required this.descripcion,
    required this.tipoPunto,
    required this.foto,
    required this.latitud,
    required this.longitud,
    required this.accesibilidadPunto,
    required this.zona,
    required this.id,
  });

  factory Punto.empty() {
    return Punto(
      descripcion: '',
      tipoPunto: '',
      foto: '',
      latitud: 0.0,
      longitud: 0.0,
      accesibilidadPunto: '',
      zona: Zona.empty(), // Si Zona tiene un constructor empty
      id: 0,
    );
  }

  factory Punto.fromRawJson(String str) => Punto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        descripcion: json["descripcion"],
        tipoPunto: json["tipoPunto"],
        foto: json["foto"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        accesibilidadPunto: json["accesibilidadPunto"],
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
        "zona": zona.toJson(),
        "id": id,
      };
  /*@override
  String toString() {
    return 'Punto{id: $id, descripcion: $descripcion, tipoPunto: $tipoPunto, foto: $foto, '
        'latitud: $latitud, longitud: $longitud, accesibilidadPunto: $accesibilidadPunto, zona: $zona}';
  }*/
  @override
  String toString() {
    return '$descripcion';
  }
}
