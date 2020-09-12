import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowGoogleMap extends StatefulWidget {
  static const id = 'show_maps';
  @override
  _ShowGoogleMapState createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {

  GoogleMapController mapController;
  static LatLng _center = const LatLng(23.8103, 90.4125);
  static LatLng _besideLocation = const LatLng(23.814500, 90.419999);

  final CameraPosition nationalZoo = CameraPosition(
    target: LatLng(23.7375227, 90.3945221),
      bearing: 191.789,
      tilt: 34.89,
      zoom: 17.0
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future<void> _nationalZoo() async{
    GoogleMapController controller = await mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(nationalZoo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
      ),

      body: GoogleMap(
        markers: {dhakaMarker, dhakaMarkerSecond},
        mapType: MapType.terrain,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: _nationalZoo,
          label: Text('Go Bangladesh National Museum'),
        icon: Icon(Icons.place, color: Colors.amber,),
      ),
    );
  }
  Marker dhakaMarker = Marker(
      markerId: MarkerId('Dhaka'),
    position: _center,
    infoWindow: InfoWindow(title: 'Dhaka', snippet: 'This is a great living city!'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta)
  );
  Marker dhakaMarkerSecond = Marker(
      markerId: MarkerId('Dhaka'),
    position: _besideLocation,
    infoWindow: InfoWindow(title: 'Dhaka Area', snippet: 'This is also a great living city!'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta)
  );
}
