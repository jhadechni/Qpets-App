import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/products_controller.dart';
import 'package:qpets_app/ui/pages/produc_detail.dart';
import '../../domain/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/search_bar.dart';

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
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SearchBar(
                (function) => {print(function)}, "Search for a Product"),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: _tittleText("Pet Categories")),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _filterCard("Dog", FontAwesomeIcons.dog,
                    const Color.fromRGBO(64, 142, 234, 1)),
                _filterCard("Cat", FontAwesomeIcons.cat,
                    const Color.fromRGBO(140, 2, 248, 1)),
                _filterCard("Bird", FontAwesomeIcons.crow,
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
          Expanded(
              child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  itemCount: _productController.filteredList.length,
                  itemBuilder: (context, index) {
                    return _cardProduct(_productController.filteredList[index]);
                  }))),
        ],
      ),
    );
  }

  Widget _tittleText(text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _filterCard(String text, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _productController.changeFilter(text);
        _productController.filterCategory(text);
      },
      child: Container(
        width: 81,
        height: 100,
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
        onTap: () => Get.to(
            () => ProductDetail(
                product.image, product.name, product.storeName, product.price),
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 250)),
        child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: 328,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        style: const TextStyle(
          color: Color.fromRGBO(127, 119, 198, 1),
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.left);
  }

  Widget _cardPriceText(String text) {
    return Text("$text USD",
        style: const TextStyle(
          color: Color.fromRGBO(127, 119, 198, 1),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left);
  }
}
