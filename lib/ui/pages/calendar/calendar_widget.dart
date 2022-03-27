import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendar_widget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final events Provider.of<EventProvider>(context).events; 

    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor:Color.fromARGB(255, 186, 171, 223),
    );
  }
}