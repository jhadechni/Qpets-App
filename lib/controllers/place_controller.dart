import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:qpets_app/domain/use_case/places.dart';
import '../domain/entities/place.dart';

class PlaceController extends GetxController {
  late List _places = [].obs;
  final RxList _predictions = [].obs;
  late Place _placePredict;

  PlacesUseCase placeUseCase = Get.find();


  List get getPlaces => _places;
  List get getPredictions => _predictions;
  Place get getPlacePredict => _placePredict;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    findPlaces();
  }

  Future<void> findPlaces() async {
    Position position = await _determinePosition();
    await placeUseCase.getPlacesRemote(position);
    await getAllPlaces();
  }

  Future<void> getAllPlaces() async {
    var list = await placeUseCase.getAllPlaces();
    _places = list;
  }

  addPlace(Place place) async {
    _places.add(place);
    await placeUseCase.addPlace(place);
  }

  void findPlacePrediction(String value) async {
    if (value.isNotEmpty) {
      Position position = await _determinePosition();
      var result = await placeUseCase.findpredictions(value, position);
      _predictions.clear();
      for (var prediction in result!) {
        _predictions.add(prediction);
      }
    } else {
      _predictions.clear();
    }
  }

  void findPlacePredictions(String placeid) async {
    var result = await placeUseCase.findPlaceSelected(placeid);
    var placesExists = _places.contains(result);
    if (placesExists == false) {
      _places.add(result);
    }
    _placePredict = result;
  }

  predictionClear() {
    _predictions.clear();
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
}
