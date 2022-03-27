import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:qpets_app/ui/provider/event_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}
class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build (BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty) {
  return const Center(
     child: Text(
        'No Events found!',
        style: TextStyle(color: Colors.black, fontSize: 24),
    ),
  ); 
  }
}