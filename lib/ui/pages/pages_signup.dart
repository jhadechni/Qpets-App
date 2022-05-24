import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/authentication_controller.dart';
import '../../domain/authentication.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    Authentication controller = Get.find();
    AuthenticationController authentication = Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController sexo = TextEditingController();
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
                      onTap: () => Get.to(const LoginPage()),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.arrow_back, size: 40),
                      )),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        _formField("Name", "", 3, name),
                        _formField("email", "", 1, email),
                        _formField(
                            "Phone number", "1234567890", 4, phoneNumber),
                        _formField("Password", "", 2, password),
                        _formField("Confirm password", "", 5, confirmPassword),
                        _formField("Address", "", 3, address),
                        _formField("Gender", "", 3, sexo),
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
                              email.text,
                              password.text,
                              confirmPassword.text,
                              authentication,
                              controller);
                        }
                      },
                      color: const Color(0xFF7F77C6),
                      minWidth: 280,
                      height: 60,
                      child: const Text(
                        "Sign Up",
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
  }

  Widget _formField(String placeholder, String hint, int op,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
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
            return "${placeholder.toLowerCase()} couldnt be empty";
          }
          return null;
        },
      ),
    );
  }

  void comprueba(
      String nombre,
      String numero,
      String correo,
      String password,
      String confirmPassword,
      AuthenticationController authetication,
      Authentication controller) {
    if (password == confirmPassword) {
      controller.signup(nombre, password, numero, correo);
      authetication.signUp(correo, password, numero, nombre, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords dont match')));
    }
  }
}
