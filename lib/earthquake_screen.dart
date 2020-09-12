import 'dart:async';

import 'package:flutter/material.dart';
import 'model/earthquakes.dart';
import 'package:google_maps/network/network.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EarthquakeScreen extends StatefulWidget {
  static const id = 'earthquake_screen';
  @override
  _EarthquakeScreenState createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  Future<Earthquake> data;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = <Marker>[];

  @override
  void initState() {
    super.initState();
    data = NetWork().getEarthQuakes();
    //data.then((value) => print('${value.features[0].properties.place}'));
  }

  void _handleResponse() {
    setState(
      () {
        data.then(
          (earthquake) => {
            earthquake.features.forEach(
              (earthquake) => {
                _markerList.add(
                  Marker(
                    markerId: MarkerId(earthquake.id),
                    infoWindow: InfoWindow(
                      title: earthquake.properties.mag.toString(),
                      snippet: earthquake.properties.title,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta),
                    position: LatLng(earthquake.geometry.coordinates[1],
                        earthquake.geometry.coordinates[0]),
                    onTap: () {},
                  ),
                ),
              },
            ),
          },
        );
      },
    );
  }

  void findEarthquake() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildShowMapScreen(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          findEarthquake();
        },
        label: Text('Find Earthquake'),
      ),
    );
  }

  Widget _buildShowMapScreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(36.1083333, -117.86083333), zoom: 3),
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }
}
