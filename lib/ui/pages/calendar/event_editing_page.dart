import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/calendar/event.dart';
import 'package:qpets_app/utils/utils.dart';
import 'package:qpets_app/utils/ourPurple.dart';

Color ourPurple = Palette.ourPurple;

class EventEditingPage extends StatefulWidget {
  final Event? event;
  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);
  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  Color bgColor = Colors.blue;
  bool miniBool = true;
  String editText = "Add Event";
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  EventController controller = Get.find<EventController>();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
      editText = "Edit Event";
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1.1,
          sigmaY: 1.1,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffE2E2EC),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(0, -3), // Shadow position
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    buildTitle(),
                    const SizedBox(height: 20),
                    buildDateTimePickers(),
                    const SizedBox(height: 15),
                    colorPicker(),
                    const SizedBox(height: 20),
                    submitButton(),
                  ],
                ), // Column
              ), // Form
            ),
          ),
        ),
      );
  Widget submitButton() => Container(
        decoration: BoxDecoration(
            color: const Color(0xff7F77C6),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff7F77C6).withOpacity(0.35),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ]),
        child: TextButton(
          onPressed: saveForm,
          child: Text(editText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
        ),
      );
  Widget colorPicker() => buildHeader(
      header: "COLOR",
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "btn2",
                    mini: !miniBool,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      setState(() {
                        bgColor = Colors.green;
                        miniBool = !miniBool;
                      });
                    },
                    child: Icon(
                      Icons.park_sharp,
                      size: 35,
                      color: Colors.green[900],
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "btn1",
                    mini: miniBool,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      setState(() {
                        bgColor = Colors.blue;
                        miniBool = !miniBool;
                      });
                    },
                    child: Icon(
                      Icons.pets,
                      size: 35,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ))
        ],
      ));
  Widget buildFrom() => buildHeader(
        header: "FROM",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Widget buildTo() => buildHeader(
        header: "TO",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: bgColor,
            shadowColor: bgColor,
          ),
          onPressed: saveForm,
          icon: const Icon(Icons.done),
          label: const Text(
            'SAVE',
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontSize: 20),
          ),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: const TextStyle(
            fontWeight: FontWeight.w300, fontFamily: "Roboto", fontSize: 20),
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: const Color(0xff8C99B1)),
            border: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: const Color(0xff7F77C6))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            filled: true,
            fillColor: Colors.white,
            hintText: "Add Title"),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) =>
            title != null && title.isEmpty ? "Tittle cannot be empty" : null,
        controller: titleController,
      );
  Widget buildDateTimePickers() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildFrom(), buildTo()],
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
                color: Palette.ourPurple,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                fontSize: 18),
          ),
          child,
        ],
      );
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titleController.text,
          description: 'Descripción',
          from: fromDate,
          to: toDate,
          isAllDay: false,
          backgroundColor: bgColor);
      final isEditing = widget.event != null;
      if (isEditing) {
        controller.editEvent(event, widget.event!);
      } else {
        controller.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}
