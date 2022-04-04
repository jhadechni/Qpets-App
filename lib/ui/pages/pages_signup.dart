import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
import 'package:qpets_app/ui/pages/page_login.dart';

class pagessingup extends StatelessWidget {
  const pagessingup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(127, 119, 198, 1),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  _cardImagelogo(
                      'https://media.discordapp.net/attachments/955549239801446473/960035755244269608/Vector.png'),
                  const Text(
                    'crea tu cuenta',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Container(
              padding:
                  const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6A641)))),
                  ),
                  const SizedBox(height: 10.0),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'contraseña ',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF6A641)))),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: const Color(0xFFF6A641),
                        color: const Color(0xFFF6A641),
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() =>  const Pageslogin());
                          },
                          child: const Center(
                            child: Text(
                              'Crear',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              )),
        ]));
  }

  Widget _cardImagelogo(String link) {
    return SizedBox(
        width: 200,
        height: 100,
        child: Center(
            child: Image(
          image: NetworkImage(link),
          fit: BoxFit.fill,
        )));
  }
}
