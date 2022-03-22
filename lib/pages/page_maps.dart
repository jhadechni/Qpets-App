// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qpets_app/shared/search_bar.dart';

// import '../domain/place.dart';

// ignore: camel_case_types
class page_maps extends StatefulWidget {
  const page_maps({Key? key}) : super(key: key);

  @override
  State<page_maps> createState() => MapPageState();
}

class MapPageState extends State<page_maps> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
          markerId: MarkerId('id'),
          position: LatLng(11.018352, -74.817457),
          infoWindow: InfoWindow(
            title: 'Parque Tivoli',
            snippet: 'Cra. 65 #94, Barranquilla, Atlántico',
          ),
          onTap: () {
            showModalBottomSheet<void>(
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text('Parque Tivoli',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                        ),
                        Text('Park',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 30)),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text('Open • Closes at 9:30 p.m',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20)),
                        ),
                        Text('Cra. 65 #94, Barranquilla, Atlántico',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromARGB(115, 145, 42, 42),
                                fontWeight: FontWeight.w200,
                                fontSize: 20)),
                      ],
                    ))));
          });
      _markers['Parque Tivoli'] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.010245, -74.815318),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: Stack(
        children: [
          // ignore: non_constant_identifier_names, avoid_print

          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers.values.toSet(),
          ),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
                child: SearchBar((s) => {print(s)}, "Find a place!"),
              ),
              _CategoryButtonBar(),
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
        onPressed: () {},
      ),
    );
  }

}

class _CategoryButtonBar extends StatelessWidget {
  const _CategoryButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                // primary: selectedPlaceCategory == PlaceCategory.veterinaries
                //     ? const Color(0xFF8E6FD8)
                //     : Colors.white
                primary: const Color(0xFF8E6FD8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: const Text(
                'Veterinaries',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.park_outlined,
                color: Colors.grey,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                // primary: selectedPlaceCategory == PlaceCategory.veterinaries
                //     ? const Color(0xFF8E6FD8)
                //     : Colors.white
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: const Text(
                'Parks',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.storefront,
                color: Colors.grey,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                // primary: selectedPlaceCategory == PlaceCategory.veterinaries
                //     ? const Color(0xFF8E6FD8)
                //     : Colors.white
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              label: const Text(
                'Stores',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
