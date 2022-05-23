import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetForm extends StatefulWidget {
  PetForm({Key? key}) : super(key: key);

  @override
  State<PetForm> createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController name = TextEditingController();
    TextEditingController image = TextEditingController();
    TextEditingController breed = TextEditingController();
    TextEditingController type = TextEditingController();
    TextEditingController gender = TextEditingController();
    TextEditingController weight = TextEditingController();
    TextEditingController chipCheck = TextEditingController();
    TextEditingController vaccineCheck = TextEditingController();
    TextEditingController spayedAndNeutered = TextEditingController();
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
                  const Text(
                    "Add new Pet",
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
                        _formField("Image", "", 3, image),
                        _formField("Breed", "", 3, breed),
                        _formField("Type", "", 3, type),
                        _formField("Gender", "", 3, gender),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("valid");
                      }},
                      color: const Color(0xFF7F77C6),
                      minWidth: 280,
                      height: 60,
                      child: const Text(
                        "Regístrate",
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
          return null;
        },
      ),
    );
  }
}
