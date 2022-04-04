import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/product.dart';

class User {
  String name;
  String pic;
  String age;
  String email;
  String gender;
  String phone;
  String address;
  List<PetProfileFields> pets = [];
  List<Product> productsales = [];

  User(this.name, this.pic, this.age, this.email, this.gender, this.phone,
      this.address);

  setPets(List<PetProfileFields> petsProfiles) {
    pets = petsProfiles;
  }
}
