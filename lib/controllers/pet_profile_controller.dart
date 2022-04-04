import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';

class PetProfileController extends GetxController {
  final profileField = PetProfileFields(
          gender: "Male",
          name: 'polar',
          type: "Dog",
          breed: "Siberian Husky",
          weight: 20,
          dob: DateTime.utc(2021, 10, 20),
          imgUrl: "https://i.imgur.com/BpG6vSU.jpg")
      .obs;
}
