import 'package:flutter/material.dart';
import 'package:qpets_app/controllers/pet_profile_controller.dart';
import 'package:qpets_app/controllers/place_controller.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/ui/pages/page_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_config/flutter_config.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(PlaceController());
    Get.put(UserController());
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
