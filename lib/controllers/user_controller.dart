import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/user.dart';

import '../domain/entities/product.dart';
import '../domain/use_case/products.dart';

class UserController extends GetxController {
  AuthenticationController _authController =
      Get.find<AuthenticationController>();
  ProductsUseCase productsUseCase = Get.find();

  final userProfile = User(
    'Jaime Sierra',
    'https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
    '19',
    'jsierra2001@Qpets.com',
    'male',
    '3014868546',
    'Cra 67 #69-08',
  ).obs;
  // ignore: prefer_final_fields

  PetController _petController = Get.find<PetController>();

  List<PetProfileFields> get pets => _petController.pets;

  RxList<Product> productsSale = <Product>[].obs;

  Future<User> fetchUserData(String uid) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snap = await collection.doc("$uid").get();
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    data["Pic"] =
        "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png";
    data["Age"] = "19";
    data["Gender"] = data["Sexo"];
    data["Address"] = data["Direccion"];
    return User.fromJson(data);
  }
}
