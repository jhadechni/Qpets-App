import 'dart:convert';

import 'package:qpets_app/data/datasources/local/pet_local_datasource.sqflite.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:http/http.dart' as http;

class PetRepository {
  PetLocalDatabase _localDatabase = PetLocalDatabase();
  Future<PetProfileFields> fetchPetInfo(String id) async {
    final uri = Uri.parse("${PetProfileFields.baseUrl}/$id");
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return PetProfileFields.fromJson(jsonResponse["pets"][0]);
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Error while trying to fetch pet info");
    }
  }

  Future<List<PetProfileFields>> fetchAllPets(String uid) async {
    final uri = Uri.parse("${PetProfileFields.baseUrl}/getAllPets/$uid");
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return List.generate(jsonResponse["pets"].length, (i) {
          //keep in mind the index
          return PetProfileFields.fromJson(jsonResponse["pets"][i]);
        });
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Error while trying to fetch pet info");
    }
  }

  Future<bool> addRemotePet(PetProfileFields pet) async {
    try {
      final res = await http.post(
          Uri.parse("${PetProfileFields.baseUrl}/pets/createPet"),
          body: jsonEncode(pet.toJson()));
      if (res.statusCode != 201) {
        return Future.error("Pet Post response failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Pet Post failed");
    }
    return true;
  }

  Future<PetProfileFields> getPetInfo(String id) {
    return _localDatabase.getPet(id);
  }

  Future<List<PetProfileFields>> getAllPets() {
    return _localDatabase.getAll();
  }

  Future<void> storePets(List<PetProfileFields> pets) async {
    await _localDatabase.addAllPets(pets);
  }

  Future<void> addPet(PetProfileFields pet) async {
    await _localDatabase.addPet(pet);
  }
}
