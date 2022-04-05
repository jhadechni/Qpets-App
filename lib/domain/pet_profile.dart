/// CurrentAge: auto-generated
class PetProfileFields {
  String gender;
  String name;
  String type;
  String breed;
  bool vaccineCheck;
  double weight;
  bool chipCheck;
  bool neutered;
  String imgUrl;
  DateTime dob;
  PetProfileFields(
      {required this.gender,
      required this.name,
      required this.type,
      required this.breed,
      this.vaccineCheck = false,
      required this.weight,
      this.chipCheck = false,
      this.neutered = false,
      required this.dob,
      required this.imgUrl});
}
