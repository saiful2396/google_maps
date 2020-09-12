import 'dart:convert';
import 'package:google_maps/model/earthquakes.dart';
import 'package:http/http.dart';

class NetWork {
  Future<Earthquake> getEarthQuakes() async {
    var apiKey = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson';
    Response response = await get(Uri.encodeFull(apiKey));
    //print(Uri.encodeFull(apiKey));
    
    if(response.statusCode == 200) {
      //print(response.body);
      return Earthquake.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to get Data from api');
    }
  }
}