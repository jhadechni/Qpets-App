import 'package:flutter/material.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/controllers/place_controller.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/domain/repositories/pet_repository.dart';
import 'package:qpets_app/domain/repositories/product_repository.dart';
import 'package:qpets_app/domain/use_case/pets.dart';
import 'package:qpets_app/domain/use_case/products.dart';
import 'package:qpets_app/ui/pages/page_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controllers/authentication_controller.dart';
import 'domain/authentication.dart';
import 'domain/repositories/place_repository.dart';
import 'domain/use_case/places.dart';

class Palette {
  static const MaterialColor ourPurple = MaterialColor(
    0xFF7F77C6, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x008064c2), //10%
      100: Color(0x007259ad), //20%
      200: Color(0x00634e97), //30%
      300: Color(0x00554382), //40%
      400: Color(0x0047386c), //50%
      500: Color(0x00392c56), //60%
      600: Color(0x002b2141), //70%
      700: Color(0x001c162b), //80%
      800: Color(0x000e0b16), //90%
      900: Color(0x00000000), //100%
    },
  );
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    //Products
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => ProductRepository(), fenix: true);
    Get.lazyPut(() => ProductsUseCase(), fenix: true);
    //Places
    Get.lazyPut(() => PlaceRepository(), fenix: true);
    Get.lazyPut(() => PlacesUseCase(), fenix: true);
    Get.lazyPut(() => PlaceController(), fenix: true);
    //User
    Get.lazyPut(() => UserController(), fenix: true);
    //Timeline
    Get.lazyPut(() => TimelineController(), fenix: true);
    //Pets
    Get.lazyPut(() => PetController(), fenix: true);
    Get.lazyPut(() => PetsUseCase(), fenix: true);
    Get.lazyPut(() => PetRepository(), fenix: true);

    //Auth
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => Authentication(), fenix: true);

    //Events
    Get.lazyPut(() => EventController(), fenix: true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  Firebase.initializeApp().then((value) {
    runApp(GetMaterialApp(
        initialBinding: InitialBinding(),
        home: const Pagesplash(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            primarySwatch: Palette.ourPurple)));
  });
}
