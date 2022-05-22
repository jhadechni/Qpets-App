import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qpets_app/domain/entities/product.dart';

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
    final ImagePicker _picker = ImagePicker();
    TextEditingController type = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController storename = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController facebook = TextEditingController();
    TextEditingController instagram = TextEditingController();

    XFile? image;
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
                      GestureDetector(
                          onTap: () async => image = await _picker.pickImage(
                              source: ImageSource.gallery),
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Icon(Icons.add_a_photo, size: 40),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Text(
                          "   Add product",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
                        _formField("Nombre", "", 1, name),
                        _formField("Storename", "", 2, storename),
                        _formField("price", "12.000 ", 3, price),
                        _formField("Description", "", 4, description),
                        _formField("Facebook", "", 5, facebook),
                        _formField("instagram", " ", 6, instagram),
                        _formField("phone", "123456", 3, phone)
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
                              price.text,
                              storename.text,
                              description.text,
                              image,
                              type.text,
                              phone.text,
                              facebook.text,
                              instagram.text,
                              context);
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

  void comprueba(
      String name,
      String price,
      String storename,
      String description,
      XFile? imagen,
      String type,
      String phone,
      String facebook,
      String instagram,
      BuildContext context) {
    if (type != "") {
      if (imagen != null) {
        print(imagen);
        Product p = new Product(
          id: price + name,
          description: description,
          name: name,
          image: '',
          storeName: storename,
          phoneNumber: phone,
          facebook: facebook,
          instagram: instagram,
          price: price,
          type: type,
          ownerId: "ownerId",
        );
        print(p.image);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('record the image')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('record the type')));
    }
  }
}
