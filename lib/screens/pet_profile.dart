import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.topLeft,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                "https://ggsc.s3.amazonaws.com/images/uploads/The_Science-Backed_Benefits_of_Being_a_Dog_Owner.jpg",
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 32.0), child: BackButton()),
          ],
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          // use ListView to handle scroll
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Text("Bolt",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffE2E2EC)),
                child: Text("Hola"),
              )
            ],
          ),
        ))
      ],
    );
  }
}
