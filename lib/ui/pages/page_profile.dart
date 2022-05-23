import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/domain/authentication.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/user.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:qpets_app/ui/pages/page_userproducts.dart';
import 'package:qpets_app/ui/pages/pet_form.dart';
import 'package:qpets_app/ui/pages/pet_profile.dart';
import 'package:qpets_app/ui/pages/produc_detail.dart';
import '../../controllers/authentication_controller.dart';
import '../../domain/entities/product.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);
  @override
  State<PageProfile> createState() => PageProfileState();
}

class PageProfileState extends State<PageProfile> {
  @override
  void initState() {
    super.initState();
  }

  UserController userController = Get.find<UserController>();
  AuthenticationController authentication =
      Get.find<AuthenticationController>();
  Authentication controller = Get.find<Authentication>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: userController.fetchUserData(authentication.getUid()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => SafeArea(
                    child: SingleChildScrollView(
                        child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () => logout(authentication, controller),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.logout, size: 25),
                            )),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: profileImage(snapshot.data!.pic)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 30))
                          ],
                        ),
                        Text('${snapshot.data!.age} years',
                            style: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            height: 200,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: ProfileField(
                                                field: "Email",
                                                value: snapshot.data!.email,
                                              )),
                                              Expanded(
                                                  child: ProfileField(
                                                field: "Gender",
                                                value: snapshot.data!.gender,
                                              ))
                                            ],
                                          ),
                                          Row(children: [
                                            Expanded(
                                                child: ProfileField(
                                              field: "Phone",
                                              value: snapshot.data!.phone,
                                            )),
                                            Expanded(
                                                child: ProfileField(
                                              field: "Address",
                                              value: snapshot.data!.address,
                                            ))
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Your Pets',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30)),
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.to(() => PetForm()),
                                      child: const Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: Color(
                                          0xFF8E6FD8,
                                        ),
                                        size: 25.0,
                                      ),
                                    )
                                  ],
                                ),
                                userController.pets.isEmpty
                                    ? Center(child: Text("Come on, add a new pet!"))
                                    : GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        childAspectRatio: (290 / 180),
                                        children: userController.pets
                                            .map((pet) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: _petProfileCard(pet),
                                                ))
                                            .toList(),
                                      )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text('My Products',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30)),
                                    ),
                                    GestureDetector(
                                        onTap: () =>
                                            Get.to(const UserProducts()),
                                        child: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Color(
                                              0xFF8E6FD8,
                                            ),
                                            size: 25.0,
                                          ),
                                        ),
                                  ],
                                ),
                                //_cardProduct(userController.productsSale.first)
                              ],
                            )),
                      ],
                    ),
                  ],
                ))));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else {
            return Center(child: Text("Loading..."));
          }
        });
  }

  Widget _petProfileCard(PetProfileFields pet) {
    return GestureDetector(
        key: const Key('pet-profile-card'),
        onTap: (() => Get.to(
              () => PetProfile(pet: pet),
              transition: Transition.cupertinoDialog,
              duration: const Duration(milliseconds: 250),
            )),
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
                          image: NetworkImage(pet.imgUrl), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10))),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: const TextStyle(
                        color: Color.fromRGBO(56, 53, 88, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(DateTime.now().difference(pet.dob).inDays.toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 119, 198, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left),
                    Text(pet.breed,
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 119, 198, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left),
                  ],
                ),
              )
            ],
          ),
        ));
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

  Widget _cardProduct(Product product) {
    return GestureDetector(
        key: const Key('product-card'),
        onTap: () => Get.to(() => ProductDetail(product: product),
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 250)),
        child: Container(
          width: 240,
          height: 102,
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffE2E2EC)),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              _cardImage(product.image),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _cardTitleText(product.name),
                  _cardSubtitleText(product.storeName),
                  _cardPriceText(product.price)
                ],
              )
            ],
          ),
        ));
  }

  Widget _cardImage(String link) {
    return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(link), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardTitleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(127, 119, 198, 1),
        fontSize: 20,
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

  void logout(
      AuthenticationController authentication, Authentication controller) {
    controller.logout();
    authentication.logout();
    Get.to(LoginPage());
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
      fontWeight: FontWeight.w300, fontSize: 14.0, color: Color(0xff717171));
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
