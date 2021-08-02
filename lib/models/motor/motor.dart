// To parse this JSON data, do
//
//     final motor = motorFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';

List<Motor> motorFromJson(String? str) =>
    List<Motor>.from(json.decode(str!).map((x) => Motor.fromJson(x)));

String? motorToJson(List<Motor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Motor {
  Motor(
      {this.id,
      this.refNo,
      this.ciNo,
      this.policyNo,
      this.usage,
      this.price,
      this.point,
      this.policyholderDriving,
      this.startDate,
      this.expiryDate,
      this.remarks,
      this.insurerId,
      this.dealerId,
      this.creatorId,
      this.vehicleId,
      this.driverId,
      this.proposerId,
      this.status,
      this.quoteValidTill,
      this.createdAt,
      this.submittedAt,
      this.updatedAt,
      this.formatStartDate,
      this.formatExpiryDate,
      this.formatSubmittedAt,
      this.formatValidTill,
      this.formatPrice,
      this.insurerCode,
      this.vehicle,
      this.documents,
      this.drivers});

  int? id;
  String? refNo;
  String? ciNo;
  String? policyNo;
  String? usage;
  String? price;
  int? point;
  int? policyholderDriving;
  DateTime? startDate;
  DateTime? expiryDate;
  String? remarks;
  int? insurerId;
  int? dealerId;
  int? creatorId;
  int? vehicleId;
  int? driverId;
  int? proposerId;
  String? status;
  String? quoteValidTill;
  String? createdAt;
  String? submittedAt;
  String? updatedAt;
  String? formatStartDate;
  String? formatExpiryDate;
  String? formatSubmittedAt;
  String? formatValidTill;
  String? formatPrice;
  String? insurerCode;
  Vehicle? vehicle;
  List<Document>? documents;
  List<Driver>? drivers;

  factory Motor.fromJson(Map<String, dynamic> json) => Motor(
        id: json["id"],
        refNo: json["ref_no"],
        ciNo: json["ci_no"] == null ? null : json["ci_no"],
        policyNo: json["policy_no"] == null ? null : json["policy_no"],
        usage: json["usage"],
        price: json["price"] == null ? null : json["price"],
        point: json["point"] == null ? null : json["point"],
        policyholderDriving: json["policyholder_driving"],
        startDate: DateTime.parse(json["start_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
        remarks: json["remarks"],
        insurerId: json["insurer_id"],
        dealerId: json["dealer_id"],
        creatorId: json["creator_id"],
        vehicleId: json["vehicle_id"],
        driverId: json["driver_id"],
        proposerId: json["proposer_id"],
        status: json["status"],
        quoteValidTill: json["quote_valid_till"],
        createdAt: json["created_at"],
        submittedAt: json["submitted_at"],
        updatedAt: json["updated_at"],
        formatStartDate: json["format_start_date"],
        formatExpiryDate: json["format_expiry_date"],
        formatSubmittedAt: json["format_submitted_at"],
        formatValidTill: json["format_valid_till"],
        formatPrice: json["format_price"],
        insurerCode: json["insurer"] != null ? json["insurer"]["code"] : null,
        vehicle:
            json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"]) : null,
        documents: json["documents"] != null
            ? List<Document>.from(
                json["documents"].map((x) => Document.fromJson(x)))
            : null,
        drivers: json["drivers"] != null
            ? List<Driver>.from(
                json["drivers"].map((x) => Driver.fromJson(x["driver"])))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_no": refNo,
        "ci_no": ciNo == null ? null : ciNo,
        "policy_no": policyNo == null ? null : policyNo,
        "usage": usage,
        "price": price == null ? null : price,
        "point": point == null ? null : point,
        "policyholder_driving": policyholderDriving,
        "start_date": startDate!.toIso8601String(),
        "expiry_date": expiryDate!.toIso8601String(),
        "remarks": remarks,
        "insurer_id": insurerId,
        "dealer_id": dealerId,
        "creator_id": creatorId,
        "vehicle_id": vehicleId,
        "driver_id": driverId,
        "proposer_id": proposerId,
        "status": status,
        "quote_valid_till": quoteValidTill,
        "created_at": createdAt,
        "submitted_at": submittedAt,
        "updated_at": updatedAt,
        "format_start_date": formatStartDate,
        "format_expiry_date": formatExpiryDate,
        "format_submitted_at": formatSubmittedAt,
        "format_valid_till": formatValidTill,
        "format_price": formatPrice,
        "vehicle": vehicle!.toJson(),
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
        "drivers": List<dynamic>.from(drivers!.map((x) => x.toJson())),
        "insurerCode": insurerCode
      };
}
