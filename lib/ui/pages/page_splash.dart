import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:qpets_app/utils/ourPurple.dart';

MaterialColor ourPurlple = Palette.ourPurple;

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
      Get.to(() => const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          _fontPage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(),
            ],
          )
        ],
      )),
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _cardImagepet('assets/images/Corgi_logo_1.png'),
          _cardImagelogo('assets/images/Vector.png'),
          Container(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: CircularProgressIndicator(
                backgroundColor: ourPurlple,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 15,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _cardImage(String link) {
    return Container(
        width: 70,
        height: 80,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImage2(String link) {
    return Container(
        width: 20,
        height: 30,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImagepet(String link) {
    return SizedBox(
        width: 250,
        height: 250,
        child: Center(
            child: Image(
          image: AssetImage(link),
          fit: BoxFit.fill,
        )));
  }

  Widget _cardImagelogo(String link) {
    return SizedBox(
        width: 200,
        height: 100,
        child: Center(
            child: Image(
          image: AssetImage(link),
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
                    _cardImage('assets/images/Group.png'),
                    _cardImage2('assets/images/Group_3.png'),
                  ],
                ),
                Column(
                  children: [
                    _cardImage('assets/images/Group.png'),
                    Container(
                        height: 250, width: 250, color: const Color(0xFF7F77C6))
                  ],
                ),
                _cardImage('assets/images/Group.png'),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    _cardImage('assets/images/Group.png'),
                    _cardImage2('assets/images/Group_3.png')
                  ],
                ),
                Column(
                  children: [
                    _cardImage2('assets/images/Group_3.png'),
                    Container(
                        height: 100,
                        width: 200,
                        color: const Color(0xFF7F77C6)),
                  ],
                ),
                _cardImage('assets/images/Group.png'),
              ],
            ),
            Row(
              children: [
                _cardImage('assets/images/Group.png'),
                Container(
                    height: 250, width: 250, color: const Color(0xFF7F77C6)),
                _cardImage('assets/images/Group.png')
              ],
            )
          ],
        ));
  }
}
