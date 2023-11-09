import 'dart:convert';

class LoggedCliente {
  String token;
  String type;
  int id;
  String nombre;
  String apellidos;
  String nombreUsuario;
  String contrasenya;
  String estado;
  List<String> roles;

  LoggedCliente({
    required this.token,
    required this.type,
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.nombreUsuario,
    required this.contrasenya,
    required this.estado,
    required this.roles,
  });

  // Constructor vacío
  LoggedCliente.empty()
      : token = '',
        type = '',
        id = 0,
        nombre = '',
        apellidos = '',
        nombreUsuario = '',
        contrasenya = '',
        estado = '',
        roles = <String>[];

  factory LoggedCliente.fromRawJson(String str) =>
      LoggedCliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoggedCliente.fromJson(Map<String, dynamic> json) => LoggedCliente(
        token: json["token"],
        type: json["type"],
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        nombreUsuario: json["nombreUsuario"],
        contrasenya: json["contrasenya"],
        estado: json["estado"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "nombreUsuario": nombreUsuario,
        "contrasenya": contrasenya,
        "estado": estado,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };

  @override
  String toString() {
    return 'LoggedCliente {'
        'token: $token, '
        'type: $type, '
        'id: $id, '
        'nombre: $nombre, '
        'apellidos: $apellidos, '
        'nombreUsuario: $nombreUsuario, '
        'contrasenya: $contrasenya, '
        'estado: $estado, '
        'roles: $roles}';
  }
}
