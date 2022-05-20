import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/repositories/pet_repository.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';

class PetsUseCase {
  PetRepository repository = Get.find<PetRepository>();

  //fetch all pets and save them
  Future<List<PetProfileFields>> getAllPets(String uid) async {
    List<PetProfileFields> pets = await repository.getAllPets();
    if (pets.isEmpty) {
      pets = await repository.fetchAllPets(uid);
      await repository.storePets(pets);
    }
    return pets;
  }

  Future<bool> addPet(PetProfileFields pet) async {
    final success = await repository.addRemotePet(pet);
    if (success) {
      await repository.addPet(pet);
      return true;
    }
    return false;
  }

  Future<PetProfileFields> getPet(String id) {
    return repository.getPetInfo(id);
  }
}
