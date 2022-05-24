import 'package:get/get.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/repositories/pet_repository.dart';
import 'package:qpets_app/domain/use_case/pets.dart';

class PetController extends GetxController {
  PetsUseCase _useCase = Get.find<PetsUseCase>();
  AuthenticationController _auth = Get.find<AuthenticationController>();
  final pets = <PetProfileFields>[].obs;
  PetController() {
    fetchAll(_auth.getUid());
  }
  Future<void> fetchAll(String uid) async {
    final result = await _useCase.fetchAllPets(uid);
    pets.value = result;
    pets.refresh();
  }

  Future<PetProfileFields> getPet(String id) async {
    final pet = await _useCase.getPet(id);
    return pet;
  }

  Future<void> addPet(Map<String, dynamic> data) async {
    await _useCase.addPet(data);
  }
}
