import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class Mapa_pantalla extends StatefulWidget {
  _MapaPantalla createState() => _MapaPantalla();
}

class _MapaPantalla extends State<Mapa_pantalla> {
  Location location = Location();
  LatLng _currentLocation = LatLng(0.0, 0.0);

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
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(38.5064, -0.2297),
        initialZoom: 15,
        maxZoom: 18,
        minZoom: 10
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: _currentLocation,
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
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
    );
  }
}
