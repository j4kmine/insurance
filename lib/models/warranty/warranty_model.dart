// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

List<WarrantyModel> modelFromJson(String? str) => List<WarrantyModel>.from(
    json.decode(str!).map((x) => WarrantyModel.fromJson(x)));

String? modelToJson(List<WarrantyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarrantyModel {
  WarrantyModel({
    this.model,
    this.total,
    this.warrantyPeriod,
    this.formatPrice,
    this.formatMaxClaim,
    this.formatMileageCoverage,
  });

  String? model;
  int? total;
  String? warrantyPeriod;
  String? formatPrice;
  String? formatMaxClaim;
  String? formatMileageCoverage;

  factory WarrantyModel.fromJson(Map<String, dynamic> json) => WarrantyModel(
        model: json["model"],
        total: json["total"],
        warrantyPeriod: json["warranty_period"],
        formatPrice: json["format_price"],
        formatMaxClaim: json["format_max_claim"],
        formatMileageCoverage: json["format_mileage_coverage"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "total": total,
        "warranty_period": warrantyPeriod,
        "format_price": formatPrice,
        "format_max_claim": formatMaxClaim,
        "format_mileage_coverage": formatMileageCoverage,
      };
}
