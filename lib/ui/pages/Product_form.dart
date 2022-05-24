import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qpets_app/controllers/authentication_controller.dart';
import 'package:qpets_app/domain/entities/product.dart';
import 'package:qpets_app/domain/use_case/products.dart';

class Productform extends StatefulWidget {
  const Productform({Key? key}) : super(key: key);

  @override
  State<Productform> createState() => _ProductformState();
}

class _ProductformState extends State<Productform> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController type = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController storename = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController facebook = TextEditingController();
    TextEditingController instagram = TextEditingController();
     TextEditingController image = TextEditingController();
    ProductsUseCase useCase = Get.find();
    AuthenticationController authController = Get.find();

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
                    "Add a product",
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
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 10,
                            children: [
                              _filterCard("Dog", FontAwesomeIcons.dog,
                                  const Color.fromRGBO(64, 142, 234, 1), type),
                              _filterCard("Cat", FontAwesomeIcons.cat,
                                  const Color.fromRGBO(140, 2, 248, 1), type),
                              _filterCard("Bird", FontAwesomeIcons.dove,
                                  const Color.fromRGBO(246, 166, 65, 1), type),
                              _filterCard("Fish", FontAwesomeIcons.fish,
                                  const Color.fromRGBO(251, 68, 68, 1), type),
                            ],
                          ),
                        ),
                        _formField("Name", "", 1, name),
                        _formField("Storename", "", 2, storename),
                        _formField("Image", "https://linkimage.jpg", 3, image),
                        _formField("Price", "12.000", 3, price),
                        _formField("Description", "", 4, description),
                        _formField("Facebook", "", 5, facebook),
                        _formField("Instagram", " ", 6, instagram),
                        _formField("Phone", "123456", 3, phone)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Product p = Product(
                            id: price.text + name.text,
                            description: description.text,
                            name: name.text,
                            image: image.text,
                            storeName: storename.text,
                            phoneNumber: phone.text,
                            facebook: facebook.text,
                            instagram: instagram.text,
                            price: price.text,
                            type: type.text,
                            ownerId: authController.getUid(),
                          );
                          useCase.addProduct(p);
                          Get.back();
                        }
                      },
                      color: const Color(0xFF7F77C6),
                      minWidth: 280,
                      height: 60,
                      child: const Text(
                        "New product",
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

  Widget _filterCard(String text, IconData icon, Color color,
      TextEditingController textcontroller) {
    return GestureDetector(
      key: Key(text),
      onTap: () {
        textcontroller.text = text;
      },
      child: Container(
        width: 81,
        height: 114,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(100),
                blurRadius: 3,
                spreadRadius: 3,
                offset: const Offset(
                  0,
                  2,
                ),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.elliptical(46, 43)),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                  ),
                  BoxShadow(
                    color: color,
                    spreadRadius: -20,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _formField(String placeholder, String hint, int op,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: TextFormField(
        controller: controller,
        keyboardType: (op == 3) ? TextInputType.phone : TextInputType.text,
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
