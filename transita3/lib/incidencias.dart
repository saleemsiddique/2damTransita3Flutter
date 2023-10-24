import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class _MenuIncidencias {
  List<dynamic> incidencias = [];

  _MenuIncidencias() {
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/menu-incidencias.json');
    Map dataMap = json.decode(resp);
    incidencias = dataMap['incidencias'];

    return incidencias;
  }
}

final menuIncidencias = new _MenuIncidencias();
