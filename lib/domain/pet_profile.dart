/// CurrentAge: auto-generated

enum Gender { M, F }
enum Type { dog, cat, bird, hamster }

class PetProfile {
  Gender gender;
  Type type;
  String breed;
  bool vaccineCheck;
  double weight;
  bool chipCheck;
  bool neutered;
  String imgUrl;
  PetProfile(
      {required this.gender,
      required this.type,
      required this.breed,
      this.vaccineCheck = false,
      required this.weight,
      this.chipCheck = false,
      this.neutered = false,
      required this.imgUrl});
}
