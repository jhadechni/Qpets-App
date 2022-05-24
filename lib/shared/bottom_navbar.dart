import 'package:flutter/material.dart';
import 'package:qpets_app/ui/pages/page_login.dart';
import 'package:qpets_app/ui/pages/pages_signup.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qpets_app/ui/pages/page_Home.dart';
import 'package:qpets_app/ui/pages/page_calendar.dart';
import 'package:qpets_app/ui/pages/page_maps.dart';
import 'package:qpets_app/ui/pages/page_profile.dart';
import 'package:qpets_app/ui/pages/page_store.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  Color col1 = Color(0xFFF383558);
  Color col2 = Color(0xFFF383558);
  Color col3 = Color(0xFFF383558);
  Color col4 = Color(0xFFF383558);
  Color col5 = Color(0xFFF383558);
  final PageHome home = const PageHome();
  final CalendarPage calendar = CalendarPage();
  final MapsPage maps = const MapsPage();
  final PageProfile profile = const PageProfile();
  final PageStore store = const PageStore();
  final LoginPage login = const LoginPage();
  final SingupPage singup = const SingupPage();

  Widget _showPage = const PageHome();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return home;
      case 1:
        return store;
      case 2:
        return  SafeArea(child: maps);
      case 3:
        return calendar;
      case 4:
        return profile;
      default:
        return const Center(
          child: Text("No ha seleccionado ninguna pagina"),
        );
    }
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageIndex,
        height: 75,
        items: <Widget>[
          Icon(
            FontAwesomeIcons.house,
            size: 30,
            color: col1,
          ),
          Icon(
            FontAwesomeIcons.store,
            size: 27,
            color: col2,
          ),
          Icon(
            FontAwesomeIcons.mapLocation,
            size: 27,
            color: col3,
          ),
          Icon(
            FontAwesomeIcons.calendarCheck,
            size: 30,
            color: col4,
          ),
          Icon(
            FontAwesomeIcons.userLarge,
            size: 30,
            color: col5,
          ),
        ],
        color: const Color(0xFF8E6FD8),
        buttonBackgroundColor: const Color(0xFFF6A641),
        backgroundColor: Colors.transparent.withOpacity(0),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 170),
        onTap: (int tappedIndex) {
          setState(() {
            if (tappedIndex == 0) {
              col1 = Color(0xFFF7A490B);
            } else {
              col1 = Color(0xFFF383558);
            }
            if (tappedIndex == 1) {
              col2 = Color(0xFFF7A490B);
            } else {
              col2 = Color(0xFFF383558);
            }
            if (tappedIndex == 2) {
              col3 = Color(0xFFF7A490B);
            } else {
              col3 = Color(0xFFF383558);
            }
            if (tappedIndex == 3) {
              col4 = Color(0xFFF7A490B);
            } else {
              col4 = Color(0xFFF383558);
            }
            if (tappedIndex == 4) {
              col5 = Color(0xFFF7A490B);
            } else {
              col5 = Color(0xFFF383558);
            }
            _showPage = _pageChooser(tappedIndex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: _showPage,
        ),
      ));
}
