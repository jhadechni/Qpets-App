import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/produc_detail.dart';

import '../../controllers/authentication_controller.dart';
import '../../controllers/user_controller.dart';
import '../../domain/entities/product.dart';

class UserProducts extends StatefulWidget {
  const UserProducts({Key? key}) : super(key: key);

  @override
  State<UserProducts> createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  final AuthenticationController authentication = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
    userController.getProducts(authentication.getUid());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: _tittleText("Your Products")),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: _subtittleText(
                        "Touch the card to see the final product page.")),
              ),
              Expanded(child: Obx(() {
                if (userController.getProductsList.isNotEmpty) {
                  return ListView(
                    children: userController.getProductsList
                        .map((product) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: _cardProduct(product),
                            ))
                        .toList(),
                  );
                } else {
                  return const Text("No products found!");
                }
              })),
            ],
          ),
        ));
  }

  Widget _tittleText(text) {
    return Text(
      text,
      key: Key(text),
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subtittleText(text) {
    return Text(
      text,
      key: Key(text),
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 17,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
        key: Key(product.id.toString()),
        onTap: () => Get.to(() => ProductDetail(product: product),
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 250)),
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: 328,
            height: 145,
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffE2E2EC)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardImage(product.image),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _cardTitleText(trimName(product.name)),
                    _cardSubtitleText("for: ${product.type}"),
                    _cardPriceText(product.price)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: _cardButtonDelete(product.id),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _cardButtonDelete(String productid) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.highlight_remove_sharp),
            color: Colors.white,
            iconSize: 39,
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Alert,you want to delete your product from the marketplace?'),
                content: const Text('If you do this all the information of your product will be deleted and will no longer appear in the store.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {Navigator.pop(context, 'OK'), userController.deleteProducts(productid)},
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardImage(String link) {
    return Container(
        key: Key(link),
        width: 90,
        height: 180,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardTitleText(String text) {
    return Text(
      text,
      key: Key(text),
      style: const TextStyle(
        color: Color.fromRGBO(56, 53, 88, 1),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _cardSubtitleText(String text) {
    return Text(text,
        key: Key(text),
        style: const TextStyle(
          color: Color.fromRGBO(56, 53, 88, 1),
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.left);
  }

  Widget _cardPriceText(String text) {
    return Text("$text COP",
        key: Key(text),
        style: const TextStyle(
          color: Color.fromRGBO(56, 53, 88, 1),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left);
  }

  String trimName(String name) {
    try {
      var splitted = name.split(' ');
      String trimmedName = splitted[0] + " " + splitted[1] + '...';
      return trimmedName;
    } catch (e) {
      return name;
    }
  }
}
