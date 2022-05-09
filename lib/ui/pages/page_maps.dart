// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qpets_app/controllers/place_controller.dart';
import 'package:qpets_app/shared/search_bar.dart';

import 'package:qpets_app/domain/entities/place.dart';
import 'package:get/get.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => MapPageState();
}

class MapPageState extends State<MapsPage> {
  final Set<Marker> _markers = {};
  bool _veterinariesPlaces = true;
  bool _parksPlaces = false;
  bool _storesPlaces = false;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    super.initState();
    setMarkers();
  }

  void setMarkers() {
    PlaceController placeController = Get.find();
    List filterPlaces = [];
    var places = placeController.getPlaces;
    for (var p in places) {
      if (p.placeCategory == PlaceCategory.veterinaries &&
          _veterinariesPlaces == true) {
        filterPlaces.add(p);
      }
      if (p.placeCategory == PlaceCategory.parks && _parksPlaces == true) {
        filterPlaces.add(p);
      }
      if (p.placeCategory == PlaceCategory.stores && _storesPlaces == true) {
        filterPlaces.add(p);
      }
    }
    setState(() {
      _markers.clear();
      for (var filterP in filterPlaces) {
        final marker = Marker(
            markerId: MarkerId(filterP.getId),
            position: LatLng(filterP.latitude, filterP.longitude),
            infoWindow: InfoWindow(
              title: filterP.getName,
            ),
            onTap: () => _modalBottom(filterP));
        _markers.add(marker);
      }
    });
  }

  static const CameraPosition _initialCamaraPos = CameraPosition(
    target: LatLng(11.010245, -74.815318),
    zoom: 15,
  );
  PlaceController placeController = Get.find();
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: Stack(
        children: [
          // ignore: non_constant_identifier_names, avoid_print
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCamaraPos,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
              setMarkers();
            },
            markers: _markers,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
          ),
          GestureDetector(
            onDoubleTap: () {
              placeController.predictionClear();
              setState(() {});
            },
          ),
          Stack(
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    // ignore: avoid_print
                    child: SearchBar(
                      placeholder: 'find a place!',
                      onTextChangeCallback: (s) => placeController.findPlace(s),
                    ),
                  ),
                  _categoryButtonBar(),
                ],
              ),
              Obx(
                () => Padding(
                    padding: EdgeInsets.fromLTRB(10, 64, 10, 0),
                    child: placeController.getPredictions.isNotEmpty ? Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                  height: 280.0,
                                  width: 370.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(25.0),
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: ListView.builder(
                                      itemCount:
                                          placeController.getPredictions.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xFF8E6FD8),
                                              child: Icon(
                                                Icons.pin_drop,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(placeController
                                                .getPredictions[index]
                                                .description!),
                                            onTap: () {
                                              placeController.findPlacePredictions(
                                                  placeController
                                                      .getPredictions[index]
                                                      .placeId!);
                                              setMarkers();
                                              placeController.predictionClear();
                                              googleMapController.animateCamera(
                                                  CameraUpdate.newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                                              placeController
                                                                  .getPlacePredict
                                                                  .latitude,
                                                              placeController
                                                                  .getPlacePredict
                                                                  .longitude),
                                                          zoom: 16)));
                                                          
                                            });
                                      }))),
                        ],
                      ): Container()),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_searching,
          color: Colors.white,
          size: 35.0,
        ),
        tooltip: 'Center',
        backgroundColor: const Color(0xFF8E6FD8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        onPressed: () async {
          Position position = await _determinePosition();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 16)));
          _markers.remove('userLocation');
          _markers.add(Marker(
            markerId: const MarkerId('userLocation'),
            position: LatLng(position.latitude, position.longitude),
            // icon: ,
            infoWindow: InfoWindow(title: "Mi Ubicacion"),
          ));
          setState(() {});
          //insert findPlaces around new location
          placeController.findPlaces();
          setMarkers();
        },
      ),
    );
  }

  Future<void> _modalBottom(Place place) {
    return showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 226, 226, 236),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(place.getName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                Text(place.placeCategory.toString().substring(14).toUpperCase(),
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 25)),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                      place.openNow == 'true'
                          ? 'Status • Open'
                          : 'Status • Close',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                ),
                Text(
                    place.address.isEmpty ? 'Address not found' : place.address,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromARGB(115, 145, 42, 42),
                        fontWeight: FontWeight.w200,
                        fontSize: 20)),
              ],
            ))));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Widget _categoryButtonBar() {
    return Visibility(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
        alignment: Alignment.topCenter,
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(
                Icons.pets_outlined,
                color: _veterinariesPlaces ? Colors.white : Colors.grey,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                primary: _veterinariesPlaces
                    ? const Color(0xFF8E6FD8)
                    : Colors.white,
                // primary: const Color(0xFF8E6FD8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: Text(
                'Veterinaries',
                style: TextStyle(
                    color: _veterinariesPlaces ? Colors.white : Colors.grey,
                    fontSize: 14.0),
              ),
              onPressed: () {
                setState(() {
                  _veterinariesPlaces = !_veterinariesPlaces;
                });
                setMarkers();
              },
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.park_outlined,
                color: _parksPlaces ? Colors.white : Colors.grey,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                primary: _parksPlaces ? const Color(0xFF8E6FD8) : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: Text(
                'Parks',
                style: TextStyle(
                    color: _parksPlaces ? Colors.white : Colors.grey,
                    fontSize: 14.0),
              ),
              onPressed: () {
                setState(() {
                  _parksPlaces = !_parksPlaces;
                });
                setMarkers();
              },
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.storefront,
                color: _storesPlaces ? Colors.white : Colors.grey,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                primary: _storesPlaces ? const Color(0xFF8E6FD8) : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: Text(
                'Stores',
                style: TextStyle(
                    color: _storesPlaces ? Colors.white : Colors.grey,
                    fontSize: 14.0),
              ),
              onPressed: () {
                setState(() {
                  _storesPlaces = !_storesPlaces;
                });
                setMarkers();
              },
            ),
          ],
        ),
      ),
    );
  }
}
