// To parse this JSON data, do
//
//     final workshop = workshopFromJson(jsonString);

import 'dart:convert';

List<Workshop> workshopFromJson(String? str) =>
    List<Workshop>.from(json.decode(str!).map((x) => Workshop.fromJson(x)));

String? workshopToJson(List<Workshop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Workshop {
  Workshop({
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

  factory Workshop.fromJson(Map<String, dynamic> json) => Workshop(
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
