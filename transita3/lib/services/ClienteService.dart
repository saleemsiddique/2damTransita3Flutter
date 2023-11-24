import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/services/LoginService.dart';
import '../models/models.dart';
import 'package:transita3/screens/perfil_pantalla.dart';

class ClienteService extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String nombre = '';
  String apellidos = '';
  String email = '';
  String password = '';
   Cliente cliente = new Cliente.empty();

  
  

  signUpCliente(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData('api/auth/signup/cliente', data);
    cliente = Cliente.fromJson(json.decode(jsonData));
    print("Este es el usuario creado: $cliente");
    notifyListeners();
  }

 modifyCliente(Map<String, dynamic> data, id) async {
    final jsonData =
        await TransitaProvider.putJsonData('api/auth/cliente/modificar/${id}', data);
    print("Este es el usuario modificado: $cliente");
    notifyListeners();
  }

modifyContrasenya(Map<String, dynamic> data, int id) async {
  final jsonData = await TransitaProvider.putJsonData('api/auth/cliente/modificarContrasenya/$id', data);
  
  print("Contraseña modificada: ${data['newPassword']}");
  notifyListeners();
}
}