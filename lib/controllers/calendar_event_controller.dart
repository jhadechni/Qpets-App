import 'package:get/get.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/domain/calendar/event.dart';
import 'package:qpets_app/domain/repositories/event_repository.dart';

class EventController extends GetxController {
  EventRepository _eventRepository = Get.find<EventRepository>();
  AuthenticationController auth = Get.find<AuthenticationController>();
  EventController() {
    getAllEvents(auth.getUid());
  }
  final events = <Event>[].obs;
  DateTime selectedDate = DateTime.now();
  void setDate(DateTime date) => selectedDate = date;
  void addEvent(Event event) {
    events.add(event);
    events.refresh();
    update();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = events.indexOf(oldEvent);
    events[index] = newEvent;
    events.refresh();
    update();
  }

  Event getEvent(String id) {
    return events.firstWhere((e) => e.id == id);
  }

  Future<Event> addRemote(Map<String, dynamic> data) {
    return _eventRepository.addRemoteEvent(data);
  }

  void deleteEvent(Event event) {
    events.remove(event);
    events.refresh();
    update();
  }

  Future<void> deleteRemote(String id) {
    return _eventRepository.removeRemoteEvent(id);
  }

  Future<void> getAllEvents(String uid) async {
    final evts = await _eventRepository.getRemoteEvents(uid);
    events.value = evts;
    events.refresh();
    update();
  }
}
