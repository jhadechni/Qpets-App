import 'dart:convert';
import 'package:qpets_app/data/datasources/local/pet_local_datasource.sqflite.dart';
import 'package:qpets_app/domain/calendar/event.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:http/http.dart' as http;

class EventRepository {
  static const baseUrl = "https://qpets.herokuapp.com/user";
  Future<Event> addRemoteEvent(Map<String, dynamic> event) async {
    final url = Uri.parse("${baseUrl}/events");
    print(url);
    try {
      final res = await http
          .post(url, body: jsonEncode(event), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (res.statusCode != 200) {
        return Future.error("Event Post response failed");
      }
      final jsonRes = json.decode(utf8.decode(res.bodyBytes));
      return Event.fromJson(jsonRes);
    } catch (e) {
      print(e);
      return Future.error("Event Post failed");
    }
  }

  Future<void> removeRemoteEvent(String id) async {
    final url = Uri.parse("${baseUrl}/events/delete/${id}");
    print(url);
    try {
      final res = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (res.statusCode != 200) {
        return Future.error("Event Delete response failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Event Delete failed");
    }
  }

  Future<List<Event>> getRemoteEvents(String uid) async {
    final url = Uri.parse("${baseUrl}/events/${uid}");
    print(url);
    try {
      final res = await http.get(url);
      if (res.statusCode != 200) {
        return Future.error("Event fetch response failed");
      }
      final jsonResponse = json.decode(utf8.decode(res.bodyBytes));
      final List<dynamic> rawList = jsonResponse["events"];
      return List.generate(rawList.length, (i) {
        //keep in mind the index
        return Event.fromJson(rawList[i]);
      });
    } catch (e) {
      print(e);
      return Future.error("Event fetch failed");
    }
  }
}
