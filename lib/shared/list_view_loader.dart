import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ListLoader extends StatefulWidget {
  ListLoader({required this.numberOfFields});
  final int numberOfFields;
  @override
  State<ListLoader> createState() => _ListLoaderState();
}

class _ListLoaderState extends State<ListLoader> {
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 160,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: SkeletonAnimation(
                  shimmerColor: Color(0xffE2E2EC),
                  borderRadius: BorderRadius.circular(20),
                  shimmerDuration: 1000,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffE2E2EC),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: shadowList,
                    ),
                    margin: EdgeInsets.only(top: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 40, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    boxShadow: shadowList,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                        child: SkeletonAnimation(
                          borderRadius: BorderRadius.circular(5.0),
                          shimmerColor:
                              index % 2 != 0 ? Colors.grey : Colors.white54,
                          child: Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            shimmerColor:
                                index % 2 != 0 ? Colors.grey : Colors.white54,
                            child: Container(
                              width: 60,
                              height: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
