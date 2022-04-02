import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef SearchBarCallBack = void Function(String s);

class SearchBar extends StatelessWidget {
  final SearchBarCallBack _callback;
  final String _placeholder;
  final TextEditingController _controller = new TextEditingController();
  SearchBar(this._callback, this._placeholder);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(alignment: AlignmentDirectional.centerEnd, children: [
      TextField(
          style: TextStyle(fontSize: 18),
          onChanged: ((value) => _callback(value)),
          // autofocus: false,
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Color.fromRGBO(109, 107, 124, 0.44)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.15)),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Color(0xff7F77C6))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
              filled: true,
              fillColor: Color(0xffE7E6EC),
              hintText: _placeholder)),
      Container(
        width: 63,
        height: 63,
        decoration: BoxDecoration(
            color: Color(0xff7F77C6),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Color(0xff7F77C6).withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ]),
        child: Center(
            child: Icon(
          Icons.search,
          color: Colors.white,
          size: 46.0,
        )),
      )
    ]);
  }
}
