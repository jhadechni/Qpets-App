import 'package:get/get.dart';
import 'package:qpets_app/domain/timeline_event.dart';

class TimelineController extends GetxController {
  final events = <TimelineEvent>[
    TimelineEvent(0, "Vaccine 1", "", DateTime.utc(2022, 3, 10)),
    TimelineEvent(1, "Park", "", DateTime.utc(2022, 2, 26)),
    TimelineEvent(2, "Train Class", "", DateTime.utc(2022, 2, 10)),
    TimelineEvent(3, "Spa Salon", "", DateTime.utc(2022, 1, 30)),
    TimelineEvent(4, "Vet Visit", "", DateTime.utc(2022, 1, 25)),
    TimelineEvent(5, "Vet Visit", "", DateTime.utc(2022, 1, 1)),
    TimelineEvent(6, "New Collar", "", DateTime.utc(2021, 12, 20))
  ].obs;

  TimelineController() {
    events.sort((a, b) => a.date.compareTo(b.date));
    events.refresh();
  }

  List<TimelineEvent> getLastEvents({int n = 5}) =>
      events.sublist(events.length - n, events.length);

  void addEvent(String name, String desc, DateTime date) {
    print("Added $name");
    events.add(TimelineEvent(events.length, name, desc, date));
    events.sort((a, b) => a.date.compareTo(b.date));
    events.refresh();
  }
}
