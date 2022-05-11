import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/repositories/pet_repository.dart';

class PetProfileController extends GetxController {
  PetRepository _repository = Get.find<PetRepository>();
  /*  final profileFields = PetProfileFields(
          id: "0",
          gender: "Male",
          name: 'polar',
          type: "Dog",
          breed: "Siberian Husky",
          weight: 20,
          dob: DateTime.utc(2021, 10, 20),
          imgUrl: "https://i.imgur.com/BpG6vSU.jpg")
      .obs; */
  Future<PetProfileFields> fetchPetInfo(String id) {
    return _repository.fetchPetInfo(id);
  }
}
