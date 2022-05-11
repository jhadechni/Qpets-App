/// CurrentAge: auto-generated
class PetProfileFields {
  static const baseUrl = "https://qpets.herokuapp.com/products/getPetInfo";
  String id;
  String gender;
  String name;
  String type;
  String breed;
  bool vaccineCheck;
  String weight;
  bool chipCheck;
  bool neutered;
  String imgUrl;
  DateTime dob;
  PetProfileFields(
      {required this.id,
      required this.gender,
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
        id: json["_id"],
        gender: json["gender"],
        name: json["name"],
        type: json["type"],
        breed: json["breed"],
        weight: json["weight"],
        dob: DateTime.parse(json["dob"]),
        imgUrl: json["image"]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = imgUrl;
    data['dob'] = dob.toString();
    data['type'] = type;
    data['breed'] = breed;
    data['gender'] = gender;
    data['weight'] = weight;
    return data;
  }
}
