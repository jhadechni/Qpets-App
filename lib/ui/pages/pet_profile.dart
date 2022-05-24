import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qpets_app/controllers/pet_controller.dart';
import 'package:qpets_app/controllers/timeline_controller.dart';
import 'package:qpets_app/domain/pet_profile.dart';
import 'package:qpets_app/domain/timeline_event.dart';
import 'package:qpets_app/ui/pages/timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:collection/collection.dart';

class _ProfileField extends StatelessWidget {
  final String field;
  final String value;
  const _ProfileField({required this.field, required this.value});
  final fieldStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xff383558));
  final fieldValueStyle = const TextStyle(
      fontWeight: FontWeight.w300, fontSize: 12.0, color: Color(0xff717171));
  @override
  Widget build(BuildContext context) {
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

class _PetProfileWindow extends StatelessWidget {
  PetProfileFields pet;
  _PetProfileWindow(this.pet) {}
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: _ProfileField(
                  field: "Current Age",
                  value: getTimeDifferenceFromNow(pet.dob),
                )),
                Expanded(
                    child: _ProfileField(
                  field: "Gender",
                  value: pet.gender,
                ))
              ],
            ),
            Row(children: [
              Expanded(
                  child: _ProfileField(
                field: "Breed",
                value: pet.breed,
              )),
              Expanded(
                  child: _ProfileField(
                      field: "Vaccine Check",
                      value: pet.vaccineCheck.toString()))
            ]),
            Row(children: [
              Expanded(
                  child: _ProfileField(
                field: "Type",
                value: pet.type,
              )),
              Expanded(
                  child: _ProfileField(
                field: "Weight",
                value: pet.weight.toString(),
              ))
            ]),
            Row(children: [
              Expanded(
                  child: _ProfileField(
                field: "Chip Check",
                value: pet.chipCheck.toString(),
              )),
              Expanded(
                  child: _ProfileField(
                field: "Spayed and Neutered",
                value: pet.neutered.toString(),
              ))
            ]),
          ],
        ));
  }

  String getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 365) {
      double years = difference.inDays / 365;
      return "${years.round()} years";
    }
    if (difference.inDays > 31) {
      double months = difference.inDays / 31;
      return "${months.round()} months";
    }
    return "${difference.inDays} days";
  }
}

class _Carousel extends StatefulWidget {
  @override
  final List<Widget> widgets;
  _Carousel(this.widgets);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CarouselState(widgets);
  }
}

class _CarouselState extends State<_Carousel> {
  int _current = 0;
  final List<Widget> children;
  _CarouselState(this.children);
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: CarouselSlider(
              items: children,
              options: CarouselOptions(
                  height: 208,
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

class _PetTimeLine extends StatelessWidget {
  final TimelineController controller = Get.find<TimelineController>();
  PetProfileFields pet;
  _PetTimeLine(this.pet);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Obx(() => ListView(
            scrollDirection: Axis.horizontal,
            children: controller
                .getLastEvents()
                .mapIndexed(
                    (i, e) => i % 2 == 0 ? getBottomTile(e) : getUpperTile(e))
                .toList())),
        IconButton(
            constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              Get.to(
                  () => TimeLine(
                        pet: pet,
                      ),
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

  Widget getUpperTile(TimelineEvent e) {
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
            Text("${DateFormat("MMMd").format(e.date)}",
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text(e.name,
                style: const TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.black))
          ],
        )));
  }

  Widget getBottomTile(TimelineEvent e) {
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
          Text("${DateFormat("MMMd").format(e.date)}",
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(e.name,
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
  PetProfileFields pet;
  final PetController controller = Get.find<PetController>();
  final TimelineController _timelineController = Get.find<TimelineController>();
  PetProfile({required this.pet, Key? key}) : super(key: key) {
    _timelineController.getAllEvents(pet.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          getProfile(pet.imgUrl),
          Expanded(
              // use ListView to handle scroll
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: <Widget>[
                Row(children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(pet.name,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )
                  //IconButton(icon: Icon(Icons.edit), onPressed: null)
                ]),
                Container(
                    height: 270,
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE2E2EC)),
                    child: _Carousel([_PetProfileWindow(pet)])),
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
                    height: 130,
                    constraints: const BoxConstraints(maxHeight: 120),
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE2E2EC)),
                    child: _PetTimeLine(pet)),
                const Padding(padding: EdgeInsets.only(bottom: 16.0))
              ])),
        ],
      )),
    );
  }

  Widget getProfile(String img) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.fitWidth))),
        Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: BackButton(onPressed: () {
              Get.back();
            })),
      ],
    );
  }
}
