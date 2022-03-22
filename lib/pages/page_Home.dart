import 'package:flutter/material.dart';
import 'package:qpets_app/shared/search_bar.dart';

class page_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchBar((s) => {print(s)}, "Search an Event"),
    );
  }
}