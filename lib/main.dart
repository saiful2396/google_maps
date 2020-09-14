import 'package:flutter/material.dart';
import 'package:google_maps/earthquake_screen.dart';
import 'package:google_maps/map_screens/show_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: EarthquakeScreen.id,
      routes: {
        ShowGoogleMap.id: (_) => ShowGoogleMap(),
        EarthquakeScreen.id: (_) => EarthquakeScreen(),
      },
    );
  }
}
