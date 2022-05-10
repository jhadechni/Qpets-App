/// CurrentAge: auto-generated
class PetProfileFields {
  static const baseUrl = "https://qpets.herokuapp.com/pets";
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
  factory PetProfileFields.fromJson(Map<String, dynamic> json) {
    return PetProfileFields(
        gender: json["gender"],
        name: json["name"],
        type: json["type"],
        breed: json["breed"],
        weight: json["weight"],
        dob: DateTime.parse(json["dob"]),
        imgUrl: json["imgUrl"]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['name'] = name;
    data['type'] = type;
    data['breed'] = breed;
    data['weight'] = weight;
    data['dob'] = dob.toString();
    data['imgUrl'] = imgUrl;
    return data;
  }
}
