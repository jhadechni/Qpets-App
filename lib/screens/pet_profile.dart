import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String field;
  final String value;
  const ProfileField({required this.field, required this.value});
  final fieldStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xff383558));
  final fieldValueStyle = const TextStyle(
      fontWeight: FontWeight.w300, fontSize: 12.0, color: Color(0xff717171));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(field, style: fieldStyle),
        Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        Text(value, style: fieldValueStyle)
      ]),
    );
  }
}

class PetProfileWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffE2E2EC)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Expanded(
                    child: ProfileField(
                  field: "Current Age",
                  value: "9 months",
                )),
                Expanded(
                    child: ProfileField(
                  field: "Gender",
                  value: "Male",
                ))
              ],
            ),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Breed",
                value: "Labrador",
              )),
              Expanded(
                  child: ProfileField(
                field: "Vaccine Check",
                value: "Yes",
              ))
            ]),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Type",
                value: "Dog",
              )),
              Expanded(
                  child: ProfileField(
                field: "Weight",
                value: "20 pounds",
              ))
            ]),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Chip Check",
                value: "Yes",
              )),
              Expanded(
                  child: ProfileField(
                field: "Spayed and Neutered",
                value: "Yes",
              ))
            ]),
            Center(child: Icon(Icons.more_horiz))
          ],
        ));
  }
}

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
            const Padding(
                padding: EdgeInsets.only(top: 32.0), child: BackButton()),
          ],
        ),
        Expanded(
            // use ListView to handle scroll
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: <Widget>[
              Row(children: const [
                Text("Bolt",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                IconButton(icon: Icon(Icons.edit), onPressed: null)
              ]),
              PetProfileWindow()
            ])),
      ],
    );
  }
}
