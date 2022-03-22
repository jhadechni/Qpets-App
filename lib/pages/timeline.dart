import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLine extends StatelessWidget {
  final LineStyle _lineStyle =
      const LineStyle(thickness: 8, color: Color(0xff7F77C6));
  const TimeLine({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            ),
            onPressed: null,
            constraints: BoxConstraints(),
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Text("Polar's Timeline",
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
                child: ListView.builder(
                    itemExtent: 60,
                    itemCount: 10,
                    itemBuilder: (context, index) => index % 2 == 0
                        ? getRightTile(index, "Event 1")
                        : getLeftTile(index, "Event 2"))),
            Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.1),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => getDialog(context));
                    },
                    child: Icon(
                      Icons.add,
                      color: Color(0xff383558),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffC4C4C4),
                        fixedSize: const Size(24, 24),
                        shape: const CircleBorder())))
          ])),
        ],
      ),
    );
  }

  Widget getLeftTile(int index, String text) {
    return TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.center,
        beforeLineStyle: _lineStyle,
        afterLineStyle: _lineStyle,
        indicatorStyle: IndicatorStyle(
          width: 35,
          color: Color(0xffF6A641),
          iconStyle: IconStyle(
              color: Colors.black, iconData: Icons.pets, fontSize: 26.0),
        ),
        startChild: Container(
            padding: EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Feb 20",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(text,
                    style: TextStyle(
                        fontSize: 8.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.black))
              ],
            )));
  }

  Widget getRightTile(int index, String text) {
    return TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.center,
      beforeLineStyle: _lineStyle,
      afterLineStyle: _lineStyle,
      indicatorStyle: IndicatorStyle(
        width: 35,
        color: Color(0xffF6A641),
        iconStyle: IconStyle(
            color: Colors.black, iconData: Icons.pets, fontSize: 26.0),
      ),
      endChild: Container(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Feb 20",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(text,
                  style: TextStyle(
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
            color: Color(0xffE2E2EC),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, -3), // Shadow position
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("New Event",
                  style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: _textField("Name")),
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: _textField("Description")),
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text("Date",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600)))),
            _dateTextField(context, "DD / MM / YYYY"),
            Expanded(
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff7F77C6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7F77C6).withOpacity(0.35),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        child: Text(
                          "Add Event",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ))),
            )
          ]),
        ),
      ),
    );
  }

  Widget _textField(String hintText) {
    return TextField(
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Color(0xff8C99B1)),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xff7F77C6))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText),
    );
  }

  Widget _dateTextField(BuildContext context, String hintText) {
    return TextField(
        readOnly: true,
        onTap: () async {
          //do something
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime
                  .now(), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today, color: Color(0xff7F77C6)),
            hintStyle: TextStyle(color: Color(0xff8C99B1)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Color(0xff7F77C6))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText));
  }
}
