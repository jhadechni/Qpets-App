import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/calendar/event_data_source.dart';
import 'package:qpets_app/utils/ourPurple.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

Color ourPurple = Palette.ourPurple;

// ignore: use_key_in_widget_constructors
class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  EventController controller = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final selectedEvents = controller.events;
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No se ha encontrado ningun evento',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: const TextStyle(fontSize: 16, color: Colors.black)),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(),
          initialDisplayDate: controller.selectedDate,
          appointmentBuilder: appointmentBuilder,
          headerHeight: 0,
          todayHighlightColor: ourPurple,
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
          ),
          onTap: (details) {
            if (details.appointments == null) return;
            final event = details.appointments!.first;
            // Navigator.of(context) => EventEditingPage(event:event),
          },
        ));
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: event.backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
