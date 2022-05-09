import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String id;
  final LatLng latLng;
  final String name;
  final PlaceCategory category;
  final String? openNow;
  final String address;
  final String? img;

  // constructor for the object place
  const Place({
    required this.id,
    required this.latLng,
    required this.name,
    required this.category,
    required this.address,
    this.img,
    this.openNow,
  });

  // getters for the lat-long, id, name and category of the place
  double get latitude => latLng.latitude;

  double get longitude => latLng.longitude;

  String get getId => id;

  String get getName => name;

  PlaceCategory get placeCategory => category;

  Place copyWith(
      {String? id,
      LatLng? latLng,
      String? name,
      PlaceCategory? category,
      String? openNow,
      String? address,
      String? img}) {
    return Place(
      id: id ?? this.id,
      latLng: latLng ?? this.latLng,
      name: name ?? this.name,
      category: category ?? this.category,
      openNow: openNow ?? this.openNow,
      address: address ?? this.address,
      img: img ?? this.img,
    );
  }
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latlng': latLng,
      'name': name,
      'category': category,
      'openNow': openNow,
      'address': address,
      'img': img, 
    };
  }


}

enum PlaceCategory {
  veterinaries,
  parks,
  stores,
}
