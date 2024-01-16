import 'dart:convert';

class Punto {
  String descripcion;
  String tipoPunto;
  String foto;
  double latitud;
  double longitud;
  String accesibilidadPunto;
  String visibilidadPunto;
  int id;

  Punto({
    required this.descripcion,
    required this.tipoPunto,
    required this.foto,
    required this.latitud,
    required this.longitud,
    required this.accesibilidadPunto,
    required this.visibilidadPunto,
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
        id = 0;

  factory Punto.fromRawJson(String str) => Punto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        descripcion: json["descripcion"] ?? '',
        tipoPunto: json["tipoPunto"] ?? '',
        foto: json["foto"] ?? '',
        latitud: json["latitud"]?.toDouble() ?? 0.0,
        longitud: json["longitud"]?.toDouble() ?? 0.0,
        accesibilidadPunto: json["accesibilidadPunto"] ?? '',
        visibilidadPunto: json["visibilidadPunto"] ?? '',
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "tipoPunto": tipoPunto,
        "foto": foto,
        "latitud": latitud,
        "longitud": longitud,
        "accesibilidadPunto": accesibilidadPunto,
        "visibilidadPunto": visibilidadPunto,
        "id": id,
      };

  @override
  String toString() {
    String latSubstring = latitud.toString().length > 4
        ? latitud.toString().substring(0, 6)
        : latitud.toString();

    String lonSubstring = longitud.toString().length > 4
        ? longitud.toString().substring(0, 6)
        : longitud.toString();

    return 'latitud: $latSubstring - longitud: $lonSubstring';
  }
}
