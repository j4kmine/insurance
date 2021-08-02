// To parse this JSON data, do
//
//     final motorSearchCar = motorSearchCarFromJson(jsonString);

import 'dart:convert';

MotorSearchCar motorSearchCarFromJson(String str) =>
    MotorSearchCar.fromJson(json.decode(str));

String motorSearchCarToJson(MotorSearchCar data) => json.encode(data.toJson());

class MotorSearchCar {
  MotorSearchCar({
    this.bodyType,
    this.capacity,
  });

  String? bodyType;
  String? capacity;

  factory MotorSearchCar.fromJson(Map<String, dynamic> json) => MotorSearchCar(
        bodyType: json["body_type"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "body_type": bodyType,
        "capacity": capacity,
      };
}
