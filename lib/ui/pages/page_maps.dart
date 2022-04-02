// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:qpets_app/controllers/place_controller.dart';
import 'package:qpets_app/shared/search_bar.dart';

import 'package:qpets_app/domain/place.dart';
import 'package:get/get.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => MapPageState();
}

class MapPageState extends State<MapsPage> {
  final Set<Marker> _markers = {};
  List _places = [];
  bool _veterinariesPlaces = false;
  bool _parksPlaces = false;
  bool _storesPlaces = false;
  late GoogleMapController googleMapController;

  var googlePlace = GooglePlace('AIzaSyBMHyZvPvNTYMgY5V81Ge10aGxuj0Pu_TE');
  List<AutocompletePrediction> _predictions = [];

  @override
  void initState() {
    //consumer from the streams of places
    PlaceController placeController = Get.find();
    placeController.findPlaces();
    _places = placeController.getPlaces;
    setMarkers();
    super.initState();
  }

  void setMarkers() {
    List filterPlaces = [];
    for (var p in _places) {
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

  void findPlace(String value) async {
    Position position = await _determinePosition();
    var result = await googlePlace.autocomplete.get(value,
        location: LatLon(position.latitude, position.longitude), radius: 3000);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        _predictions = result.predictions!;
      });
    }
  }

  void findPlacePredictions(String placeid) async {
    var result = await googlePlace.details.get(placeid,
        fields: "vicinity,geometry,name,place_id,type,opening_hours");
    if (result != null && result.result != null && mounted) {
      var data = result.result;
      double? lat = data?.geometry?.location!.lat;
      double? lng = data?.geometry?.location!.lng;

      Place newPlace = Place(
          id: data!.placeId!,
          latLng: LatLng(lat!, lng!),
          name: data.name!,
          category: data.types!.contains('veterinary_care')
              ? PlaceCategory.veterinaries
              : data.types!.contains('park')
                  ? PlaceCategory.parks
                  : PlaceCategory.stores,
          openNow: data.openingHours?.openNow!.toString(),
          address: data.vicinity!);
      final placesExists = _places
          .singleWhere((element) => element.id == newPlace.getId, orElse: (() {
        return null;
      }));
      if (placesExists == null) {
        setState(() {
          final marker = Marker(
              markerId: MarkerId(newPlace.getId),
              position: LatLng(newPlace.latitude, newPlace.longitude),
              infoWindow: InfoWindow(
                title: newPlace.getName,
              ),
              onTap: () => _modalBottom(newPlace));
          _markers.add(marker);
        });
        placeController.addPlace(newPlace);
      }
      _predictions.clear();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(newPlace.latitude, newPlace.longitude),
              zoom: 16)));
    }
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
            onTap: () {
              setState(() {
                _predictions.clear();
              });
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
                        (value) => {
                              if (value.isNotEmpty)
                                {findPlace(value)}
                              else
                                {
                                  setState(() {
                                    _predictions = [];
                                  })
                                }
                            },
                        "Find a place!"),
                  ),
                  _categoryButtonBar(),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 64, 10, 0),
                child: _predictions.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    itemCount: _predictions.length,
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
                                          title: Text(
                                              _predictions[index].description!),
                                          onTap: () {
                                            findPlacePredictions(
                                                _predictions[index].placeId!);
                                          });
                                    })),
                          ),
                        ],
                      )
                    : Container(),
              ),
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
          _places = placeController.getPlaces;
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
