import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpets_app/domain/calendar/event_data_source.dart';
import 'package:qpets_app/ui/pages/calendar/tasks_widget.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Color.fromARGB(255, 186, 171, 223),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}
