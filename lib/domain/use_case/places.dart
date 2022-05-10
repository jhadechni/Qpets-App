import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

//use case
class PlacesUseCase {
  PlaceRepository repository = Get.find();

  Future<void> getPlacesRemote(Position position) async => await repository.getPlacesRemote(position);

  Future<List<Place>> getAllPlaces() async => await repository.getAllPlaces();

  Future<void> addPlace(place) async => await repository.addPlace(place);

  Future<void> deleteAll() async => await repository.deleteAll();

  Future<List<AutocompletePrediction>?> findpredictions(input , position) async => await repository.getPredictions(input , position);

  Future<Place> findPlaceSelected(placeid) async => await repository.findPlaceSelected(placeid);
  
}
