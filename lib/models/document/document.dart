// To parse this JSON data, do
//
//     final document = documentFromJson(jsonString);

import 'dart:convert';

List<Document> documentFromJson(String? str) =>
    List<Document>.from(json.decode(str!).map((x) => Document.fromJson(x)));

String? documentToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document {
  Document({
    this.id,
    // this.motorId,
    this.name,
    this.url,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.view,
    this.policyNo,
    this.startDate,
    this.endDate,
  });

  int? id;
  // int motorId;
  String? name;
  String? url;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? view;
  String? policyNo;
  String? startDate;
  String? endDate;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        // motorId: json["motor_id"],
        name: json["name"],
        url: json["url"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        view: json["view"],
        policyNo: json["policy_no"] == null ? "" : json["policy_no"],
        startDate: json["start_date"] == null ? "" : json["start_date"],
        endDate: json["end_date"] == null ? "" : json["end_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "motor_id": motorId,
        "name": name,
        "url": url,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "view": view,
        "policy_no": policyNo,
        "start_date": startDate,
        "end_date": endDate,
      };
}
