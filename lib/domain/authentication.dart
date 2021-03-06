import 'package:get/get.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
 
import '../data/reposito/local_preferences.dart';

class Authentication {
  final _sharedPreferences = LocalPreferences();
  final AuthenticationController auht = Get.find();

  Future<bool> get init async =>
      await _sharedPreferences.retrieveData<bool>('logged') ?? false;

  Future<bool> login(user, password) async {
      
 
       
      await _sharedPreferences.storeData<bool>('logged', true);
      
     
      return Future.value(true);

    
 
  }

  Future<void> signup(user, password,numero,correo,address,gender) async {
 
    await _sharedPreferences.storeData<String>('user', user);
    await _sharedPreferences.storeData<String>('password', password);
     await _sharedPreferences.storeData<String>('numero', numero);
      await _sharedPreferences.storeData<String>('correo', correo);
     await _sharedPreferences.storeData<String>('address', address);
     await _sharedPreferences.storeData<String>('gender', gender);
  }

  void logout() async {
 
    await _sharedPreferences.storeData<bool>('logged', false);
  }
}