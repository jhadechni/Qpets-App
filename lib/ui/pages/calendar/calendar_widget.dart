import 'package:flutter/material.dart';
import '../../provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendar_widget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final events Provider.of<EventProvider>(context).events; 

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor:Color.fromARGB(255, 186, 171, 223),
    );
  }
}