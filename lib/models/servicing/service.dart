// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/servicing/service_type.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/workshop/workshop.dart';

List<Service> serviceFromJson(String? str) =>
    List<Service>.from(json.decode(str!).map((x) => Service.fromJson(x)));

String? serviceToJson(List<Service> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Service {
  Service({
    this.id,
    this.refNo,
    this.customerId,
    this.vehicleId,
    this.workshopId,
    this.serviceTypeId,
    this.appointmentDate,
    this.formatAppointmentDate,
    this.formatAppointmentTime,
    this.status,
    this.rescheduledCount,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.workshop,
    this.vehicle,
    this.serviceType,
    this.documents,
  });

  int? id;
  dynamic refNo;
  int? customerId;
  int? vehicleId;
  int? workshopId;
  int? serviceTypeId;
  DateTime? appointmentDate;
  String? status;
  int? rescheduledCount;
  String? remarks;
  String? formatAppointmentDate;
  String? formatAppointmentTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Workshop? workshop;
  Vehicle? vehicle;
  ServiceType? serviceType;
  List<Document>? documents;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        refNo: json["ref_no"],
        customerId: json["customer_id"],
        vehicleId: json["vehicle_id"],
        workshopId: json["workshop_id"],
        serviceTypeId: json["service_type_id"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        formatAppointmentDate: json["format_appointment_date"],
        formatAppointmentTime: json["format_appointment_time"],
        status: json["status"],
        rescheduledCount: json["rescheduled_count"],
        remarks: json["remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        workshop: Workshop.fromJson(json["workshop"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        serviceType: ServiceType.fromJson(json["service_type"]),
        documents: json["documents"] != null
            ? List<Document>.from(
                json["documents"].map((x) => Document.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_no": refNo,
        "customer_id": customerId,
        "vehicle_id": vehicleId,
        "workshop_id": workshopId,
        "service_type_id": serviceTypeId,
        "appointment_date": appointmentDate!.toIso8601String(),
        "format_appointment_date": formatAppointmentDate,
        "format_appointment_time": formatAppointmentTime,
        "status": status,
        "rescheduled_count": rescheduledCount,
        "remarks": remarks,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "workshop": workshop!.toJson(),
        "service_type": serviceType!.toJson(),
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}
