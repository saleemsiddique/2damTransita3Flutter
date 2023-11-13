import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import '../models/LoggedCliente.dart';

class LoginService extends ChangeNotifier {
      GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';

  static LoggedCliente cliente = new LoggedCliente.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  signInCliente(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData('api/auth/signin/cliente', data);
    cliente = LoggedCliente.fromJson(json.decode(jsonData));
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print(TransitaProvider.apiKey);
    print("Este es el usuario creado: $cliente");
    notifyListeners();
  }

  bool isValidForm(){
    print('$email - $password');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}