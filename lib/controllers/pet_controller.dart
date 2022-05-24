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
    getAll(_auth.getUid());
  }
  Future<void> getAll(String uid) async {
    final result = await _useCase.getAllPets(uid);
    pets.value = result;
    pets.refresh();
  }

  Future<PetProfileFields> getPet(String id) async {
    final pet = await _useCase.getPet(id);
    return pet;
  }
}
