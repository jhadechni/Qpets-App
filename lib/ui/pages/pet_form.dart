import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/utils/ourPurple.dart';

class PetForm extends StatefulWidget {
  PetController petController = Get.find<PetController>();
  PetForm({Key? key}) : super(key: key);
  @override
  State<PetForm> createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController weight = TextEditingController();
  DateTime? pickedDate;
  bool chipCheck = false;
  bool vacinneCheck = false;
  bool neutered = false;
  AuthenticationController auth = Get.find();
  @override
  Widget build(BuildContext context) {
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
                        _formField(
                            "Image", "https://linktoimage.jpg", 3, image),
                        _dateTextField(context, "23/05/2022", dob),
                        _formField("Breed", "", 3, breed),
                        _formField("Type", "", 3, type),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    const Text("Chip Check"),
                                    Switch(
                                      value: chipCheck,
                                      activeColor: Palette.ourPurple,
                                      onChanged: (value) {
                                        setState(() {
                                          chipCheck = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    const Text("Vaccine Check"),
                                    Switch(
                                      value: vacinneCheck,
                                      activeColor: Palette.ourPurple,
                                      onChanged: (value) {
                                        setState(() {
                                          vacinneCheck = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    const Text("Neutered"),
                                    Switch(
                                      value: neutered,
                                      activeColor: Palette.ourPurple,
                                      onChanged: (value) {
                                        setState(() {
                                          neutered = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        _formField("Gender", "", 3, gender),
                        _formField("Weight", "", 3, weight),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitForm();
                          Get.back();
                        }
                      },
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

  Widget _dateTextField(
      BuildContext context, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            //do something
            pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime
                    .now(), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));
            controller.text = DateFormat("d/M/y").format(pickedDate!);
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_today,
                  color: const Color(0xff7F77C6)),
              hintStyle: const TextStyle(color: const Color(0xff8C99B1)),
              border: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xff7F77C6))),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              filled: true,
              fillColor: Colors.white,
              hintText: hintText)),
    );
  }

  Future<bool> submitForm() async {
    final map = <String, dynamic>{
      "name": name.text,
      "image": image.text,
      "dob": pickedDate,
      "breed": breed.text,
      "type": type.text,
      "chipCheck": chipCheck,
      "vaccineCheck": vacinneCheck,
      "spayedAndNeutered": neutered,
      "gender": gender.text,
      "weight": weight.text,
      "ownerId": auth.getUid()
    };
    await widget.petController.addPet(map);
    return true;
  }
}
