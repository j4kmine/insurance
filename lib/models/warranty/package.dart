// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

List<WarrantyPackage> packageFromJson(String? str) =>
    List<WarrantyPackage>.from(
        json.decode(str!).map((x) => WarrantyPackage.fromJson(x)));

String? packageToJson(List<WarrantyPackage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarrantyPackage {
  WarrantyPackage({
    this.id,
    this.name,
    this.duration,
    this.mileageCoverage,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.packagePeriod,
    this.formatMileageCoverage,
  });

  int? id;
  String? name;
  String? duration;
  int? mileageCoverage;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? packagePeriod;
  String? formatMileageCoverage;

  factory WarrantyPackage.fromJson(Map<String, dynamic> json) =>
      WarrantyPackage(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        mileageCoverage: json["mileage_coverage"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        packagePeriod: json["package_period"],
        formatMileageCoverage: json["format_mileage_coverage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "mileage_coverage": mileageCoverage,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "package_period": packagePeriod,
        "format_mileage_coverage": formatMileageCoverage,
      };
}
