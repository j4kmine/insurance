// To parse this JSON data, do
//
//     final serviceType = serviceTypeFromJson(jsonString);

import 'dart:convert';

List<ServiceType> serviceTypeFromJson(String str) => List<ServiceType>.from(
    json.decode(str).map((x) => ServiceType.fromJson(x)));

String serviceTypeToJson(List<ServiceType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceType {
  ServiceType({
    this.id,
    this.workshopId,
    this.name,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? workshopId;
  String? name;
  String? status;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["id"],
        workshopId: json["workshop_id"],
        name: json["name"],
        status: json["status"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workshop_id": workshopId,
        "name": name,
        "status": status,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
