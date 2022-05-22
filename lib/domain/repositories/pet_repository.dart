import 'dart:convert';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:http/http.dart' as http;

class PetRepository {
  Future<PetProfileFields> fetchPetInfo(String id) async {
    final uri = Uri.parse("${PetProfileFields.baseUrl}/$id");
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        print(jsonResponse["pets"][0]);
        return PetProfileFields.fromJson(jsonResponse["pets"][0]);
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Error while trying to fetch pet info");
    }
  }
}
