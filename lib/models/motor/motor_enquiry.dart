// To parse this JSON data, do
//
//     final motorEnquiry = motorEnquiryFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/driver/driver.dart';

class MotorEnquiry {
  MotorEnquiry(
      {this.usage,
      this.start_date,
      this.expiry_date,
      this.registration_no,
      this.type,
      this.model,
      this.make,
      this.engine_no,
      this.chassis_no,
      this.body_type,
      this.off_peak,
      this.modified,
      this.manufacture_year,
      this.capacity,
      this.seating_capacity,
      this.no_of_accidents,
      this.total_claim,
      this.ncd,
      this.serious_offence,
      this.physical_disable,
      this.refused,
      this.terminated,
      this.additional_drivers});

  String? usage;
  String? start_date;
  String? expiry_date;

  String? registration_no;
  String? type;
  String? model;
  String? make;
  String? engine_no;
  String? chassis_no;
  String? body_type;
  bool? off_peak;
  bool? modified;
  String? manufacture_year;
  String? capacity;
  String? seating_capacity;

  String? no_of_accidents;
  String? total_claim;
  String? ncd;
  bool? serious_offence;
  bool? physical_disable;
  bool? refused;
  bool? terminated;

  List<dynamic>? additional_drivers;

  Map<String, dynamic> toJson() => {
        "usage": usage,
        "start_date": start_date,
        "expiry_date": expiry_date,
        "registration_no": registration_no,
        "type": type,
        "model": model,
        "make": make,
        "engine_no": engine_no,
        "chassis_no": chassis_no,
        "body_type": body_type,
        "off_peak": off_peak,
        "modified": modified,
        "manufacture_year": manufacture_year,
        "capacity": capacity,
        "seating_capacity": seating_capacity,
        "no_of_accidents": no_of_accidents,
        "total_claim": total_claim,
        "ncd": ncd,
        "serious_offence": serious_offence,
        "physical_disable": physical_disable,
        "refused": refused,
        "terminated": terminated,
        "additional_drivers": additional_drivers
      };
}
