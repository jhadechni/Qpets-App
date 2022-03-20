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
    entries.add(Product(0, "https://pbs.twimg.com/media/ESc5JEQUUAAUJ1W.jpg",
        "Coringa", "DavidSolanoSA", "5"));
    entries.add(Product(0, "https://pbs.twimg.com/media/ESc5JEQUUAAUJ1W.jpg",
        "Arroz", "MercadoLibre", "9"));
        entries.add(Product(0, "https://pbs.twimg.com/media/ESc5JEQUUAAUJ1W.jpg",
        "Arroz", "MercadoLibre", "9"));
        entries.add(Product(0, "https://pbs.twimg.com/media/ESc5JEQUUAAUJ1W.jpg",
        "Arroz", "MercadoLibre", "9"));
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
                  padding: const EdgeInsets.all(8),
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

  Widget _filterCard(text, icon, color) {
    return Container(
      color: color,
      child: IconButton(onPressed: null, icon: Icon(icon)),
    );
  }

  Widget _cardProduct(product) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      color: Color(0xFF8E6FD8),
      child: SizedBox(
          width: 300,
          height: 150,
          child:
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, 
            children: [
            ClipRRect(
                  borderRadius: BorderRadius.horizontal(),
                  child: Image(
                    width: 150,
                    height: 300,
                    image: NetworkImage(
                        product.image),
                  ),
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              
              children: [
                Text(product.name,
                style: 
                const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30
                  )),
                Text(
                product.storeName, 
                style: const TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 20)),
                Text("${product.price} USD", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),)
              ],
            ),
            Column()
          ])),
    );
  }
}
