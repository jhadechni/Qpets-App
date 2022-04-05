import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/ui/pages/page_profile.dart';
import 'package:flutter/widgets.dart';
import 'test_utils.dart';



void main() {
  setUp(() {
    Get.put<UserController>(UserController());

  });
  tearDown(() {
    Get.delete<UserController>();
    
  });
  testWidgets('PageProfile Renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PageProfile(
              key: Key("user-profile"),
            ))));

    expect(find.byKey(Key("user-profile")), findsOneWidget);
  });
  testWidgets("PageProfile render pets list",
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PageProfile(
              key: Key("pet-profile"),
            ))));

    expect(find.byKey(Key('pet-profile-card')), findsNWidgets(4));
  });
  
  testWidgets("PageProfile render product Sales list",
      (WidgetTester tester) async {
    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(wrapPage(PageProfile(
              key: Key("pet-profile"),
            ))));
    expect(find.byKey(Key('product-card')), findsOneWidget);
  });
}