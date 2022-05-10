import 'package:get/get.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/user.dart';

import '../domain/entities/product.dart';

class UserController extends GetxController {
  final userProfile = User(
    'Jaime Sierra',
    'https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
    '19',
    'jsierra2001@Qpets.com',
    'male',
    '3014868546',
    'Cra 67 #69-08',
  ).obs;
  // ignore: prefer_final_fields
  RxList<PetProfileFields> pets = [
    PetProfileFields(
        gender: 'male',
        name: 'Firulais',
        type: 'dog',
        breed: 'Pug',
        weight: 10.0,
        dob: DateTime.utc(2019, 10, 20),
        imgUrl:
            'https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
    PetProfileFields(
        gender: 'male',
        name: 'Diomedes',
        type: 'bird',
        breed: 'Azulejo',
        weight: 0.8,
        dob: DateTime.utc(2022, 1, 20),
        imgUrl:
            'https://images.unsplash.com/photo-1444464666168-49d633b86797?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
    PetProfileFields(
        gender: 'male',
        name: 'polar',
        type: 'dog',
        breed: 'Siberian Husky',
        weight: 20.0,
        dob: DateTime.utc(2021, 6, 20),
        imgUrl:
            'https://images.unsplash.com/photo-1547407139-3c921a66005c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    PetProfileFields(
        gender: 'male',
        name: 'Bolt',
        type: 'dog',
        breed: 'Siberian Husky',
        weight: 20.0,
        dob: DateTime.utc(2021, 3, 10),
        imgUrl:
            'https://images.unsplash.com/photo-1590419690008-905895e8fe0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=736&q=80'),
  ].obs;

  RxList<Product> productsSale = <Product>[].obs;
}
