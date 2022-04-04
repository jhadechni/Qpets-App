import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qpets_app/main.dart';
import 'package:qpets_app/ui/pages/pages_signup.dart';

class Pageslogin extends StatelessWidget {
  const Pageslogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color.fromRGBO(127, 119, 198, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 110.0, 0.0, 0.0),
                  child: _cardImagepet(
                      'https://media.discordapp.net/attachments/955549239801446473/955549292423172116/Corgi_logo_1.png'),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Qpets',
                        style: TextStyle(
                            fontSize: 90.0, fontWeight: FontWeight.bold)),
                  )

                  ],
                )
                ,
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    const TextField(
                      decoration: InputDecoration(
                          labelText: 'Correo',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFFF6A641)))),
                    ),
                    const SizedBox(height: 35.0),
                    const TextField(
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                            
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFFF6A641)))),
                      obscureText: true,
                    ),
                    
                    const SizedBox(height: 40.0),
                    SizedBox(
                      height: 40.0,
                      child: Container(
                         
                        color: const Color(0xFFF6A641),
                        
                        child: GestureDetector(
                          onTap: () {
                             print('d');
                             ;
                          },
                          // ignore: prefer_const_constructors
                          child: Center(
                            child: const Text(
                              'Iniciar sesion',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                )),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Crear una cuenta?',
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                     Get.to(() =>  const pagessingup());
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                        color: Color(0xFFF6A641),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _cardImagepet(String link) {
    return SizedBox(
        width: 150,
        height: 150,
        child: Center(
            child: Image(
          image: NetworkImage(link),
          fit: BoxFit.fill,
        )));
  }
}
