import 'package:flutter/material.dart';
import 'package:google_maps/map_screens/show_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowGoogleMap(),
    );
  }
}
