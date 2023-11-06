import 'dart:convert';

class Punto {
    String descripcion;
    String tipoPunto;
    String foto;
    double latitud;
    double longitud;
    String accesibilidadPunto;
    dynamic zona;
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

    factory Punto.fromRawJson(String str) => Punto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        descripcion: json["descripcion"],
        tipoPunto: json["tipoPunto"],
        foto: json["foto"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        accesibilidadPunto: json["accesibilidadPunto"],
        zona: json["zona"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "tipoPunto": tipoPunto,
        "foto": foto,
        "latitud": latitud,
        "longitud": longitud,
        "accesibilidadPunto": accesibilidadPunto,
        "zona": zona,
        "id": id,
    };
}
