import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:qpets_app/controllers/pet_profile_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'test_utils.dart';

void main() {
  setUp(() {
    Get.put<PetProfileController>(PetProfileController());
    Get.put<TimelineController>(TimelineController());
  });
  tearDown(() {
    Get.delete<PetProfileController>();
    Get.delete<TimelineController>();
  });
  testWidgets('PetProfile Renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PetProfile(
              key: Key("pet-profile"),
            ))));

    expect(find.byKey(Key("pet-profile")), findsOneWidget);
  });
  testWidgets("PetProfile renders 5 timeline events",
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PetProfile(
              key: Key("pet-profile"),
            ))));

    expect(find.byType(TimelineTile), findsNWidgets(5));
  });
}
