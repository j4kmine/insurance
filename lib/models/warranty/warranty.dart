// To parse this JSON data, do
//
//     final warranty = warrantyFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/proposer/proposer.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';

List<Warranty> warrantyFromJson(String? str) =>
    List<Warranty>.from(json.decode(str!).map((x) => Warranty.fromJson(x)));

String? warrantyToJson(List<Warranty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Warranty {
  Warranty({
    this.id,
    this.refNo,
    this.ciNo,
    this.customerId,
    this.vehicleId,
    this.proposerId,
    this.dealerId,
    this.creatorId,
    this.insurerId,
    this.package,
    this.price,
    this.maxClaim,
    this.mileage,
    this.mileageCoverage,
    this.warrantyDuration,
    this.startDate,
    this.remarks,
    this.status,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
    this.formatPrice,
    this.formatMaxClaim,
    this.formatMileageCoverage,
    this.formatStartDate,
    this.formatSubmittedAt,
    this.formatPremiumPerYear,
    this.formatValidTill,
    this.endDate,
    this.warrantyPeriod,
    this.insurerCode,
    this.vehicle,
    this.documents,
    this.proposer,
  });

  int? id;
  String? refNo;
  dynamic ciNo;
  dynamic customerId;
  int? vehicleId;
  int? proposerId;
  int? dealerId;
  int? creatorId;
  int? insurerId;
  String? package;
  String? price;
  int? maxClaim;
  dynamic mileage;
  int? mileageCoverage;
  String? warrantyDuration;
  DateTime? startDate;
  String? remarks;
  String? status;
  dynamic expiryDate;
  String? createdAt;
  String? updatedAt;
  String? formatPrice;
  String? formatMaxClaim;
  String? formatMileageCoverage;
  String? formatStartDate;
  String? formatSubmittedAt;
  String? formatValidTill;
  String? formatPremiumPerYear;
  String? endDate;
  String? warrantyPeriod;
  String? insurerCode;
  Vehicle? vehicle;
  List<Document>? documents;
  Proposer? proposer;

  factory Warranty.fromJson(Map<String, dynamic> json) => Warranty(
        id: json["id"],
        refNo: json["ref_no"],
        ciNo: json["ci_no"],
        customerId: json["customer_id"],
        vehicleId: json["vehicle_id"],
        proposerId: json["proposer_id"],
        dealerId: json["dealer_id"],
        creatorId: json["creator_id"],
        insurerId: json["insurer_id"],
        package: json["package"],
        price: json["price"],
        maxClaim: json["max_claim"],
        mileage: json["mileage"],
        mileageCoverage: json["mileage_coverage"],
        warrantyDuration: json["warranty_duration"],
        startDate: DateTime.parse(json["start_date"]),
        remarks: json["remarks"],
        status: json["status"],
        expiryDate: json["expiry_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        formatPrice: json["format_price"],
        formatMaxClaim: json["format_max_claim"],
        formatMileageCoverage: json["format_mileage_coverage"],
        formatStartDate: json["format_start_date"],
        formatSubmittedAt: json["format_submitted_at"],
        formatValidTill: json["format_valid_till"],
        formatPremiumPerYear: json["format_premium_per_year"],
        endDate: json["end_date"],
        warrantyPeriod: json["warranty_period"],
        insurerCode: json["insurer"] != null ? json["insurer"]["code"] : null,
        vehicle:
            json["vehicle"] != null ? Vehicle.fromJson(json["vehicle"]) : null,
        documents: json["documents"] != null
            ? List<Document>.from(
                json["documents"].map((x) => Document.fromJson(x)))
            : null,
        proposer: json["proposer"] != null
            ? Proposer.fromJson(json["proposer"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_no": refNo,
        "ci_no": ciNo,
        "customer_id": customerId,
        "vehicle_id": vehicleId,
        "proposer_id": proposerId,
        "dealer_id": dealerId,
        "creator_id": creatorId,
        "insurer_id": insurerId,
        "package": package,
        "price": price,
        "max_claim": maxClaim,
        "mileage": mileage,
        "mileage_coverage": mileageCoverage,
        "warranty_duration": warrantyDuration,
        "start_date": startDate!.toIso8601String(),
        "remarks": remarks,
        "status": status,
        "expiry_date": expiryDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "format_price": formatPrice,
        "format_max_claim": formatMaxClaim,
        "format_mileage_coverage": formatMileageCoverage,
        "format_start_date": formatStartDate,
        "format_submitted_at": formatSubmittedAt,
        "format_valid_till": formatValidTill,
        "format_premium_per_year": formatPremiumPerYear,
        "end_date": endDate,
        "warranty_period": warrantyPeriod,
        "insurer_code": insurerCode,
        "vehicle": vehicle!.toJson(),
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
        "proposer": proposer!.toJson(),
      };
}
