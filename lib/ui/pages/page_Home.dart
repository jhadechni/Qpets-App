import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/agenda.dart';
import 'package:qpets_app/utils/tips.dart';

import '../../controllers/authentication_controller.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/domain/authentication.dart';
import 'package:qpets_app/domain/user.dart';
import 'dart:math';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);
  @override
  State<PageHome> createState() => Pagehomestate();
}

class Pagehomestate extends State<PageHome> {
  EventController controller = Get.find<EventController>();
  List<agenda> entrie = <agenda>[];
  List<tipList> tips = <tipList>[];
  @override
  void initState() {
    entrie.add(agenda('12:30', 'Vacinee 1'));
    entrie.add(agenda('16:30', 'Training section'));
    entrie.add(agenda('17:20', 'Spa day'));
    entrie.add(agenda('18:00', 'Walk with Antonella'));
    addList();
    super.initState();
  }

  addList() {
    tips.add(tipList(
        'Walk your dog',
        'A regular walk is vitally important for your pet´s health too. Obesity in pets is associated with a number of medical complaints including osteoarthritis, cardiovascular disease, liver disease and insulin resistance.',
        'tip_1'));
    tips.add(tipList(
        'Give your dog fresh food',
        'Feeding your pet a fresh food diet gives them the maximum dose of nutrient and vitamins. Fresh fruit, vegetables, and animal proteins in your pet’s diet provide them with antioxidants, amino acids, vitamins, minerals, phytonutrients, and fiber. This balanced and nutritious diet converts into more sustainable energy for your pet.',
        'tip_2'));
    tips.add(tipList(
        'Sleep with your dog',
        'If simply interacting with a dog can treat depression, imagine what sleeping next to one can do! Their presence helps us relax and increases our flow of oxytocin, the love chemical. This essentially makes your dog a living antidepressant!',
        'tip_3'));
    tips.add(tipList(
        'Give Medication to your dog',
        'Sometimes you can opt for a flavored compounded medication or a chewable “treat” tablet. This works well for dogs that don’t like to swallow their pills.',
        'tip_4'));
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    AuthenticationController authentication = Get.find();
    Authentication controller = Get.find();
    Random random = Random();
    int rndm = random.nextInt(4);
    return FutureBuilder<User>(
        future: userController.fetchUserData(authentication.getUid()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      "Hello, ${snapshot.data!.name.split(' ')[0]}!",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(30, 23, 33, 1),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 339,
                    height: 308,
                    decoration: const BoxDecoration(
                      color: const Color(0xffE2E2EC),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _cardImage(),
                            Column(
                              children: [
                                _carddescripcion('Agenda', true),
                                _carddescripcioneventos(
                                    entrie.length.toString())
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            _cardhora('12:30'),
                            _carddescripcion('Vacinee 1', true)
                          ],
                        ),
                        Row(
                          children: [
                            _cardhora('16:30'),
                            _carddescripcion('Training section', true)
                          ],
                        ),
                        Row(
                          children: [
                            _cardhora('17:20'),
                            _carddescripcion('Spa day', true)
                          ],
                        ),
                        Row(
                          children: [
                            _cardhora('18:00'),
                            _carddescripcion('Walk with Antonella', true)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE2E2EC),
                      ),
                      child: Column(
                        children: [
                          _cardImage2(tips[rndm].img),
                          _titulo(tips[rndm].title),
                          _carddescripcion(tips[rndm].desc, false)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          } else if (snapshot.hasError) {
            return const Center(child: const Text("Error"));
          } else {
            return const Center(child: Text("Loading..."));
          }
        });
  }
}

Widget _card(agenda agenda) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffE2E2EC)),
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: 20,
        height: 100,
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _cardhora(agenda.hora),
                _carddescripcion(agenda.descripcion, true)
              ],
            )
          ],
        ),
      ));
}

Widget _cardhora(String hora) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 30, top: 10),
    child: Text(
      hora,
      style: const TextStyle(
        color: Color.fromRGBO(246, 166, 65, 1),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _carddescripcion(String descripcion, bool big) {
  return Padding(
    padding: big ? const EdgeInsets.only(left: 30) : const EdgeInsets.all(30),
    child: Text(
      descripcion,
      style: TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontSize: big ? 18 : 15,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget _cardImage() {
  return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/tip_1.png'),
          ),
          borderRadius: BorderRadius.circular(10)));
}

Widget _cardImage2(String img) {
  return Container(
      width: 400,
      height: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/$img.png'),
          ),
          borderRadius: BorderRadius.circular(10)));
}

Widget _carddescripcioneventos(String descripcion) {
  return Text(
    '$descripcion events',
    style: const TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    textAlign: TextAlign.right,
  );
}

Widget _titulo(String descripcion) {
  return Text(
    descripcion,
    style: const TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: 34,
      fontWeight: FontWeight.normal,
    ),
    textAlign: TextAlign.center,
  );
}
