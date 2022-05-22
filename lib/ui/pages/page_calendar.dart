import 'package:flutter/material.dart';
import 'package:qpets_app/ui/pages/calendar/event_editing_page.dart';
import 'package:qpets_app/ui/pages/calendar/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.all(5.0),
    child: Scaffold(
          
          body: CalendarWidget(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: const Color(0xFF8E6FD8),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage())),
          ),
        ),
  );
}
