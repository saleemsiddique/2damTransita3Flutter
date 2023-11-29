import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/PuntoService.dart';
import 'package:transita3/widgets/Show_Image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class Mapa_pantalla extends StatefulWidget {
  _MapaPantalla createState() => _MapaPantalla();
}

class _MapaPantalla extends State<Mapa_pantalla> {
  static List<Punto> puntos = [];
  Location location = Location();
  LatLng _currentLocation = LatLng(38.5064, -0.2297);

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

    puntoService.getPuntos();

    Widget mapa = FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(38.5064, -0.2297),
        initialZoom: 15,
        maxZoom: 18,
        minZoom: 10,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: PuntoService.puntos.map((punto) {
            return Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(punto.latitud, punto.longitud),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      puntoService.setSelectedPunto(punto);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PuntoDetailsOverlay(punto: punto);
                        },
                      );
                    },
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
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
    );
return mapa;
  }
}

class PuntoDetailsOverlay extends StatelessWidget {
  final Punto punto;

  PuntoDetailsOverlay({required this.punto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 300, // Ajusta la altura según tus necesidades
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: showImagePunto(punto),
            ),
            SizedBox(height: 16.0),
            Text(punto.descripcion,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Text('Tipo de Punto: ${punto.tipoPunto}'),
            Text('Accesibilidad: ${punto.accesibilidadPunto}'),
            Text('Visibilidad: ${punto.visibilidadPunto}'),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: Text('Cerrar', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
  }
}
