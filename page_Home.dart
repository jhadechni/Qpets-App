import 'package:flutter/material.dart';
import 'package:qpets_app/domain/agenda.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => Pagehomestate();
}

class Pagehomestate extends State<PageHome> {
  List<agenda> entrie = <agenda>[];
  @override
  void initState() {
    entrie.add(agenda('12:30             ', 'Vacinee 1'));
    entrie.add(agenda('16:30             ', 'Training section'));
    entrie.add(agenda('17:20             ', 'Spa day'));
    entrie.add(agenda('18:00             ', 'Walk with Antonella'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: _titulo2("Hello , Pedro!")),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  width:double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffE2E2EC),
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _cardImage(
                              'https://media.discordapp.net/attachments/955549239801446473/955557314943914024/events-smart-card.png'),
                          Column(
                            children: [
                              _carddescripcion('Agenda'),
                              _carddescripcioneventos(entrie.length.toString())
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _cardhora('12:30'),
                          _carddescripcion('  Vacinee 1')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _cardhora('16:30'),
                          _carddescripcion(' Training section')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _cardhora('17:20'),
                          _carddescripcion(' Spa day')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _cardhora('18:00'),
                          _carddescripcion(' Walk with Antonella')
                        ],
                      ),
                    ],
                  ),
                )),
            Container(
              width: 50,
              height: 30,
            ),
            Expanded(
                flex: 5,
                child: Container(
                  width:double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffE2E2EC),
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _cardImage2(
                          'https://media.discordapp.net/attachments/955549239801446473/955561331161976922/unsplash_OA9103M2gSs.png'),
                      _titulo('Don’t forget to walk with your pets.'),
                      _carddescripcion(
                          'Dog owners enjoy numerous health and social benefits by walking their dog a few times a week. Benefits include improved cardiovascular fitness, lower blood pressure more...')
                    ],
                  ),
                )),
            Container(
              width: 20,
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _titulo2(String text) {
    return   Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Color.fromRGBO(30, 23, 33, 1),
        fontSize: 45,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _card(agenda agenda) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: const Color(0xffE2E2EC)),
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 20,
          height: 80,
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _cardhora(agenda.hora),
                  _carddescripcion(agenda.descripcion)
                ],
              )
            ],
          ),
        ));
  }

  Widget _cardhora(String hora) {
    return Text(
      hora,
      style: const TextStyle(
        color: Color.fromRGBO(246, 166, 65, 1),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _carddescripcion(String descripcion) {
    return Text(
      descripcion,
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _cardImage(String link) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImage2(String link) {
    return Container(
        width: 470,
        height: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _carddescripcioneventos(String descripcion) {
    return Text(
      '$descripcion events',
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _titulo(String descripcion) {
    return Text(
      '$descripcion',
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
