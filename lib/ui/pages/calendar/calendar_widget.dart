import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qpets_app/domain/calendar/event_data_source.dart';
import 'package:qpets_app/ui/pages/calendar/event_editing_page.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/utils/ourPurple.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

MaterialColor ourPurlple = Palette.ourPurple;

class CalendarWidget extends StatelessWidget {
  EventController controller = Get.find<EventController>();

  CalendarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.outfitTextTheme(),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: ourPurlple,
          ),
        ),
        home: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              agendaViewHeight: 150,
              agendaItemHeight: 40,
              agendaStyle: AgendaStyle(
                dayTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              monthCellStyle: MonthCellStyle(
                backgroundColor: Color(0xFFEEECFC),
                trailingDatesBackgroundColor: Color(0xff216583),
                leadingDatesBackgroundColor: Colors.white,
                todayBackgroundColor: Color(0xFFC6BFFF),
              )),
          dataSource: EventDataSource(),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: const Color.fromARGB(255, 186, 171, 223),
          onTap: (details) {
            if (details.targetElement.name == "appointment") {
              controller.setDate(details.date!);
              if (details.appointments != null &&
                  details.appointments!.isNotEmpty) {
                showModalBottomSheet(
                  barrierColor: Colors.black.withOpacity(0.1),
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) =>
                      EventEditingPage(event: details.appointments!.first),
                );
              }
            }
          },
        ),
      );
    });
  }
}
