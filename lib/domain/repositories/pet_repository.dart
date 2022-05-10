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
        final Map<String, dynamic> data = <String, dynamic>{};
        data['gender'] = jsonResponse["response"]["gender"];
        data['name'] = jsonResponse["response"]["name"];
        data['type'] = jsonResponse["response"]["type"];
        data['breed'] = jsonResponse["response"]["breed"];
        data['weight'] = jsonResponse["response"]["weight"];
        data['dob'] = jsonResponse["response"]["dob"];
        data['imgUrl'] = jsonResponse["response"]["imgUrl"];
        return PetProfileFields.fromJson(data);
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      return Future.error("Error whiel trying to fetch pet info");
    }
  }
}
