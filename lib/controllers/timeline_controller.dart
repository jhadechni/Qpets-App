import 'dart:convert';

import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/timeline_event.dart';
import 'package:http/http.dart' as http;

class TimelineController extends GetxController {
  final events = <TimelineEvent>[].obs;

  TimelineController() {
    events.sort((a, b) => a.date.compareTo(b.date));
    events.refresh();
  }

  List<TimelineEvent> getLastEvents({int n = 5}) {
    if (events.length > n) {
      return events.sublist(events.length - n, events.length);
    }
    return events;
  }

  Future<List<TimelineEvent>> _fetchTimelineOfPet(String id) async {
    final uri = Uri.parse("${PetProfileFields.baseUrl}/timeline/$id");
    print(uri.toString());
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> rawList = jsonResponse["events"];
        return List.generate(rawList.length, (i) {
          //keep in mind the index
          return TimelineEvent.fromJson(rawList[i]);
        });
      } else {
        return Future.error("Fetching pet info failed");
      }
    } catch (e) {
      print(e);
      return Future.error("Error while trying to fetch pet info");
    }
  }

  Future<TimelineEvent> _addPetEvent(Map<String, String> data) async {
    try {
      final res = await http.post(
          Uri.parse("${PetProfileFields.baseUrl}/timeline/addEvent"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
      if (res.statusCode != 200) {
        return Future.error("Pet Timeline response failed");
      }
      return TimelineEvent.fromJson(json.decode(utf8.decode(res.bodyBytes)));
    } catch (e) {
      print(e);
      return Future.error("Pet Timeline Post failed");
    }
  }

  Future<void> getAllEvents(String id) async {
    final evts = await _fetchTimelineOfPet(id);
    events.value = evts;
    events.sort((a, b) => a.date.compareTo(b.date));
    events.refresh();
  }

  Future<void> addEvent(
      String name, String desc, DateTime date, String petId) async {
    Map<String, String> data = <String, String>{
      "eventName": name,
      "eventDescription": desc,
      "eventDate": date.toString(),
      "petId": petId
    };
    final timelineEvt = await _addPetEvent(data);
    print("Added $name");
    events.add(timelineEvt);
    events.sort((a, b) => a.date.compareTo(b.date));
    events.refresh();
  }
}
