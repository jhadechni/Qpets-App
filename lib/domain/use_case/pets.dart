import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/repositories/pet_repository.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';

class PetsUseCase {
  PetRepository repository = Get.find<PetRepository>();

  //fetch all pets and save themx
  Future<List<PetProfileFields>> fetchAllPets(String uid) async {
    List<PetProfileFields> pets = await repository.fetchAllPets(uid);
    await repository.storePets(pets);
    return pets;
  }

  Future<List<PetProfileFields>> getAllPets(String uid) async {
    List<PetProfileFields> pets = await repository.getAllPets(uid);
    return pets;
  }

  Future<PetProfileFields> addPet(Map<String, dynamic> data) async {
    try {
      final finalPet = await repository.addRemotePet(data);
      await repository.addPet(finalPet);
      return finalPet;
    } catch (e) {
      print("Error $e");
      return Future.error(e);
    }
  }

  Future<PetProfileFields> getPet(String id) {
    return repository.getPetInfo(id);
  }
}
