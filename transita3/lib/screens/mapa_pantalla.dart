import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/PuntoService.dart';
import 'package:transita3/widgets/Boton_Agregar.dart';
import 'package:transita3/widgets/Show_Image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class Mapa_pantalla extends StatefulWidget {
  static bool isBottomSheetOpen = false;
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
    final puntoService = Provider.of<PuntoService>(context, listen: true);
    if (PuntoService.puntosForMap.isEmpty) {
      PuntoService.getPuntosForMap();
    }
    Widget mapa = GestureDetector(
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
            setState(() {});
            latLngSelec = latLng;
            showLatLngBottomSheet(context, latLng);
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
                        showPointDetailsBottomSheet(context, punto);
                      },
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              Marker(
                width: 40.0,
                height: 40.0,
                point: latLngSelec,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
    );

    return mapa;
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
    Mapa_pantalla.isBottomSheetOpen = true;
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
              botonAgregar(context, 'creacionincidencia', null, 70, 70,
                  latLng.latitude, latLng.longitude),
            ],
          ),
        );
      },
    ).closed.whenComplete(() {
      Mapa_pantalla.isBottomSheetOpen = false;
    });
  }
}
