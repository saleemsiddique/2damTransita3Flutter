import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/services/TimerService.dart';
import 'package:transita3/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class MapaPantallaNotifier extends ChangeNotifier {
  static LatLng _latLngOrigen = LatLng(0, 0);
  static LatLng _latLngDestino = LatLng(0, 0);
  static bool routeChange = true;

  LatLng get latLngOrigen => _latLngOrigen;
  LatLng get latLngDestino => _latLngDestino;

  void updateLatLngOrigen(LatLng newLatLng) {
    print("MAPAPANTALLANOTIFIER");
    _latLngOrigen = newLatLng;
    routeChange = true;
    notifyListeners();
  }

  void updateLatLngDestino(LatLng newLatLng) {
    print("MAPAPANTALLANOTIFIER");

    _latLngDestino = newLatLng;
    routeChange = true;
    notifyListeners();
  }

  void updateRouteChange(bool isOption) {
    print("MAPAPANTALLANOTIFIER");
    routeChange = isOption;
    notifyListeners();
  }
}

class Mapa_pantalla extends StatefulWidget {
  static bool isBottomSheetOpen = false;
  static bool primerPuntoSeleccionado = false;
  static bool segundoPuntoSeleccionado = false;
  static String selectedPoint1Text = 'Seleccionar un origen en el origen';
  static String selectedPoint2Text = 'Seleccionar un destino en el mapa';

  _MapaPantalla createState() => _MapaPantalla();
}

class _MapaPantalla extends State<Mapa_pantalla> {
  static List<Punto> puntos = [];
  Location location = Location();
  bool showMarkers = true;
  LatLng latLngSelec = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final puntosService = Provider.of<PuntoService>(context, listen: true);
    final timerService = Provider.of<TimerService>(context, listen: true);

    print("Recostruyo mapa");
    print("Recostruido: ${OpenRouteService.routeCoordinates}");
    print(MapaPantallaNotifier.routeChange);

    Widget mapa = Consumer2<MapaPantallaNotifier, OpenRouteService>(
      builder: (context, mapaPantallaNotifier, openRouteService, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(38.5064, -0.2297),
              initialZoom: 15,
              maxZoom: 18,
              minZoom: 10,
              onPositionChanged: (MapPosition position, bool hasGesture) {
                setState(() {
                  print(showMarkers);
                  showMarkers = position.zoom! >= 15;
                });
              },
              onTap: (TapPosition position, LatLng latLng) {
                print("this is puntoSelected ${puntosService.puntoSelected}");
                setState(() {
                  latLngSelec = latLng;
                  if (Mapa_pantalla.primerPuntoSeleccionado) {
                    mapaPantallaNotifier.updateLatLngOrigen(latLng);
                    Mapa_pantalla.selectedPoint1Text =
                        '${latLng.latitude}, ${latLng.longitude}';
                  } else if (Mapa_pantalla.segundoPuntoSeleccionado) {
                    mapaPantallaNotifier.updateLatLngDestino(latLng);
                    Mapa_pantalla.selectedPoint2Text =
                        '${latLng.latitude}, ${latLng.longitude}';
                  } else {
                    showLatLngBottomSheet(context, latLng);
                  }
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                  if (showMarkers)
                    ...puntosService.puntosForMap
                        .map((punto) {
                          if (punto.accesibilidadPunto == 'NO_ACCESIBLE') {
                            return Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(punto.latitud, punto.longitud),
                              child: GestureDetector(
                                onTap: () {
                                  latLngSelec = LatLng(0, 0);
                                  setState(() {});
                                  showPointDetailsBottomSheet(context, punto);
                                },
                                child: Icon(
                                  Icons.location_off_rounded,
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),
                              ),
                            );
                          } else if (punto.accesibilidadPunto ==
                              'PARCIALMENTE_ACCESIBLE') {
                            return Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(punto.latitud, punto.longitud),
                              child: GestureDetector(
                                onTap: () {
                                  latLngSelec = LatLng(0, 0);
                                  setState(() {});
                                  showPointDetailsBottomSheet(context, punto);
                                },
                                child: Icon(
                                  Icons.not_listed_location,
                                  color: Color.fromARGB(255, 255, 145, 0),
                                ),
                              ),
                            );
                          } else {
                            return Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(punto.latitud, punto.longitud),
                              child: GestureDetector(
                                onTap: () {
                                  latLngSelec = LatLng(0, 0);
                                  setState(() {});
                                  showPointDetailsBottomSheet(context, punto);
                                },
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          }
                        })
                        .where((marker) => marker != null)
                        .toList(),
                  ...puntosService.favsForMap.map((punto) {
                    return Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(punto.latitud, punto.longitud),
                      child: GestureDetector(
                        onTap: () {
                          latLngSelec = LatLng(0, 0);
                          setState(() {});
                          showPointDetailsBottomSheet(context, punto);
                        },
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.green,
                        ),
                      ),
                    );
                  }).toList(),
                  MarkerSelect(
                      40, timerService.currentLocation, Colors.tealAccent),
                  MarkerSelect(40, latLngSelec, Colors.blue),
                  MarkerSelect(
                      60, MapaPantallaNotifier._latLngOrigen, Colors.black),
                  MarkerSelect(
                      60, MapaPantallaNotifier._latLngDestino, Colors.black),
                ],
              ),
              if (!MapaPantallaNotifier
                  .routeChange) // Mostrar la polyline solo si routeChange es false
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: OpenRouteService.routeCoordinates
                          .map((coord) => LatLng(coord[1], coord[0]))
                          .toList(),
                      color: Colors.blue,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return Stack(
      children: [
        mapa,
        Positioned(
          top: 16.0,
          child: RawMaterialButton(
            onPressed: () async {
              try {
                await puntosService.getPuntosForMap();
                setState(() {});
              } catch (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text(
                          'Ha ocurrido un error al obtener los puntos para el mapa.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (route) => false); // Cerrar el AlertDialog
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            elevation: 2.0,
            fillColor: Color.fromRGBO(0, 99, 209, 1),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 90.0,
          right: 15.0,
          child: GestureDetector(
              onTap: () {
                rutasDetailsSheet(context);
              },
              child: Column(children: [
                BotonFiltro(),
                SizedBox(height: 15),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 99, 209, 1),
                  ),
                  child: Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                ),
              ])),
        )
      ],
    );
  }

  Marker MarkerSelect(double size, LatLng latLng, Color color) {
    return Marker(
      width: size,
      height: size,
      point: latLng,
      child: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Icon(
          Icons.location_pin,
          color: color,
        ),
      ),
    );
  }
}
