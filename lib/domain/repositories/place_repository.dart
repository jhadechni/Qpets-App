import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:qpets_app/domain/entities/place.dart';

import '../../data/datasources/local/place_local_datasource_sqflite.dart';
import '../../data/datasources/remote/place_remote_datasource.dart';

class PlaceRepository {
  late PlaceRemoteDatatasource remoteDataSource;
  late PlaceLocalDataSource localDataSource;

  PlaceRepository() {
    remoteDataSource = PlaceRemoteDatatasource();
    localDataSource = PlaceLocalDataSource();
  }

  Future<bool> getPlacesRemote(Position position) async {
    List<Place> places = await remoteDataSource.getPlaces(position); //change to list of places
    await localDataSource.addAllPlaces(places); //insert items in the database foreach
    return Future.value(true);
  }

  Future<List<Place>> getAllPlaces() async =>
      await localDataSource.getAllPlaces();

  Future<void> deleteAll() async => await localDataSource.deleteAll();

  Future<void> addPlace(Place place) async => await localDataSource.addPlace(place);

  Future<List<AutocompletePrediction>?>getPredictions(input,position) async => await remoteDataSource.findPredictions(input,position);

    Future<Place>findPlaceSelected(placeid) async => await remoteDataSource.findPlaceSelected(placeid);

}
