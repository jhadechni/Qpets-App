import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';
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
    Get.put<PetController>(PetController());
    Get.put<TimelineController>(TimelineController());
  });
  tearDown(() {
    Get.delete<PetController>();
    Get.delete<TimelineController>();
  });
  testWidgets('PetProfile Renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PetProfile(
              pet: pet,
              key: Key("pet-profile"),
            ))));

    expect(find.byKey(Key("pet-profile")), findsOneWidget);
  });
  testWidgets("PetProfile renders 5 timeline events",
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PetProfile(
              pet: pet,
              key: Key("pet-profile"),
            ))));

    expect(find.byType(TimelineTile), findsNWidgets(5));
  });
}
