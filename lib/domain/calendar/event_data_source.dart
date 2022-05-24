import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/calendar/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventController controller = Get.find<EventController>();

  EventDataSource() {
    appointments = controller.events;
  }
  Event getEvent(int index) => appointments![index];
  @override
  DateTime getStartTime(int index) => getEvent(index).from;
  @override
  DateTime getEndTime(int index) => getEvent(index).to;
  @override
  String getSubject(int index) => getEvent(index).title;

  Color getBgColor(int index) => getEvent(index).backgroundColor;
  Color setColor(int index) => getEvent(index).backgroundColor;
  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
