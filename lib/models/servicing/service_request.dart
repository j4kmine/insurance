// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

ServiceRequest serviceRequestFromJson(String? str) =>
    ServiceRequest.fromJson(json.decode(str!));

String? serviceRequestToJson(ServiceRequest data) => json.encode(data.toJson());

class ServiceRequest {
  ServiceRequest(
      {this.vehicleId,
      this.workshopId,
      this.serviceTypeId,
      this.appointmentDate,
      this.appointmentTime,
      this.remarks});

  String? vehicleId;
  String? workshopId;
  String? serviceTypeId;
  String? appointmentDate;
  String? appointmentTime;
  String? remarks;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
      vehicleId: json["vehicle_id"],
      workshopId: json["workshop_id"],
      serviceTypeId: json["service_type_id"],
      appointmentDate: json["appointment_date"],
      appointmentTime: json["appointment_time"],
      remarks: json["remarks"]);

  Map<String, dynamic> toJson() => {
        'vehicle_id': vehicleId,
        'workshop_id': workshopId,
        'service_type_id': serviceTypeId,
        'appointment_date': appointmentDate,
        'appointment_time': appointmentTime,
        'remarks': remarks
      };
}
