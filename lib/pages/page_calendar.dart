import 'package:flutter/material.dart';
import 'package:qpets_app/pages/calendar/event_editing_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:qpets_app/pages/calendar/calendar_widget.dart';

class page_calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qpet Calendar"),
        centerTitle: true,
        backgroundColor: const Color(0xFF8E6FD8),
      ),
      body: calendar_widget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: const Color(0xFF8E6FD8),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
      ),
    );
  }
}
