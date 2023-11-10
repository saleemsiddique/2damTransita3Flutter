import 'dart:convert';

class Cliente {
    String nombre;
    String apellidos;
    String nombreUsuario;
    String contrasenya;
    String estadoCuenta;
    int id;

    Cliente({
        required this.nombre,
        required this.apellidos,
        required this.nombreUsuario,
        required this.contrasenya,
        required this.estadoCuenta,
        required this.id,
    });

     Cliente.empty()
      : nombre = '',
        apellidos = '',
        nombreUsuario = '',
        contrasenya = '',
        estadoCuenta = '',
        id = 0;

    factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        nombreUsuario: json["nombreUsuario"],
        contrasenya: json["contrasenya"],
        estadoCuenta: json["estadoCuenta"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidos": apellidos,
        "nombreUsuario": nombreUsuario,
        "contrasenya": contrasenya,
        "estadoCuenta": estadoCuenta,
        "id": id,
    };
}