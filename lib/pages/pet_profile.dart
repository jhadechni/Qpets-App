import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpets_app/pages/timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProfileField extends StatelessWidget {
  final String field;
  final String value;
  const ProfileField({required this.field, required this.value});
  final fieldStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xff383558));
  final fieldValueStyle = const TextStyle(
      fontWeight: FontWeight.w300, fontSize: 12.0, color: Color(0xff717171));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(field, style: fieldStyle),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
        Text(value, style: fieldValueStyle)
      ]),
    );
  }
}

class PetProfileWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Expanded(
                    child: ProfileField(
                  field: "Current Age",
                  value: "1 year",
                )),
                Expanded(
                    child: ProfileField(
                  field: "Gender",
                  value: "Male",
                ))
              ],
            ),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Breed",
                value: "Siberian Husky",
              )),
              Expanded(
                  child: ProfileField(
                field: "Vaccine Check",
                value: "Yes",
              ))
            ]),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Type",
                value: "Dog",
              )),
              Expanded(
                  child: ProfileField(
                field: "Weight",
                value: "20 pounds",
              ))
            ]),
            Row(children: const [
              Expanded(
                  child: ProfileField(
                field: "Chip Check",
                value: "Yes",
              )),
              Expanded(
                  child: ProfileField(
                field: "Spayed and Neutered",
                value: "Yes",
              ))
            ]),
          ],
        ));
  }
}


class Carousel extends StatefulWidget {
  @override
  final List<Widget> widgets;
  Carousel(this.widgets);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CarouselState(widgets);
  }
}

class _CarouselState extends State<Carousel> {
  @override
  int _current = 0;
  final List<Widget> children;
  _CarouselState(this.children);
  final CarouselController _controller = CarouselController();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [
      Expanded(
          child: CarouselSlider(
              items: children,
              options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }))),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 4.0,
              height: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      )
    ]);
  }
}

class PetTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => index % 2 == 0
                ? getBottomTile(index, "Event 1")
                : getUpperTile(index, "Event 1")),
        IconButton(
            constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              Get.to(() => TimeLine(),
                  duration: const Duration(milliseconds: 250),
                  transition: Transition.cupertino);
            },
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero),
      ],
    );
  }

  Widget getUpperTile(int index, String text) {
    return TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        beforeLineStyle:
            const LineStyle(thickness: 6, color: Color(0xff7F77C6)),
        afterLineStyle: const LineStyle(thickness: 6, color: Color(0xff7F77C6)),
        indicatorStyle: IndicatorStyle(
          height: 30,
          color: const Color(0xffF6A641),
          drawGap: false,
          iconStyle: IconStyle(
              color: Colors.black, iconData: Icons.pets, fontSize: 22.0),
        ),
        startChild: Container(
            child: Column(
          children: <Widget>[
            const Text("Feb 20",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text(text,
                style: const TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.black))
          ],
        )));
  }

  Widget getBottomTile(int index, String text) {
    return TimelineTile(
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.center,
      beforeLineStyle: const LineStyle(thickness: 6, color: Color(0xff7F77C6)),
      afterLineStyle: const LineStyle(thickness: 6, color: Color(0xff7F77C6)),
      indicatorStyle: IndicatorStyle(
        height: 30,
        color: const Color(0xffF6A641),
        drawGap: false,
        iconStyle: IconStyle(
            color: Colors.black, iconData: Icons.pets, fontSize: 22.0),
      ),
      endChild: Container(
          child: Column(
        children: <Widget>[
          const Text("Feb 20",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(text,
              style: const TextStyle(
                  fontSize: 8.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.black))
        ],
      )),
    );
  }
}

class PetProfile extends StatelessWidget {
  const PetProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          getProfile(),
          Expanded(
              // use ListView to handle scroll
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: <Widget>[
                Row(children: const [
                  Text("Polar",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  IconButton(icon: Icon(Icons.edit), onPressed: null)
                ]),
                Container(
                    height: 250,
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE2E2EC)),
                    child: Carousel([PetProfileWindow(), const Text("Hi")])),
                const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text("Timeline",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                Container(
                    height: 120,
                    constraints: const BoxConstraints(maxHeight: 120),
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE2E2EC)),
                    child: PetTimeLine()),
                const Padding(padding: EdgeInsets.only(bottom: 16.0))
              ])),
        ],
      )),
    );
  }

  Widget getProfile() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://i.imgur.com/BpG6vSU.jpg"),
                    fit: BoxFit.fitWidth))),
        Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: BackButton(onPressed: () {
              Get.back();
            })),
      ],
    );
  }
}
