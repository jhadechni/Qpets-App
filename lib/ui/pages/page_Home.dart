import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/agenda.dart';
import 'package:qpets_app/utils/tips.dart';

import '../../controllers/authentication_controller.dart';
import 'package:qpets_app/controllers/user_controller.dart';
import 'package:qpets_app/domain/authentication.dart';
import 'package:qpets_app/domain/user.dart';
import 'dart:math';

import '../../utils/ourPurple.dart';

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
    for (var i = 0; i < controller.events.length; i++) {
      if (i < 4) {
        entrie.add(agenda(
            controller.events[i].from.hour.toString() +
                ":" +
                controller.events[i].to.minute.toString(),
            controller.events[i].title));
      }
    }
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

  EventController eventController = Get.find<EventController>();
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    AuthenticationController authentication = Get.find();
    Random random = Random();
    int rndm = random.nextInt(4);
    Authentication controller = Get.find();
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
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      decoration: const BoxDecoration(
                        color: const Color(0xffE2E2EC),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                          if (entrie.length < 4) ...[
                            for (var i = 0; i < entrie.length; i++) ...[
                              rowAgenda(i)
                            ]
                          ],
                        ],
                      ),
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
            return Center(
                child: LoadingAnimationWidget.flickr(
              leftDotColor: Palette.ourPurple,
              rightDotColor:  Color(0xFFF6A641),
              size: 100,
            ));
          }
        });
  }

  Widget rowAgenda(int i) {
    return Row(
      children: [
        _cardhora(entrie[i].hora),
        _carddescripcion(entrie[i].descripcion, false)
      ],
    );
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
                  _carddescripcion(agenda.descripcion, false)
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
      padding: big ? const EdgeInsets.only(left: 50) : const EdgeInsets.all(30),
      child: Center(
        child: Text(
          descripcion,
          style: TextStyle(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: big ? 25 : 20,
            fontWeight:big ? FontWeight.bold : FontWeight.normal,
          ),
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
              image: AssetImage('assets/images/Corgi_logo_1.png'),
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
    return Center(
      child: Text(
        '$descripcion events',
        style: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _titulo(String descripcion) {
    return Text(
      descripcion,
      style: const TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}