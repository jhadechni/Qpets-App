import 'package:flutter/material.dart';

typedef SearchBarTextChangeCallback = void Function(String s);

class SearchBar extends StatelessWidget {
  final SearchBarTextChangeCallback? onTextChangeCallback;
  final VoidCallback? onSearchPressed;
  final String placeholder;
  final TextEditingController _controller = TextEditingController();
  SearchBar(
      {this.onTextChangeCallback,
      required this.placeholder,
      this.onSearchPressed,
      String initialSearch = ""}) {
    _controller.text = initialSearch;
    if (initialSearch.isNotEmpty) {
      onSearchPressed?.call();
    }
  }
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Stack(alignment: AlignmentDirectional.centerEnd, children: [
      TextField(
          style: TextStyle(fontSize: 18),
          onChanged: (value) => {onTextChangeCallback?.call(value)},
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
              fillColor: Color(0xffE7E6EC),
              hintText: placeholder)),
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
        child: Center(
            child: GestureDetector(
          onTap: () => onSearchPressed?.call(),
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
