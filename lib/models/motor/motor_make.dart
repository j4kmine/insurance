import 'dart:convert';

List<MotorMake> motorListFromJson(String str) =>
    List<MotorMake>.from(json.decode(str).map((x) => MotorMake.fromJson(x)));

String motorListToJson(List<MotorMake> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MotorMake {
  MotorMake({
    this.make,
  });

  String? make;

  factory MotorMake.fromJson(Map<String, dynamic> json) =>
      MotorMake(make: json["make"]);

  Map<String, dynamic> toJson() => {
        "make": make,
      };
}
