import 'package:flutter/material.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/controllers/pet_profile_controller.dart';
import 'package:qpets_app/controllers/place_controller.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/ui/pages/page_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_config/flutter_config.dart';

class Palette {
  static const MaterialColor ourPurple = MaterialColor(
    0xFF8E6FD8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x8064c2), //10%
      100: Color(0x7259ad), //20%
      200: Color(0x634e97), //30%
      300: Color(0x554382), //40%
      400: Color(0x47386c), //50%
      500: Color(0x392c56), //60%
      600: Color(0x2b2141), //70%
      700: Color(0x1c162b), //80%
      800: Color(0x0e0b16), //90%
      900: Color(0x000000), //100%
    },
  );
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(PlaceController());
    Get.put(UserController());
    Get.put(EventController());
    Get.lazyPut(() => TimelineController(), fenix: true);
    Get.lazyPut(() => PetProfileController(), fenix: true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(GetMaterialApp(
      initialBinding: InitialBinding(),
      home: const Pagesplash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          primarySwatch: Colors.purple)));
}
