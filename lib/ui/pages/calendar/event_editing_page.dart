import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/calendar_event_controller.dart';
import 'package:qpets_app/domain/calendar/event.dart';
import 'package:qpets_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qpets_app/utils/ourPurple.dart';

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
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            primarySwatch: Palette.ourPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: const CloseButton(),
            actions: buildEditingActions(),
            backgroundColor: bgColor,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildTitle(),
                  const SizedBox(height: 50),
                  buildDateTimePickers(),
                  const SizedBox(height: 50),
                  colorPicker(),
                ],
              ), // Column
            ), // Form
          ), // SingleChildScrollView
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
                    backgroundColor: Colors.green,
                    onPressed: () {
                      setState(() {
                        bgColor = Colors.green;
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
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      setState(() {
                        bgColor = Colors.blue;
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
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Add Title",
        ),
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

      controller.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
