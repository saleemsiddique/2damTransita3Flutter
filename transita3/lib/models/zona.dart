import 'dart:convert';

class Zona {
    String nombre;
    int id;

    Zona({
        required this.nombre,
        required this.id,
    });

    factory Zona.fromRawJson(String str) => Zona.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Zona.fromJson(Map<String, dynamic> json) => Zona(
        nombre: json["nombre"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id": id,
    };
}
