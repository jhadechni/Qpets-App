import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/user.dart';

import '../domain/entities/product.dart';

class UserController extends GetxController {
  PetController _petController = Get.find<PetController>();

  List<PetProfileFields> get pets => _petController.pets;

  RxList<Product> productsSale = <Product>[].obs;

  Future<User> fetchUserData(String uid) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snap = await collection.doc("$uid").get();
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    data["Pic"] =
        "https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80";

    data["Age"] = "19";
    data["Gender"] = "male";
    data["Address"] = "Cra 67 #69-13";
    return User.fromJson(data);
  }
}
