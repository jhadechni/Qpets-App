import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:qpets_app/pages/page_Home.dart';
import 'package:qpets_app/pages/page_calendar.dart';
import 'package:qpets_app/pages/page_maps.dart';
import 'package:qpets_app/pages/page_profile.dart';
import 'package:qpets_app/pages/page_store.dart';


void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final page_calendar calendar = new page_calendar();
  final page_Home home = page_Home();
  final page_maps maps = new page_maps();
  final page_profile profile = new page_profile();
  final page_store store = new page_store();

  Widget _ShowPage = new page_Home();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return home;
        break;
      case 1:
        return store;
        break;

      case 2:
        return maps;
        break;

      case 3:
        return page_calendar();
        break;

      case 4:
        return page_profile();
        break;
      default:
        return new Container(
          child: new Center(
            child: Text("No ha seleccionado ninguna pagina"),
          ),
        );
    }
  }
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home_outlined, size: 30),
            Icon(Icons.storefront_outlined, size: 30),
            Icon(Icons.map_outlined, size: 30),
            Icon(Icons.calendar_today_outlined, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Color(0xFF8E6FD8),
          backgroundColor: Colors.amber,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 170),
          onTap: (int tappedIndex) {
            setState(() {
              _ShowPage = _pageChooser(tappedIndex);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.amber,
          child: Center(
            child: _ShowPage,
          ),
        ));
  }
}
