import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  String activity;
  String type;
  int participants;
  double price;
  String key;
  double accessibility;

  Activity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.key,
    required this.accessibility,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activity: json["activity"],
        type: json["type"],
        participants: json["participants"],
        price: double.tryParse(json["price"].toString()) ?? 0.0,
        key: json["key"],
        accessibility: double.tryParse(json["accessibility"].toString()) ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "price": price,
        "key": key,
        "accessibility": accessibility,
      };
}
