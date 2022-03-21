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
          BackButton(),
          Text("Bolt's Timeline",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffE2E2EC)),
                child: ListView.builder(
                    itemExtent: 60,
                    itemCount: 10,
                    itemBuilder: (context, index) => index % 2 == 0
                        ? getRightTile(index, "Jaime")
                        : getLeftTile(index, "Jaime"))),
          )
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
}
