// To parse this JSON data, do
//
//     final warrantyBuy = warrantyBuyFromJson(jsonString);

import 'dart:convert';

WarrantyBuy warrantyBuyFromJson(String? str) =>
    WarrantyBuy.fromJson(json.decode(str!));

String? warrantyBuyToJson(WarrantyBuy data) => json.encode(data.toJson());

class WarrantyBuy {
  WarrantyBuy({
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

  factory WarrantyBuy.fromJson(Map<String, dynamic> json) => WarrantyBuy(
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
