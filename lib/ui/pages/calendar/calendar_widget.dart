import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/domain/calendar/event_data_source.dart';
import 'package:qpets_app/ui/pages/calendar/tasks_widget.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  EventController controller = Get.find<EventController>();

  CalendarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      builder: (_) {
        return SfCalendar(
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          dataSource: EventDataSource(),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: const Color.fromARGB(255, 186, 171, 223),
          onLongPress: (details) {
            controller.setDate(details.date!);
            showModalBottomSheet(
              context: context,
              builder: (context) => TasksWidget(),
            );
          },
        );
      }
    );
  }
}
