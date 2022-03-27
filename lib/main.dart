import 'package:flutter/material.dart';
import 'package:qpets_app/ui/provider/event_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qpets_app/ui/pages/page_Home.dart';
import 'package:qpets_app/ui/pages/page_calendar.dart';
import 'package:qpets_app/ui/pages/page_maps.dart';
import 'package:qpets_app/ui/pages/page_profile.dart';
import 'package:qpets_app/ui/pages/page_store.dart';
import 'package:provider/provider.dart';

class Palette {
  static const MaterialColor ourPurple = MaterialColor(
    0xFF8E6FD8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x8064c2), //10%
      100: Color(0x7259ad), //20%
      200: Color(0x634e97), //30%
      300: Color(0x554382), //40%
      400: Color(0x47386c), //50%
      500: Color(0x392c56), //60%
      600: Color(0x2b2141), //70%
      700: Color(0x1c162b), //80%
      800: Color(0x0e0b16), //90%
      900: Color(0x000000), //100%
    },
  );
}

void main() => runApp(GetMaterialApp(
    home: const BottomNavBar(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        primarySwatch: Palette.ourPurple)));

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final PageHome home = const PageHome();
  final CalendarPage calendar = CalendarPage();
  final MapsPage maps = const MapsPage();
  final PageProfile profile = const PageProfile();
  final PageStore store = const PageStore();

  Widget _showPage = const PageHome();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return home;
      case 1:
        return store;
      case 2:
        return SafeArea(child: maps);
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
        items: const <Widget>[
          Icon(FontAwesomeIcons.house, size: 30),
          Icon(FontAwesomeIcons.bagShopping, size: 30),
          Icon(FontAwesomeIcons.mapLocation, size: 30),
          Icon(FontAwesomeIcons.calendarCheck, size: 30),
          Icon(FontAwesomeIcons.userLarge, size: 30),
        ],
        color: const Color(0xFF8E6FD8),
        buttonBackgroundColor: const Color(0xFFF6A641),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 170),
        onTap: (int tappedIndex) {
          setState(() {
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
