import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import 'package:transita3/provider/TransitaProvider.dart';
import 'package:transita3/models/models.dart';

class LoginService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  static LoggedCliente cliente = LoggedCliente.empty();

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  // Add loading state variable
  bool isLoadingForgotPassword = false;

  signInCliente(Map<String, dynamic> data) async {
    final jsonData = await TransitaProvider.postJsonData('api/auth/signin/cliente', data);
    cliente = LoggedCliente.fromJson(json.decode(jsonData));
    TransitaProvider.apiKey = '${cliente.type} ${cliente.token}';
    print(TransitaProvider.apiKey);
    print("Este es el usuario creado: $cliente");
    notifyListeners();
  }

  bool isValidForm() {
    print('$email - $password');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

Future<String> forgotPassword(String email) async {
  isLoadingForgotPassword = true;
  notifyListeners();

  final response = await TransitaProvider.getJsonData('api/auth/forgot-password/$email');

  isLoadingForgotPassword = false;
  notifyListeners();

  if (response.contains('Internal Server Error')) {
    throw Exception('Error interno del servidor');
  }

  return response;
}


}
