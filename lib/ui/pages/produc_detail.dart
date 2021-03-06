import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qpets_app/main.dart';
import 'package:qpets_app/utils/ourPurple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../domain/entities/product.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import '../../utils/ourPurple.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[
            _facebookBubble(product.facebook),
            _instagramBubble(product.instagram),
            _phoneBubble(product.phoneNumber)
          ],
          colorStartAnimation: Palette.ourPurple,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
      appBar: AppBar(),
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
    );
  }

  Widget _tittleText(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
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
          textAlign: TextAlign.center,
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

  Widget _facebookBubble(String link) {
    return FloatingActionButton(
      onPressed: () => launchUrlString(link),
      heroTag: "btn1",
      tooltip: 'First button',
      focusColor: Colors.blue,
      hoverColor: Colors.blue,
      backgroundColor: Colors.blue,
      child: const Icon(FontAwesomeIcons.facebook),
    );
  }

  Widget _instagramBubble(String link) {
    return FloatingActionButton(
      onPressed: () => launchUrlString(link),
      heroTag: "btn2",
      tooltip: 'First button',
      focusColor: Palette.ourPurple,
      hoverColor: Palette.ourPurple,
      backgroundColor: Colors.deepPurple,
      child: const Icon(FontAwesomeIcons.instagram),
    );
  }

  Widget _phoneBubble(String phone) {
    return FloatingActionButton(
      onPressed: () => _makePhoneCall(phone),
      heroTag: "btn3",
      tooltip: 'First button',
      focusColor: Colors.green,
      hoverColor: Colors.green,
      backgroundColor: Colors.green,
      child: const Icon(FontAwesomeIcons.phone),
    );
  }
}
