import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetDierction {
  Dio _dio = Dio();

  Future<Direction?> getDierction(
      {required LatLng start, required LatLng end}) async {
    final response = await _dio.get(
        'https://api.openrouteservice.org/v2/directions/foot-walking?',
        queryParameters: {
          "api_key": "5b3ce3597851110001cf6248b1647e19e8494fffa9f810ca26fb3c29",
          "start": "${start.latitude},${start.longitude}",
          "end": "${end.latitude},${end.longitude}"
        });

    print("====================${response.data}");

    if (response.statusCode == 200) {
      // return Direction.fromMap(response.data);
    }
    return null;
  }
}

class Direction {
  final LatLngBounds bounds;
  final List<PointLatLng> polyPoints;
  final String distance;
  final String duration;

  Direction(
      {required this.bounds,
      required this.polyPoints,
      required this.distance,
      required this.duration});

  factory Direction.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map["routes"][0]);
    final north = data["bounds"]['northeast'];
    final south = data["bounds"]['southwest'];
    final bound = LatLngBounds(
        southwest: LatLng(north['lat'], north['lng']),
        northeast: LatLng(south['lat'], south['lng']));
    String _distance = "";
    String _duration = "";

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      _distance = leg['distance']['text'];
      _duration = leg['duration']['text'];
    }
    return Direction(
        bounds: bound,
        polyPoints:
            PolylinePoints().decodePolyline(data['overview_polyline']['point']),
        distance: _distance,
        duration: _duration);
  }
}
