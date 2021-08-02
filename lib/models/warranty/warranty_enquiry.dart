// To parse this JSON data, do
//
//     final warrantyEnquiry = warrantyEnquiryFromJson(jsonString);

import 'dart:convert';

WarrantyEnquiry warrantyEnquiryFromJson(String? str) =>
    WarrantyEnquiry.fromJson(json.decode(str!));

String? warrantyEnquiryToJson(WarrantyEnquiry data) =>
    json.encode(data.toJson());

class WarrantyEnquiry {
  WarrantyEnquiry(
      {this.packageId,
      this.registrationNo,
      this.make,
      this.model,
      this.type,
      this.fuel,
      this.mileage,
      this.manufactureYear,
      this.registrationDate,
      this.chassisNo,
      this.engineNo,
      this.startDate,
      this.capacity});

  String? packageId;
  String? registrationNo;
  String? make;
  String? model;
  String? type;
  String? fuel;
  String? mileage;
  String? manufactureYear;
  String? registrationDate;
  String? chassisNo;
  String? engineNo;
  String? startDate;
  String? capacity;

  factory WarrantyEnquiry.fromJson(Map<String, dynamic> json) =>
      WarrantyEnquiry(
          packageId: json["package_id"],
          registrationNo: json["registration_no"],
          make: json["make"],
          model: json["model"],
          type: json["is_pre_owned"],
          fuel: json["is_hybrid"],
          mileage: json["mileage"],
          manufactureYear: json["manufacture_year"],
          registrationDate: json["registration_date"],
          chassisNo: json["chassis_no"],
          engineNo: json["engine_no"],
          startDate: json["start_date"],
          capacity: json["capacity"]);

  Map<String, dynamic> toJson() => {
        'package_id': packageId,
        'registration_no': registrationNo,
        'make': make,
        'model': model,
        'type': type,
        'fuel': fuel,
        'mileage': mileage,
        'manufacture_year': manufactureYear,
        'registration_date': registrationDate,
        'chassis_no': chassisNo,
        'engine_no': engineNo,
        'start_date': startDate,
        'capacity': capacity
      };
}
