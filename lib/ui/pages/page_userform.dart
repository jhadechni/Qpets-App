import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import '../../controllers/authentication_controller.dart';
import '../../controllers/user_controller.dart';
import '../../domain/authentication.dart';
import '../../domain/user.dart';

class Pageuserform extends StatefulWidget {
  const Pageuserform({Key? key}) : super(key: key);

  @override
  State<Pageuserform> createState() => _PageuserformState();
}

class _PageuserformState extends State<Pageuserform> {
  @override
  void initState() {
    super.initState();
  }

  UserController userController = Get.find();
  AuthenticationController authentication = Get.find();
  Authentication controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController gender = TextEditingController();
    return FutureBuilder<User>(
        future: userController.fetchUserData(authentication.getUid()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () => Get.back(),
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Icon(Icons.arrow_back, size: 40),
                              )),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 0.0),
                                  child: profileImage(snapshot.data!.pic)),
                              Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                _formField("Nombre", "", 3, name),
                                _formField("Número teléfonico", "1234567890", 4,
                                    phoneNumber),
                                _formField(
                                    'Dirreción', 'Cra 23 #45-67', 6, address),
                                _formField('Sexo', '', 7, gender)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                    comprueba(
                              name.text,
                              phoneNumber.text,
                              address.text,
                              gender.text,
                              authentication,
                              controller,
                              );

                                }
                              },
                              color: const Color(0xFF7F77C6),
                              minWidth: 280,
                              height: 60,
                              child: const Text(
                                "Actualizar Datos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else {
            return Center(child: Text("Loading..."));
          }
        });
  }

  void comprueba(
      String nombre,
      String numero,
      String andress,
      String gender,
      AuthenticationController authetication,
      Authentication controller) {
      authetication.UpdateUsuario(nombre, numero, andress, gender);
    }
  }




Widget profileImage(String image) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage(image),
        radius: 60.0,
      )
    ],
  );
}

Widget _formField(
    String placeholder, String hint, int op, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
    child: TextFormField(
      obscureText: (op == 2 || op == 5) ? true : false,
      controller: controller,
      keyboardType: (op == 4) ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        labelText: placeholder,
      ),
      validator: (t) {
        if (t!.isEmpty) {
          return "Debe ingresar ${placeholder.toLowerCase()}";
        }
        if (op == 7) {
          if (t != 'male' && t != 'female') {
            return "male or female";
          }
        }
        return null;
      },
    ),
  );
}