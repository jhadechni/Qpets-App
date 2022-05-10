import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../domain/product.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: HawkFabMenu(
          icon: AnimatedIcons.menu_arrow,
          items: [
            HawkFabMenuItem(
              label: 'Facebook',
              ontap: () async {
               await launchUrlString("https://facebook.com");
              },
              icon: const Icon(
                FontAwesomeIcons.facebookSquare,
              ),
              color: const Color(0xFF7F77C6),
              labelColor: Colors.black,
            ),
            HawkFabMenuItem(
              label: 'Phone',
              ontap: () {
                _makePhoneCall("123456");
              },
              icon: const Icon(Icons.phone),
              labelColor: Colors.black,
            ),
            HawkFabMenuItem(
              label: 'Instagram',
              ontap: () async {
                await launchUrlString("https://instagram.com");
              },
              icon: const Icon(
                FontAwesomeIcons.instagram,
              ),
            ),
          ],
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _productImage(product.image),
              Column(
                children: [
                  _tittleText(product.name),
                  _storeNameText(product.storeName),
                  _storeNameText("for: ${product.type}"),
                  _textPrice("${product.price} COP"),
                  _textDescription(product.description),
                ],
              )
            ],
          )),
        ));
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
        width: 400,
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
