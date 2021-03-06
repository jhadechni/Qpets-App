import 'dart:convert';
import 'package:qpets_app/data/datasources/local/pet_local_datasource.sqflite.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:http/http.dart' as http;
import 'package:qpets_app/domain/timeline_event.dart';

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
    print(uri.toString());
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> rawList = jsonResponse["pets"];
        return List.generate(rawList.length, (i) {
          //keep in mind the index
          return PetProfileFields.fromJson(rawList[i]);
        });
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Error while trying to fetch pet info");
    }
  }

  Future<PetProfileFields> addRemotePet(Map<String, dynamic> data) async {
    try {
      final res = await http.post(
          Uri.parse("${PetProfileFields.baseUrl}/createPet"),
          body: jsonEncode(data),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (res.statusCode != 200) {
        return Future.error("Pet Post response failed");
      }
      final jsonResponse = json.decode(utf8.decode(res.bodyBytes));
      return PetProfileFields.fromJson(jsonResponse);
    } catch (e) {
      print(e);
      return Future.error("Pet Post failed");
    }
  }

  Future<PetProfileFields> getPetInfo(String id) {
    return _localDatabase.getPet(id);
  }

  Future<List<PetProfileFields>> getAllPets(String uid) {
    return _localDatabase.getAll(uid);
  }

  Future<void> storePets(List<PetProfileFields> pets) async {
    await _localDatabase.addAllPets(pets);
  }

  Future<void> addPet(PetProfileFields pet) async {
    await _localDatabase.addPet(pet);
  }
}
