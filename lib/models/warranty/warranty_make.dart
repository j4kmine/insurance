import 'dart:convert';

List<WarrantyMake> makeListFromJson(String? str) => List<WarrantyMake>.from(
    json.decode(str!).map((x) => WarrantyMake.fromJson(x)));

String? makeListToJson(List<WarrantyMake> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarrantyMake {
  WarrantyMake({
    this.make,
    this.total,
    this.warrantyPeriod,
    this.formatPrice,
    this.formatMaxClaim,
    this.formatMileageCoverage,
  });

  String? make;
  int? total;
  String? warrantyPeriod;
  String? formatPrice;
  String? formatMaxClaim;
  String? formatMileageCoverage;

  factory WarrantyMake.fromJson(Map<String, dynamic> json) => WarrantyMake(
        make: json["make"],
        total: json["total"],
        warrantyPeriod: json["warranty_period"],
        formatPrice: json["format_price"],
        formatMaxClaim: json["format_max_claim"],
        formatMileageCoverage: json["format_mileage_coverage"],
      );

  Map<String, dynamic> toJson() => {
        "make": make,
        "total": total,
        "warranty_period": warrantyPeriod,
        "format_price": formatPrice,
        "format_max_claim": formatMaxClaim,
        "format_mileage_coverage": formatMileageCoverage,
      };
}
