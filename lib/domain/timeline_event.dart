class TimelineEvent {
  String id;
  String petId;
  String name;
  String description;
  DateTime date;
  TimelineEvent(
      {required this.id,
      required this.petId,
      required this.name,
      this.description = "",
      required this.date});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["_id"] = id;
    data["petId"] = petId;
    data['eventName'] = name;
    data['eventDescription'] = description;
    data['eventDate'] = date.toString();
    return data;
  }

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    String dateStr = json["eventDate"];
    dateStr = dateStr.replaceAll("/", "-"); //handle these cases
    return TimelineEvent(
      id: json["_id"],
      petId: json["petId"],
      name: json["eventName"],
      description: json["eventDescription"],
      date: DateTime.parse(dateStr),
    );
  }
}
