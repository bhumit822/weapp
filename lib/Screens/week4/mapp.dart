import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_webservice/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:weapp/Screens/week4/Mapintrgration/direction_repository.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/main.dart';

class MapDemo extends StatefulWidget {
  const MapDemo({Key? key}) : super(key: key);

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  Location _location = Location()..changeSettings(interval: 300);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = initLocation!;
    getLocation();
  }

  place.GoogleMapsPlaces _places =
      place.GoogleMapsPlaces(apiKey: "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk");
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<LocationData> getLocation() async {
    // bool permission=await _location.;
    a = await _location.getLocation();
    setState(() {});
    print("============================${a}");
    return await _location.getLocation();
  }

  late GoogleMapController _mapController;

  LocationData a = initLocation!;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapController.dispose();
  }

  Marker? startMarker;
  Marker? endMarker;
  Marker? searchMarker;
  bool _isDirection = false;

  Direction? _info;

  double? _distance;
  TextEditingController _startPoint = TextEditingController();
  TextEditingController _endPoint = TextEditingController();
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue1,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            key: UniqueKey(),
            backgroundColor: Colors.white,
            onPressed: () {
              _mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(a.latitude!, a.longitude!), zoom: 19.0)));
            },
            child: Icon(
              Icons.center_focus_strong_sharp,
              color: AppColors.blue1,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: null,
            key: UniqueKey(),
            onPressed: () {
              setState(() {
                searchMarker = null;
                _isDirection = true;
              });
            },
            child: Icon(
              Icons.directions,
              color: AppColors.blue1,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              child: GoogleMap(
                markers: {
                  if (startMarker != null) startMarker!,
                  if (endMarker != null) endMarker!,
                  if (searchMarker != null) searchMarker!,
                },
                onMapCreated: (controller) => _mapController = controller,
                compassEnabled: true, onLongPress: _addmarker,
                myLocationButtonEnabled: true,

                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(polylines.values),

                buildingsEnabled: true, mapType: MapType.normal,
                // mapToolbarEnabled: true,
                indoorViewEnabled: true, myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(a.latitude!, a.longitude!), zoom: 15.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: _isDirection
                ? SafeArea(
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black,
                            spreadRadius: -10,
                            blurRadius: 20)
                      ]),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppBar(
                              backgroundColor: AppColors.blue3,
                              leading: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    _isDirection = false;

                                    startMarker = null;
                                    endMarker = null;
                                    polylines = {};
                                    _endPoint.clear();
                                    _startPoint.clear();
                                    _distance = null;
                                  });
                                },
                              ),
                              title: Text("Direction"),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                keyboardType: TextInputType.none,
                                controller: _startPoint,
                                onTap: () async {
                                  place.Prediction? p =
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey:
                                              "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk",
                                          mode: Mode.overlay,
                                          language: "en",
                                          types: [],
                                          strictbounds: false,
                                          components: [
                                            place.Component(
                                                place.Component.country, "ind")
                                          ]);
                                  if (p != null) {
                                    final pos = await _places
                                        .getDetailsByPlaceId(p.placeId!);

                                    _startPoint.text =
                                        pos.result.formattedAddress!;
                                    final lat =
                                        pos.result.geometry!.location.lat;
                                    final lng =
                                        pos.result.geometry!.location.lng;

                                    _addmarker(LatLng(lat, lng),
                                        pos.result.formattedAddress);
                                  }
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Start Location"),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                keyboardType: TextInputType.none,
                                controller: _endPoint,
                                onTap: () async {
                                  place.Prediction? p =
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey:
                                              "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk",
                                          mode: Mode.overlay,
                                          language: "en",
                                          types: [],
                                          strictbounds: false,
                                          components: [
                                            place.Component(
                                                place.Component.country, "ind")
                                          ]);
                                  if (p != null) {
                                    final pos = await _places
                                        .getDetailsByPlaceId(p.placeId!);
                                    _endPoint.text =
                                        pos.result.formattedAddress!;
                                    final lat =
                                        pos.result.geometry!.location.lat;
                                    final lng =
                                        pos.result.geometry!.location.lng;

                                    _addmarker(LatLng(lat, lng),
                                        pos.result.formattedAddress);
                                  }
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "End Location"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _distance != null
                                ? Text(
                                    "${_distance!.toStringAsFixed(2)} km",
                                    style: AppTextStyles.h4_Bold
                                        .copyWith(color: AppColors.white),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _search,
                      style:
                          AppTextStyles.h4_Bold.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Search Places",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintStyle: AppTextStyles.h4_Bold
                              .copyWith(color: Colors.white)),
                      keyboardType: TextInputType.none,
                      onTap: () async {
                        place.Prediction? p = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk",
                            mode: Mode.overlay,
                            language: "en",
                            types: [],
                            strictbounds: false,
                            components: [
                              place.Component(place.Component.country, "ind")
                            ]);
                        final pos =
                            await _places.getDetailsByPlaceId(p!.placeId!);
                        _search.text = pos.result.formattedAddress!;
                        final lat = pos.result.geometry!.location.lat;
                        final lng = pos.result.geometry!.location.lng;
                        _mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(lat, lng), zoom: 13.0)));

                        searchMarker = Marker(
                            markerId: MarkerId(pos.result.formattedAddress!),
                            infoWindow:
                                InfoWindow(title: pos.result.formattedAddress!),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen),
                            position: LatLng(lat, lng));
                        setState(() {});
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  void _addmarker(LatLng pos, [String? address]) async {
// List<Placemark> placemarks =
//           await placemarkFromCoordinates(geposition.latitude, position.longitude);

// Placemark place1 = placemarks[0];
// Placemark place2 = placemarks[1];
// String _currentAddress =
//             "${place1.name} ${place2.name} ${place1.subLocality}
// ${place1.subAdministrativeArea} ${place1.postalCode}";
    if (startMarker == null || (startMarker != null && endMarker != null)) {
      setState(() {
        startMarker = Marker(
            markerId: MarkerId(address ?? pos.toString()),
            infoWindow: InfoWindow(title: address ?? pos.toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos);
        print(pos);
        endMarker = null;
        _info = null;

        polylines = {};
      });
    } else {
      setState(() {
        print(pos);
        endMarker = Marker(
            markerId: MarkerId(address ?? pos.toString()),
            infoWindow: InfoWindow(title: address ?? pos.toString()),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: pos);
      });
      try {
        print("StartMarker ====================${startMarker!.position}");
        print("StartMarker ====================${endMarker!.position}");

        List<LatLng> polylineCoordinates = [];
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            "AIzaSyDJdsa3g6TdmOCfwJs2A5_xZbTWpKjezCk",
            PointLatLng(startMarker!.position.latitude,
                startMarker!.position.longitude),
            PointLatLng(
                endMarker!.position.latitude, endMarker!.position.longitude),
            travelMode: TravelMode.driving);

        _distance = calculateDistance(
            startMarker!.position.latitude,
            startMarker!.position.longitude,
            endMarker!.position.latitude,
            endMarker!.position.longitude);
        print(
            "Distance======================================================$_distance");

        result.points.forEach((point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        print("Get polylinedata ================");
        print("Get polylinedata ================${result.points}");
        addPolyLine(polylineCoordinates);
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(startMarker!.position.latitude,
                    startMarker!.position.longitude),
                zoom: 13.0)));
      } catch (e) {
        print("Get polylinedata ================$e");
      }

      setState(() {});
    }
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    try {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 8,
      );
      polylines[id] = polyline;
      setState(() {});
      print("add poly");
    } catch (e) {
      print("add poly ==========================$e");
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
