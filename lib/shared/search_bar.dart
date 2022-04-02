import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/products_controller.dart';

typedef SearchBarCallBack = void Function(String s);

class SearchBar extends StatelessWidget {
  final ProductController _productController = Get.find();
  final SearchBarCallBack _callback;
  final String _placeholder;
  final TextEditingController _controller = TextEditingController();
  SearchBar(this._callback, this._placeholder, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Stack(alignment: AlignmentDirectional.centerEnd, children: [
      TextField(
          style: const TextStyle(fontSize: 18),
          onChanged: ((value) => _callback(value)),
          autofocus: false,
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintStyle: const TextStyle(color: Color.fromRGBO(109, 107, 124, 0.44)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: Color(0xff7F77C6))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
              filled: true,
              fillColor: const Color(0xffE7E6EC),
              hintText: _placeholder)),
      Container(
        width: 63,
        height: 63,
        decoration: BoxDecoration(
            color: const Color(0xff7F77C6),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff7F77C6).withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ]),
        child:  Center(
            child: GestureDetector(
              onTap: () => _productController.filterCategory("Dog"),
              child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 46.0,
                    ),
            )),
      )
    ]);
  }
}
