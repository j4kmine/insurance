// To parse this JSON data, do
//
//     final serviceSlot = serviceSlotFromJson(jsonString);

import 'dart:convert';

List<ServiceSlot> serviceSlotFromJson(String? str) => List<ServiceSlot>.from(
    json.decode(str!).map((x) => ServiceSlot.fromJson(x)));

String? serviceSlotToJson(List<ServiceSlot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceSlot {
  ServiceSlot({
    this.id,
    this.workshopId,
    this.day,
    this.timeStart,
    this.timeEnd,
    this.interval,
    this.slotsPerInterval,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? workshopId;
  String? day;
  String? timeStart;
  String? timeEnd;
  int? interval;
  int? slotsPerInterval;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ServiceSlot.fromJson(Map<String, dynamic> json) => ServiceSlot(
        id: json["id"],
        workshopId: json["workshop_id"],
        day: json["day"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        interval: json["interval"],
        slotsPerInterval: json["slots_per_interval"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workshop_id": workshopId,
        "day": day,
        "time_start": timeStart,
        "time_end": timeEnd,
        "interval": interval,
        "slots_per_interval": slotsPerInterval,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
