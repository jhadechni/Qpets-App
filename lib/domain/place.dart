import 'package:google_maps_flutter/google_maps_flutter.dart';


class Place {
  final String id;
  final LatLng latLng;
  final String name;
  final PlaceCategory category;
  final String? description;


  // constructor for the object place
  const Place({
    required this.id,
    required this.latLng,
    required this.name,
    required this.category,
    this.description,
  });


  // getters for the lat-long of the place
  double get latitude => latLng.latitude;

  double get longitude => latLng.longitude;

  Place copyWith({
    String? id,
    LatLng? latLng,
    String? name,
    PlaceCategory? category,
    String? description,
  }) {
    return Place(
      id: id ?? this.id,
      latLng: latLng ?? this.latLng,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}

enum PlaceCategory {
  veterinaries,
  parks,
  stores,
}
