import 'package:get/get.dart';
import 'package:qpets_app/domain/calendar/event.dart';

class EventController extends GetxController {
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

  void deleteEvent(Event event) {
    events.remove(event);
    events.refresh();
    update();
  }
}
