import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final String id;

  const Event(
      {required this.title,
      required this.description,
      required this.from,
      required this.to,
      this.backgroundColor = Colors.red,
      this.isAllDay = false,
      required this.id});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data['title'] = title;
    data['description'] = description;
    data['from'] = from.toString();
    data['to'] = to.toString();
    data['bgColor'] = backgroundColor.value.toString();
    data['isAllDay'] = isAllDay;
    return data;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      backgroundColor: Color(int.parse(json["bgColor"])),
      isAllDay: json["isAllDay"],
    );
  }
}
