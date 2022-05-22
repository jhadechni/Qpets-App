import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/main.dart';
import 'package:qpets_app/ui/pages/Product_form.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:qpets_app/ui/pages/produc_detail.dart';
import '../../domain/entities/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/search_bar.dart';
import '../../utils/ourPurple.dart';

class PageStore extends StatefulWidget {
  const PageStore({Key? key}) : super(key: key);

  @override
  State<PageStore> createState() => PageStoreState();
}

class PageStoreState extends State<PageStore> {
  final ProductController _productController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SearchBar(
                  placeholder: "Search for a Product",
                  onTextChangeCallback: (s) => _productController.runFilter(s)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: _tittleText("Pet Categories")),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 10,
                children: [
                  _filterCard("All", FontAwesomeIcons.angellist, Colors.grey),
                  _filterCard("Dog", FontAwesomeIcons.dog,
                      const Color.fromRGBO(64, 142, 234, 1)),
                  _filterCard("Cat", FontAwesomeIcons.cat,
                      const Color.fromRGBO(140, 2, 248, 1)),
                  _filterCard("Bird", FontAwesomeIcons.dove,
                      const Color.fromRGBO(246, 166, 65, 1)),
                  _filterCard("Fish", FontAwesomeIcons.fish,
                      const Color.fromRGBO(251, 68, 68, 1)),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: _tittleText("Our Products")),
            ),
            Expanded(child: Obx(() {
              if (_productController.filteredList.isNotEmpty) {
                if (_productController.sucess) {
                  return ListView(
                    children: _productController.filteredList
                        .map((product) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: _cardProduct(product),
                            ))
                        .toList(),
                  );
                } else {
                  return Text("Products couldnt be loaded!");
                }
              } else {
                return Text("No products found!");
              }
            })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),backgroundColor: Palette.ourPurple ,onPressed:(){
        Get.to(const Productform());
      }),
    );
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

  Widget _filterCard(String text, IconData icon, Color color) {
    return GestureDetector(
      key: Key(text),
      onTap: () {
        _productController.changeFilter(text);
        _productController.filterCategory(text);
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _cardTitleText(trimName(product.name)),
                      _cardSubtitleText(product.storeName),
                      _cardSubtitleText("for: ${product.type}"),
                      _cardPriceText(product.price)
                    ],
                  )
                ],
              ),
            )));
  }

  Widget _cardImage(String link) {
    return Container(
        key: Key(link),
        width: 110,
        height: 200,
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
          color: Color.fromRGBO(127, 119, 198, 1),
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.left);
  }

  Widget _cardPriceText(String text) {
    return Text("$text COP",
        key: Key(text),
        style: const TextStyle(
          color: Color.fromRGBO(127, 119, 198, 1),
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
