import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/LoginService.dart';
import 'package:transita3/services/OpenRouteService.dart';
import 'package:transita3/services/PuntoService.dart';
import 'package:transita3/widgets/Boton_Agregar.dart';
import 'package:transita3/widgets/Show_Image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class MapaPantallaNotifier extends ChangeNotifier {
  static LatLng _latLngOrigen = LatLng(0, 0);
  static LatLng _latLngDestino = LatLng(0, 0);
  static bool routeChange = true;

  LatLng get latLngOrigen => _latLngOrigen;
  LatLng get latLngDestino => _latLngDestino;

  void updateLatLngOrigen(LatLng newLatLng) {
    _latLngOrigen = newLatLng;
    routeChange = true;
    notifyListeners();
  }

  void updateLatLngDestino(LatLng newLatLng) {
    _latLngDestino = newLatLng;
    routeChange = true;
    notifyListeners();
  }
}

class Mapa_pantalla extends StatefulWidget {
  static bool isBottomSheetOpen = false;
  static bool primerPuntoSeleccionado = false;
  static bool segundoPuntoSeleccionado = false;
  static String selectedPoint1Text = 'Seleccionar un punto de origen';
  static String selectedPoint2Text = 'Seleccionar un destino en el mapa';

  _MapaPantalla createState() => _MapaPantalla();
}

class _MapaPantalla extends State<Mapa_pantalla> {
  static List<Punto> puntos = [];
  Location location = Location();
  LatLng _currentLocation = LatLng(38.5064, -0.2297);
  bool showMarkers = true;
  LatLng latLngSelec = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      var userLocation = await location.getLocation();
      setState(() {
        _currentLocation =
            LatLng(userLocation.latitude!, userLocation.longitude!);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Recostruyo mapa");
    print("Recostruido: ${OpenRouteService.routeCoordinates}");

    if (PuntoService.puntosForMap.isEmpty) {
      PuntoService.getPuntosForMap();
    }
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
                    ...PuntoService.puntosForMap.map((punto) {
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
                            color: Colors.red,
                          ),
                        ),
                      );
                    }).toList(),
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
              await PuntoService.getPuntosForMap();
              setState(() {});
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
            child: Container(
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
          ),
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

  void showPointDetailsBottomSheet(BuildContext context, Punto punto) {
    Mapa_pantalla.isBottomSheetOpen = true;
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showImagePunto(punto),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descripción: ${punto.descripcion}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('Tipo: ${punto.tipoPunto}'),
                          Text('Latitud: ${punto.latitud}'),
                          Text('Longitud: ${punto.longitud}'),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: botonAgregar(
                      context, 'creacionincidencia', punto, 60, 60, null, null),
                ),
              ],
            ),
          ),
        );
      },
    ).closed.whenComplete(() {
      Mapa_pantalla.isBottomSheetOpen = false;
    });
  }

  void showLatLngBottomSheet(BuildContext context, LatLng latLng) {
    bool isStarFilled = PuntoService.buscarPuntoPorCoordenadasYCliente(
            latLng.latitude, latLng.longitude, LoginService.cliente.id) ==
        Punto.empty();
    print('star is $isStarFilled');
    Mapa_pantalla.isBottomSheetOpen = true;
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 80,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lat: ${latLng.latitude}'),
                      Text('Lon: ${latLng.longitude}'),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> puntoData = {
                        'descripcion': '',
                        'tipoPunto': 'LUGAR',
                        'foto': '',
                        'latitud': latLng.latitude,
                        'longitud': latLng.longitude,
                        'accesibilidadPunto': 'ACCESIBLE',
                        'visibilidadPunto': 'GLOBAL',
                      };
                      await PuntoService.postPunto(puntoData);
                      await PuntoService.getPuntoByCoordenadas(
                          latLng.latitude, latLng.longitude);
                          print("Llego aqui");
                      await PuntoService.agregarClienteAlPunto(
                          PuntoService.puntoSelected.id, LoginService.cliente.id);
                      await PuntoService.getPuntos();
                    },
                    child: Icon(
                      isStarFilled ? Icons.star : Icons.star_border,
                      color: Colors.yellow, // Cambia el color si lo deseas
                    ),
                  ),
                  botonAgregar(context, 'creacionincidencia', null, 70, 70,
                      latLng.latitude, latLng.longitude),
                ],
              ),
            );
          },
        );
      },
    ).closed.whenComplete(() {
      Mapa_pantalla.isBottomSheetOpen = false;
    });
  }

  void rutasDetailsSheet(BuildContext context) {
    Mapa_pantalla.isBottomSheetOpen = true;
    final openRouteService =
        Provider.of<OpenRouteService>(context, listen: false);
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Consumer<MapaPantallaNotifier>(
                builder: (context, mapaPantallaNotifier, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Mapa_pantalla.primerPuntoSeleccionado = true;
                              Mapa_pantalla.segundoPuntoSeleccionado = false;
                              Mapa_pantalla.selectedPoint1Text =
                                  '${MapaPantallaNotifier._latLngOrigen.latitude},${MapaPantallaNotifier._latLngOrigen.longitude}';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Mapa_pantalla.primerPuntoSeleccionado
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(Mapa_pantalla.selectedPoint1Text),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Mapa_pantalla.primerPuntoSeleccionado = false;
                              Mapa_pantalla.segundoPuntoSeleccionado = true;
                              Mapa_pantalla.selectedPoint2Text =
                                  '${MapaPantallaNotifier._latLngDestino.latitude},${MapaPantallaNotifier._latLngDestino.longitude}';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Mapa_pantalla.segundoPuntoSeleccionado
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(Mapa_pantalla.selectedPoint2Text),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            print("vale");
                            openRouteService.getRuta(
                                Mapa_pantalla.selectedPoint1Text,
                                Mapa_pantalla.selectedPoint2Text);
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.blue, // Example color for the button
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Crear ruta',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }).closed.whenComplete(() {
      Mapa_pantalla.isBottomSheetOpen = false;
      Mapa_pantalla.primerPuntoSeleccionado = false;
      Mapa_pantalla.segundoPuntoSeleccionado = false;
    });
  }
}
