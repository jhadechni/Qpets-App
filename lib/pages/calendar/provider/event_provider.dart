import 'package:flutter/cupertino.dart';
import 'package:qpets_app/pages/calendar/event.dart';
import 'package:qpets_app/utils.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}
