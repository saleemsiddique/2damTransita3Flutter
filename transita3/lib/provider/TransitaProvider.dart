import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/AppConfig.dart';
import 'package:transita3/helpers/debouncer.dart';
import '../models/Cliente.dart';

class TransitaProvider extends ChangeNotifier {
  static String _baseUrl = AppConfig.BaseApiUrl;
  String _language = 'es-ES';
  static String apiKey = '';

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  static Future<String> postJsonData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': apiKey,
    };

    String jsonData = json.encode(data);
    print(jsonData);
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

  static Future<String> getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': apiKey,
    };
    final response = await http.get(url, headers: headers);
    print(response.body);
    return response.body;
  }

  static Future<String> putJsonData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': apiKey,
    };

    String jsonData = json.encode(data);
    print("this is JsonData: $jsonData");
    print('Headers: $headers');

    try {
      final response = await http.put(url, headers: headers, body: jsonData);

      if (response.statusCode == 200) {
        print('Solicitud exitosa');
        print(response.body);
        return response.body;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      if (error is SocketException) {
        print('Error de red: $error');
      } else if (error is http.ClientException) {
        print('Error de cliente HTTP: $error');
      } else {
        print('Error desconocido: $error');
      }
      throw Exception('Error durante la solicitud: $error');
    }
  }

  static Future<String> deleteJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': apiKey,
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('Solicitud exitosa');
        print(response.body);
        return response.body;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      if (error is SocketException) {
        print('Error de red: $error');
      } else if (error is http.ClientException) {
        print('Error de cliente HTTP: $error');
      } else {
        print('Error desconocido: $error');
      }
      throw Exception('Error durante la solicitud: $error');
    }
  }
}
