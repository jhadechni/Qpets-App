import 'package:flutter_config/flutter_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:qpets_app/domain/entities/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PlaceRemoteDatatasource {
  
  var googlePlace = GooglePlace(FlutterConfig.get('PLACE_API_KEY'));

  Future<List<Place>> getPlaces(Position position) async {
    // Here you can fetch you data from server
    List<Place> placesResult = [];

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
    if (data != null) {
      for (var placeR in data) {
        double? lat = placeR.geometry!.location!.lat;
        double? lng = placeR.geometry!.location!.lng;
        //find the photo size 400x400
        // var resPhoto = await googlePlace.photos.get(placeR.photos![0].photoReference,400,400);
        placesResult.add(Place(
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
      return placesResult;
    }
    return Future.error("error");
  }


}