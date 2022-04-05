import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../domain/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail(this.product, {Key? key}) : super(key: key);
  final Product product;
  final String description =
      "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum LoremLorem ipsum Lorem ipsum Lorem ipsum Lorem";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [_banner(80), _customAppBar()],
            ),
            _productImage(product.image),
            Column(
              children: [
                _tittleText(product.name),
                _storeNameText(product.storeName),
                _storeNameText("for: ${product.type}"),
                _textPrice("${product.price} USD"),
                _textDescription(description),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FontAwesomeIcons.facebookSquare,
                        size: 60,
                        color: Color(0xFF7F77C6),
                      ),
                      Icon(FontAwesomeIcons.squarePhone,
                          size: 60, color: Color(0xFF7F77C6)),
                      Icon(FontAwesomeIcons.instagramSquare,
                          size: 60, color: Color(0xFF7F77C6))
                    ]))
          ],
        )),
      ),
    );
  }

  Widget _tittleText(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(56, 53, 88, 1),
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _storeNameText(String text) {
    return Text(text,
        style: const TextStyle(
          color: Color.fromRGBO(127, 119, 198, 1),
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ));
  }

  Widget _textPrice(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(127, 119, 198, 1),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _textDescription(String text) {
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(151, 151, 162, 1),
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ));
  }

  Widget _productImage(String imageLink) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
          width: 317,
          height: 310,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: NetworkImage(imageLink), fit: BoxFit.fitWidth))),
    );
  }

  Widget _banner(double bannerHeight) {
    return Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Color(0xFF7F77C6),
      ),
    );
  }

  Widget _customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}
