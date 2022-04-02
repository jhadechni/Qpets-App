import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../domain/place.dart';

class PlaceController extends GetxController {
  RxList _places = [].obs;
  RxList _predictions = [].obs;

  var googlePlace = GooglePlace(
      'AIzaSyBMHyZvPvNTYMgY5V81Ge10aGxuj0Pu_TE'); // DotEnv().env['PLACE_API_KEY']!
  List get getPlaces => _places;
  List get getPredictions => _predictions;

  @override
  // ignore: unnecessary_overrides
  void onInit() async {
    // findPlaces();
    super.onInit();
  }

  findPlaces() async {
    Position position = await _determinePosition();

    // Here you can fetch you data from server
    var resultVet = await googlePlace.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude), 2000,
        type: "veterinary_care", keyword: "pet");
    var data = resultVet?.results;
    var resultPark = await googlePlace.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude), 500,
        type: "park");
    var datap = resultPark?.results;
    data?.addAll(datap!);
    var resultStore = await googlePlace.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude), 2000,
        type: "pet_store", keyword: "pet");
    var datastr = resultStore?.results;
    data?.addAll(datastr!);
    _places.clear();
    for (var placeR in data!) {
      double? lat = placeR.geometry!.location!.lat;
      double? lng = placeR.geometry!.location!.lng;
      //find the photo size 400x400
      // var resPhoto = await googlePlace.photos.get(placeR.photos![0].photoReference,400,400);
      _places.add(Place(
          id: placeR.placeId!,
          latLng: LatLng(lat!, lng!),
          name: placeR.name!,
          category: placeR.types!.contains('veterinary_care')
              ? PlaceCategory.veterinaries
              : placeR.types!.contains('park')
                  ? PlaceCategory.parks
                  : PlaceCategory.stores,
          openNow: placeR.openingHours?.openNow!.toString(),
          address: placeR.vicinity!));
    }
  }

  addPlace(Place place) {
    _places.add(place);
  }

  void findPlace(String value) async {
    if (value.isNotEmpty) {
      Position position = await _determinePosition();
      var result = await googlePlace.autocomplete.get(value,
          location: LatLon(position.latitude, position.longitude),
          radius: 3000);
      if (result != null && result.predictions != null) {
        _predictions = result.predictions! as RxList;
      }
    } else {
      _predictions.clear();
    }
  }



  // Types> veterinary_care | park | pet_store

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
}
