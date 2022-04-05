import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/ui/pages/page_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'test_utils.dart';

void main() {
  setUp(() {
    Get.put<EventController>(EventController());
  });
  tearDown(() {
    Get.delete<EventController>();
  });
  testWidgets('Calendar Renders', (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(CalendarPage(
      key: Key("calendar"),
    )));
    expect(find.byKey(const Key("calendar")), findsOneWidget);
  });
}