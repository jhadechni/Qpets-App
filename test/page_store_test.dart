import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/ui/pages/page_store.dart';

import 'test_utils.dart';

void main() {
  setUp(() {
    Get.put<ProductController>(ProductController());
  });
  tearDown(() {
    Get.delete<ProductController>();
  });
  testWidgets('Store pege Renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(wrapPage(
         const PageStore(key: Key("storepage")),
        )));
    expect(find.byKey(const Key("storepage")), findsOneWidget);
  });

  testWidgets('Pet Category text renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(wrapPage(
         const PageStore(key: Key("storepage")),
        )));
    expect(find.text("Pet Categories"), findsOneWidget);
    
  });
  testWidgets('Our product text renders', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(wrapPage(
         const PageStore(key: Key("storepage")),
        )));
    expect(find.text("Our Products"), findsOneWidget);
    
  });

   testWidgets('Product cards render', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(wrapPage(
         const PageStore(key: Key("storepage")),
        )));
    expect(find.byKey(const Key("0")), findsOneWidget);
    expect(find.byKey(const Key("1")), findsOneWidget);
  });
  
}
