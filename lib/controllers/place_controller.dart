import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_config/flutter_config.dart';
import '../domain/entities/place.dart';

class PlaceController extends GetxController {
  final RxList _places = [].obs;
  final RxList _predictions = [].obs;
  late Place _placePredict;

  var googlePlace = GooglePlace(FlutterConfig.get('PLACE_API_KEY'));
  List get getPlaces => _places;
  List get getPredictions => _predictions;
  Place get getPlacePredict => _placePredict;

  @override
  // ignore: unnecessary_overrides
  void onInit() async {
    super.onInit();
    findPlaces();
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
    if (data != null) {
      for (var placeR in data) {
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
            openNow: placeR.openingHours?.openNow.toString(),
            address: placeR.vicinity!));
      }
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
          radius: 1000);
      if (result != null && result.predictions != null) {
        _predictions.clear();
        for (var prediction in result.predictions!) {
          _predictions.add(prediction);
        }
      }
    } else {
      _predictions.clear();
    }
  }

  void findPlacePredictions(String placeid) async {
    // _placePredict
    var result = await googlePlace.details.get(placeid,
        fields: "vicinity,geometry,name,place_id,type,opening_hours");
    if (result != null && result.result != null) {
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
      var placesExists = _places.singleWhere(
          (element) => element.getId == newPlace.getId, orElse: (() {
        return null;
      }));
      if (placesExists == null) {
        _places.add(newPlace);
      }
      _placePredict = newPlace;
    }
  }

  predictionClear() {
    _predictions.clear();
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
