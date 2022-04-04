import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/ui/pages/timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'test_utils.dart';

void main() {
  setUp(() {
    Get.put<TimelineController>(TimelineController());
  });
  tearDown(() {
    Get.delete<TimelineController>();
  });
  testWidgets('Timeline Renders', (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      key: Key("timeline"),
    )));
    expect(find.byKey(Key("timeline")), findsOneWidget);
  });
  testWidgets("Timeline defaults 7 Elements", (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      key: Key("timeline"),
    )));
    expect(find.byType(TimelineTile), findsNWidgets(7));
  });
  testWidgets("Add Event working", (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      key: Key("timeline"),
    )));
    final controller = Get.find<TimelineController>();
    controller.addEvent("Test1", "TestDesc", DateTime.now());
    await tester.pump();
    expect(find.byType(TimelineTile), findsNWidgets(8));
    expect(find.text("Test1"), findsOneWidget);
  });
}
