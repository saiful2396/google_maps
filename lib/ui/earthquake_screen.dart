import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/earthquakes.dart';
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
  double _zoomVal = 5.0;

  @override
  void initState() {
    super.initState();
    data = NetWork().getEarthQuakes();
    //data.then((value) => print('${value.features[0].properties.place}'));
  }

  void _handleResponse() {
    setState(() {
      data.then((earthquake) => {
            earthquake.features.forEach((earthquake) => {
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
                }),
          });
    });
  }

  void findEarthquake() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  Future<void> _zoomIn(double _zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: _zoomVal),
      ),
    );
  }

  Future<void> _zoomOut(double _zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: _zoomVal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildShowMapScreen(context),
          Positioned(
            left: 20,
            top: 38,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.blue),
              child: Row(
                children: [
                  _zoomPlus(),
                  _zoomMinus(),
                ],
              ),
            ),
          ),
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
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(36.1083333, -117.86083333), zoom: 3),
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }

  Widget _zoomPlus() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () {
          _zoomVal++;
          _zoomIn(_zoomVal);
        },
        icon: Icon(
          FontAwesomeIcons.searchPlus,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _zoomMinus() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          _zoomVal--;
          _zoomOut(_zoomVal);
        },
        icon: Icon(
          FontAwesomeIcons.searchMinus,
          color: Colors.white,
        ),
      ),
    );
  }
}
