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
import 'package:qpets_app/utils/ourPurple.dart';
import 'controllers/authentication_controller.dart';
import 'domain/authentication.dart';
import 'domain/repositories/place_repository.dart';
import 'domain/use_case/places.dart';

MaterialColor ourPurlple = Palette.ourPurple;

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
    Get.lazyPut(() => PetRepository(), fenix: true);
    Get.lazyPut(() => PetsUseCase(), fenix: true);
    Get.lazyPut(() => PetController(), fenix: true);

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
            textTheme: GoogleFonts.outfitTextTheme(),
            primarySwatch: Palette.ourPurple)));
  });
}
