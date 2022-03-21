import 'package:flutter/material.dart';
import 'package:qpets_app/pages/pet_profile.dart';
import 'package:qpets_app/pages/timeline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: TimeLine(key: Key("pet-profile"))));
  }
}
