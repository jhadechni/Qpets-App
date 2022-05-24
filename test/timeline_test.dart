import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/ui/pages/timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'test_utils.dart';

final pet = PetProfileFields(
    id: "3",
    ownerUid: "123",
    gender: 'male',
    name: 'Bolt',
    type: 'dog',
    breed: 'Siberian Husky',
    weight: "20.0",
    dob: DateTime.utc(2021, 3, 10),
    imgUrl: "");

void main() {
  setUp(() {
    Get.put<TimelineController>(TimelineController());
  });
  tearDown(() {
    Get.delete<TimelineController>();
  });
  testWidgets('Timeline Renders', (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      pet: pet,
      key: Key("timeline"),
    )));
    expect(find.byKey(Key("timeline")), findsOneWidget);
  });
  testWidgets("Timeline defaults 7 Elements", (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      pet: pet,
      key: Key("timeline"),
    )));
    expect(find.byType(TimelineTile), findsNWidgets(7));
  });
  testWidgets("Add Event working", (WidgetTester tester) async {
    await tester.pumpWidget(wrapPage(TimeLine(
      pet: pet,
      key: Key("timeline"),
    )));
    final controller = Get.find<TimelineController>();
    controller.addEvent("Test1", "TestDesc", DateTime.now(), "123");
    await tester.pump();
    expect(find.byType(TimelineTile), findsNWidgets(8));
    expect(find.text("Test1"), findsOneWidget);
  });
}
