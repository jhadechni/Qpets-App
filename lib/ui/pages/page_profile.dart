import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';

import '../../domain/product.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);
  @override
  State<PageProfile> createState() => PageProfileState();
}

class PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: profileImage()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Perdo Pérez',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
                  Icon(
                    Icons.create_outlined,
                    color: Color(
                      0xFF8E6FD8,
                    ),
                    size: 25.0,
                  )
                ],
              ),
              const Text('20 years',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15)),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  height: 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color.fromARGB(255, 226, 226, 236),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                  child: ProfileField(
                                field: "Email",
                                value: "pperez@qpets.com",
                              )),
                              Expanded(
                                  child: ProfileField(
                                field: "Gender",
                                value: "Male",
                              ))
                            ],
                          ),
                          Row(children: const [
                            Expanded(
                                child: ProfileField(
                              field: "Phone",
                              value: "300-526-878",
                            )),
                            Expanded(
                                child: ProfileField(
                              field: "Address",
                              value: "Cra 67 #69-08",
                            ))
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Your Pets',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 30)),
                          ),
                          Icon(
                            Icons.add_circle_outline_outlined,
                            color: Color(
                              0xFF8E6FD8,
                            ),
                            size: 25.0,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _petProfileCard('Firulais', '2 years', 'dog',
                              'https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                          _petProfileCard('Diomedes', '3 months', 'brid',
                              'https://images.unsplash.com/photo-1444464666168-49d633b86797?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _petProfileCard('Pólar', '1 year', 'dog',
                              'https://images.unsplash.com/photo-1547407139-3c921a66005c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                          _petProfileCard('Bolt', '9 months', 'dog',
                              'https://images.unsplash.com/photo-1590419690008-905895e8fe0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=736&q=80'),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('My Products',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 30)),
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Color(
                              0xFF8E6FD8,
                            ),
                            size: 25.0,
                          )
                        ],
                      ),
                      _cardProduct(Product(
                          0,
                          "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
                          "Fresh Kisses",
                          "16 Jan 2022",
                          "200"))
                    ],
                  )),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _petProfileCard(String name, String age, String breed, String link) {
    return GestureDetector(
        onTap: (() => Get.to(
              () => const PetProfile(),
              transition: Transition.cupertinoDialog,
              duration: const Duration(milliseconds: 250),
            )),
        child: SizedBox(
            height: 100,
            width: 180,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xffE2E2EC),
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(link), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10))),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Color.fromRGBO(56, 53, 88, 1),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(age,
                            style: const TextStyle(
                              color: Color.fromRGBO(127, 119, 198, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left),
                        Text(breed,
                            style: const TextStyle(
                              color: Color.fromRGBO(127, 119, 198, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget profileImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80"),
          radius: 60.0,
        )
      ],
    );
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
        onTap: () => Get.to(() => {}),
        child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: 228,
              height: 132,
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffE2E2EC)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cardImage(product.image),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cardTitleText(product.name),
                      _cardSubtitleText(product.storeName),
                      _cardPriceText(product.price)
                    ],
                  )
                ],
              ),
            )));
  }

  Widget _cardImage(String link) {
    return Container(
        width: 80,
        height: 160,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardTitleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(127, 119, 198, 1),
        fontSize:20,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _cardSubtitleText(String text) {
    return Text(text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.left);
  }

  Widget _cardPriceText(String text) {
    return Text("$text USD",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left);
  }
}

class ProfileField extends StatelessWidget {
  final String field;
  final String value;
  const ProfileField({Key? key, required this.field, required this.value})
      : super(key: key);
  final fieldStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 16.0, color: Color(0xff383558));
  final fieldValueStyle = const TextStyle(
      fontWeight: FontWeight.w300, fontSize: 16.0, color: Color(0xff717171));
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(field, style: fieldStyle),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        Text(value, style: fieldValueStyle)
      ]),
    );
  }
}
