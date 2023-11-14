import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transita3/helpers/debouncer.dart';
import '../models/Cliente.dart';

class TransitaProvider extends ChangeNotifier {  
  static String _baseUrl = '10.0.2.2:8083';
  String _language = 'es-ES';
  static String apiKey = '';


  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  static Future<String> postJsonData(String endpoint, Map<String, dynamic> data) async {
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

  static Future<String> getJsonData(String endpoint) async {
    final url = Uri.http(_baseUrl, endpoint);
    Map<String, String> headers = {
      'Authorization': apiKey,
    };
    final response = await http.get(url, headers: headers);
    print(response.body);
    return response.body;
  }
}