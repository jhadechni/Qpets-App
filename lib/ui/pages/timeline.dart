import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/timeline_event.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class TimeLine extends StatelessWidget {
  PetProfileFields pet;
  final LineStyle _lineStyle =
      const LineStyle(thickness: 8, color: Color(0xff7F77C6));
  TimeLine({required this.pet, Key? key}) : super(key: key);
  final TimelineController controller = Get.find<TimelineController>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  DateTime? pickedDate;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {
                Get.back();
              },
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            Text("${pet.name}'s Timeline",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Expanded(
                child:
                    Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffE2E2EC)),
                  child: Obx(() => ListView(
                      itemExtent: 60,
                      children: controller.events
                          .mapIndexed((i, element) => i % 2 == 0
                              ? getRightTile(element)
                              : getLeftTile(element))
                          .toList()))),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            barrierColor: Colors.black.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => getDialog(context));
                      },
                      child: const Icon(
                        Icons.add,
                        color: Color(0xff383558),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xffC4C4C4),
                          fixedSize: const Size(24, 24),
                          shape: const CircleBorder())))
            ])),
          ],
        ),
      )),
    );
  }

  Widget getLeftTile(TimelineEvent event) {
    return TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.center,
        beforeLineStyle: _lineStyle,
        afterLineStyle: _lineStyle,
        indicatorStyle: IndicatorStyle(
          width: 35,
          color: const Color(0xffF6A641),
          iconStyle: IconStyle(
              color: Colors.black, iconData: Icons.pets, fontSize: 26.0),
        ),
        startChild: Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("${DateFormat("MMMd").format(event.date)}",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(event.name,
                    style: const TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.black))
              ],
            )));
  }

  Widget getRightTile(TimelineEvent event) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.center,
      beforeLineStyle: _lineStyle,
      afterLineStyle: _lineStyle,
      indicatorStyle: IndicatorStyle(
        width: 35,
        color: const Color(0xffF6A641),
        iconStyle: IconStyle(
            color: Colors.black, iconData: Icons.pets, fontSize: 26.0),
      ),
      endChild: Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${DateFormat("MMMd").format(event.date)}",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(event.name,
                  style: const TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.black))
            ],
          )),
    );
  }

  Widget getDialog(BuildContext context) {
    return BackdropFilter(
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
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("New Event",
                  style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _textField("Name", _eventNameController)),
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _textField("Description", _eventDescController)),
            const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text("Date",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600)))),
            _dateTextField(context, "DD / MM / YYYY", _eventDateController),
            Expanded(
              child: Center(
                  child: Container(
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
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: TextButton(
                  onPressed: () {
                    _addEvent(_eventNameController.text,
                        _eventDescController.text, pickedDate);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add Event",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              )),
            )
          ]),
        ),
      ),
    );
  }

  void _addEvent(String name, String desc, DateTime? date) {
    if (name.isEmpty || desc.isEmpty || date == null) {
      return;
    }
    controller.addEvent(name, desc, date, pet.id);
  }

  Widget _textField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
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
          hintText: hintText),
    );
  }

  Widget _dateTextField(
      BuildContext context, String hintText, TextEditingController controller) {
    return TextField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          //do something
          pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime
                  .now(), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));
          controller.text = DateFormat("d/M/y").format(pickedDate!);
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today,
                color: const Color(0xff7F77C6)),
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
                borderSide: const BorderSide(color: Color(0xff7F77C6))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText));
  }
}
