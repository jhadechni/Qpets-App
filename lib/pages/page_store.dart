import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/product.dart';

class page_store extends StatefulWidget {
  const page_store({Key? key}) : super(key: key);

  @override
  State<page_store> createState() => _page_storeState();
}

class _page_storeState extends State<page_store> {
  List<Product> entries = <Product>[];
  @override
  void initState() {
    entries.add(Product(0, "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
        "Product name", "Store name", "200"));
    entries.add(Product(1, "https://cdn.discordapp.com/attachments/833897513349021706/955338900002455642/unsplash_2hpiy9XuXC4.png",
        "Product name", "Store name", "200"));
    entries.add(Product(2, "https://cdn.discordapp.com/attachments/833897513349021706/955339290785742858/unsplash_FiQNJA-CND4.png",
        "Product name", "Store name", "200"));
    entries.add(Product(3, "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
        "Product name", "Store name", "200"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _tittleText("Pet Categories"),
          Row(
            children: [
              _filterCard("Dog", Icons.donut_large, Colors.red),
              _filterCard("Cat", Icons.donut_large, Colors.blue),
              _filterCard("Fish", Icons.donut_large, Colors.amber),
              _filterCard("other", Icons.donut_large, Colors.green),
            ],
          ),
          _tittleText("Our Produts"),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    return _cardProduct(entries[index]);
                  })),
        ],
      )),
    );
  }

  Widget _tittleText(text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
    );
  }

  Widget _filterCard(String text, IconData icon, Color color) {
    return Container(
      color: color,
      child: IconButton(onPressed: null, icon: Icon(icon)),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child:Container(
      width: 328,
      height: 132,
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
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
    ));
  }

  Widget _cardImage(String link) {
    // Figma Flutter Generator Unsplashsm7ebvmgieWidget - RECTANGLE
    return Container(
        width: 110,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(link),fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(10)
        ));
  }

  Widget _cardTitleText(String text) {
    return Text(text,
        style: 
        const TextStyle(
        color: Color.fromRGBO(56, 53, 88, 1),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ), textAlign: TextAlign.left,);
  }

  Widget _cardSubtitleText(String text) {
    return Text(text,
        style: const 
        TextStyle(
        color: Color.fromRGBO(127, 119, 198, 1),    
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),textAlign: TextAlign.left);
  }

  Widget _cardPriceText(String text) {
    return Text(
      "$text USD",
      style: const  TextStyle(
        color: Color.fromRGBO(127, 119, 198, 1),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ), textAlign: TextAlign.left
    );
  }
}
