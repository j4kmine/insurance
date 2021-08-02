// To parse this JSON data, do
//
//     final warrantyPrice = warrantyPriceFromJson(jsonString);

import 'dart:convert';

List<WarrantyPrice> warrantyPriceFromJson(String? str) =>
    List<WarrantyPrice>.from(
        json.decode(str!).map((x) => WarrantyPrice.fromJson(x)));

String? warrantyPriceToJson(List<WarrantyPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarrantyPrice {
  WarrantyPrice({
    this.id,
    this.make,
    this.model,
    this.category,
    this.capacity,
    this.type,
    this.fuel,
    this.price,
    this.maxClaim,
    this.mileageCoverage,
    this.warrantyDuration,
    this.insurerId,
    this.package,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.warrantyPeriod,
    this.formatPrice,
    this.formatMaxClaim,
    this.formatPremiumPerYear,
    this.formatMileageCoverage,
    this.insurer,
  });

  int? id;
  String? make;
  String? model;
  String? category;
  int? capacity;
  String? type;
  String? fuel;
  String? price;
  int? maxClaim;
  int? mileageCoverage;
  String? warrantyDuration;
  int? insurerId;
  String? package;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? warrantyPeriod;
  String? formatPrice;
  String? formatMaxClaim;
  String? formatPremiumPerYear;
  String? formatMileageCoverage;
  Insurer? insurer;

  factory WarrantyPrice.fromJson(Map<String, dynamic> json) => WarrantyPrice(
        id: json["id"],
        make: json["make"],
        model: json["model"],
        category: json["category"],
        capacity: json["capacity"],
        type: json["type"],
        fuel: json["fuel"],
        price: json["price"],
        maxClaim: json["max_claim"],
        mileageCoverage: json["mileage_coverage"],
        warrantyDuration: json["warranty_duration"],
        insurerId: json["insurer_id"],
        package: json["package"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        warrantyPeriod: json["warranty_period"],
        formatPrice: json["format_price"],
        formatMaxClaim: json["format_max_claim"],
        formatMileageCoverage: json["format_mileage_coverage"],
        formatPremiumPerYear: json["format_premium_per_year"],
        insurer: Insurer.fromJson(json["insurer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "make": make,
        "model": model,
        "category": category,
        "capacity": capacity,
        "type": type,
        "fuel": fuel,
        "price": price,
        "max_claim": maxClaim,
        "mileage_coverage": mileageCoverage,
        "warranty_duration": warrantyDuration,
        "insurer_id": insurerId,
        "package": package,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "warranty_period": warrantyPeriod,
        "format_price": formatPrice,
        "format_max_claim": formatMaxClaim,
        "format_mileage_coverage": formatMileageCoverage,
        "formatPremiumPerYear": formatPremiumPerYear,
        "insurer": insurer!.toJson(),
      };
}

class Insurer {
  Insurer({
    this.id,
    this.name,
    this.code,
    this.acra,
    this.address,
    this.contactNo,
    this.contactPerson,
    this.contactEmail,
    this.description,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  int? id;
  String? name;
  String? code;
  String? acra;
  String? address;
  String? contactNo;
  String? contactPerson;
  String? contactEmail;
  String? description;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? count;

  factory Insurer.fromJson(Map<String, dynamic> json) => Insurer(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        acra: json["acra"],
        address: json["address"],
        contactNo: json["contact_no"],
        contactPerson: json["contact_person"],
        contactEmail: json["contact_email"],
        description: json["description"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "acra": acra,
        "address": address,
        "contact_no": contactNo,
        "contact_person": contactPerson,
        "contact_email": contactEmail,
        "description": description,
        "type": type,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "count": count,
      };
}
