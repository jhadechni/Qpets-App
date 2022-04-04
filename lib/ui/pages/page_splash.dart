import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';

class Pagesplash extends StatefulWidget {
  const Pagesplash({Key? key}) : super(key: key);

  @override
  State<Pagesplash> createState() => _PagesplashState();
}

class _PagesplashState extends State<Pagesplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
    Get.to(const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [_fontPage(), Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logo(),
          ],
        )],
      )),
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _cardImagepet( 'https://media.discordapp.net/attachments/955549239801446473/955549292423172116/Corgi_logo_1.png'),
          _cardImagelogo('https://media.discordapp.net/attachments/955549239801446473/960035755244269608/Vector.png'),
          _cardImagelogo('https://media.discordapp.net/attachments/955549239801446473/960037973200625724/Vector_1.png'),
        ],
      ),
    );
  }

  Widget _cardImage(String link) {
    return Container(
        width: 70,
        height: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImage2(String link) {
    return Container(
        width: 20,
        height: 30,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImagepet(String link) {
    return SizedBox(
        width: 250,
        height: 250,
        child: Center(
            child: Image(
          image: NetworkImage(link),
          fit: BoxFit.fill,
        )));
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

  Widget _fontPage() {
    return Container(
        color: Color(0xFF7F77C6),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                    _cardImage2(
                        'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png'),
                  ],
                ),
                Column(
                  children: [
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                    Container(
                        height: 250, width: 250, color: const Color(0xFF7F77C6))
                  ],
                ),
                _cardImage(
                    'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                    _cardImage2(
                        'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png')
                  ],
                ),
                Column(
                  children: [
                    _cardImage2(
                        'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png'),
                    Container(
                        height: 100,
                        width: 200,
                        color: const Color(0xFF7F77C6)),
                  ],
                ),
                _cardImage(
                    'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
              ],
            ),
            Row(
              children: [
                _cardImage(
                    'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                Container(
                    height: 250, width: 250, color: const Color(0xFF7F77C6)),
                _cardImage(
                    'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png')
              ],
            )
          ],
        ));
  }
}
