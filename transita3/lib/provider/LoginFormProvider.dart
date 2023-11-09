import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import '../models/LoggedCliente.dart';

class LoginFormProvider extends ChangeNotifier {
      GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _apiKey = '';
  String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';
  String email = '';
  String password = '';

  static LoggedCliente cliente = new LoggedCliente.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': _apiKey,
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

  signInCliente(Map<String, dynamic> data) async {
    final jsonData = await postJsonData('api/auth/signin/cliente', data);

    cliente = LoggedCliente.fromJson(json.decode(jsonData));
    _apiKey = '${cliente.type} ${cliente.token}';
    print(_apiKey);
    print("Este es el usuario creado: $cliente");
    notifyListeners();
  }

  bool isValidForm(){
  print('$email - $password');
  print(formKey.currentState?.validate());
  return formKey.currentState?.validate() ?? false;
}
}
