// To parse this JSON data, do
//
//     final motorBuy = motorBuyFromJson(jsonString);

import 'dart:convert';

MotorBuy motorBuyFromJson(String? str) => MotorBuy.fromJson(json.decode(str!));

String? motorBuyToJson(MotorBuy data) => json.encode(data.toJson());

class MotorBuy {
  MotorBuy({
    this.priceId,
    this.registrationNo,
    this.mileage,
    this.manufactureYear,
    this.registrationDate,
    this.chassisNo,
    this.engineNo,
    this.startDate,
  });

  int? priceId;
  String? registrationNo;
  String? mileage;
  String? manufactureYear;
  String? registrationDate;
  String? chassisNo;
  String? engineNo;
  String? startDate;

  factory MotorBuy.fromJson(Map<String, dynamic> json) => MotorBuy(
        priceId: json["price_id"],
        registrationNo: json["registration_no"],
        mileage: json["mileage"],
        manufactureYear: json["manufacture_year"],
        registrationDate: json["registration_date"],
        chassisNo: json["chassis_no"],
        engineNo: json["engine_no"],
        startDate: json["start_date"],
      );

  Map<String, dynamic> toJson() => {
        'price_id': priceId,
        'registration_no': registrationNo,
        'mileage': mileage,
        'manufacture_year': manufactureYear,
        'registration_date': registrationDate,
        'chassis_no': chassisNo,
        'engine_no': engineNo,
        'start_date': startDate
      };
}
