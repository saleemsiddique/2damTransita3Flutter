import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Mapa_pantalla extends StatefulWidget {
  _mapaPantalla createState() => _mapaPantalla();
}

final MapController _mapController = MapController(
  initMapWithUserPosition:
      UserTrackingOption(enableTracking: true, unFollowUser: true),
);

final OSMOption _osmOption = OSMOption(
  showZoomController: true,
  userTrackingOption: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ),
  zoomOption: ZoomOption(
    initZoom: 17,
    minZoomLevel: 3,
    maxZoomLevel: 19,
    stepZoom: 1.0,
  ),
  userLocationMarker: UserLocationMaker(
    personMarker: MarkerIcon(
      icon: Icon(
        Icons.location_history,
        color: Colors.red,
        size: 150,
      ),
    ),
    directionArrowMarker: MarkerIcon(
      icon: Icon(
        Icons.location_history,
        color: Colors.red,
        size: 150,
      ),
    ),
  ),
  roadConfiguration: RoadOption(
    roadColor: Colors.yellowAccent,
  ),
  markerOption: MarkerOption(
    defaultMarker: MarkerIcon(
      icon: Icon(
        Icons.person_pin_circle,
        color: Colors.blue,
        size: 48,
      ),
    ),
  ),
);

class _mapaPantalla extends State<Mapa_pantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: _mapController,
        osmOption: _osmOption,
        mapIsLoading: const Center(
          child: Image(
            image: AssetImage('assets/loading.gif'),
          ),
        ),
        onMapIsReady: (isReady) async {
          if (isReady) {
            await Future.delayed(const Duration(seconds: 1), () async {
              await _mapController.currentLocation();
            });
          }
        },
        onGeoPointClicked: (geoPoint) {
          var key = '${geoPoint.latitude}_${geoPoint.longitude}';
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Position ${markerMap[key]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const Divider(),
                              Text(
                                key,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  var markerMap = <String, String>{};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.listenerMapSingleTapping.addListener(() async {
        var position = _mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await _mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.blue,
                  size: 48,
                ),
              ));
          var key = '${position.latitude}_${position.longitude}';
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }
}
