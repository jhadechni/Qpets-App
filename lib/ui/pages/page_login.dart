import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/domain/authentication.dart';
import 'package:qpets_app/ui/pages/pages_signup.dart';

import '../../controllers/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Authentication controller = Get.find();
    AuthenticationController authentication = Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  _cardImagepet("assets/images/Corgi_logo_1.png"),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Qpets App",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        _formField("Email", "example@example.com",
                            1, email),
                        _formField("Password", "", 2, password),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login(controller, authentication, email.text,
                              password.text);
                        }
                      },
                      color: const Color(0xFF7F77C6),
                      minWidth: 280,
                      height: 60,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't you have an account?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(const SingupPage()),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF7F77C6),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
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
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
      child: TextFormField(
        obscureText: op == 2 ? true : false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: placeholder,
        ),
        validator: (t) {
          if (t!.isEmpty) {
            return "Debe ingresar ${placeholder.toLowerCase()}";
          }
          return null;
        },
      ),
    );
  }

  Widget _cardImagepet(String link) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Center(
            child: Image(
          image: AssetImage(link),
          fit: BoxFit.fill,
        )));
  }

  void login(Authentication controller, AuthenticationController authentication,
      String email, String password) {
    controller.login(email, password);
    authentication.login(email, password);
  }
}
