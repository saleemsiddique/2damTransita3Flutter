import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import '../models/Cliente.dart';

class ClienteProvider extends ChangeNotifier {
      GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';
  String nombre = '';
  String apellidos = '';
  String email = '';
  String password = '';

  static Cliente cliente = new Cliente.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    String jsonData = json.encode(data);

    final response = await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      print('Solicitud exitosa');
      print(response.body);
      return response.body;
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

  signUpCliente(Map<String, dynamic> data) async {
    final jsonData = await postJsonData('api/auth/signup/cliente', data);
    cliente = Cliente.fromJson(json.decode(jsonData));
    print("Este es el usuario creado: $cliente");
    notifyListeners();
  }

  bool isValidForm(){
  print('$email - $password');
  print(formKey.currentState?.validate());
  return formKey.currentState?.validate() ?? false;
}
}
