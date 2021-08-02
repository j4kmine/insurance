// To parse this JSON data, do
//
//     final accident = accidentFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/workshop/workshop.dart';

Accident accidentFromJson(String? str) => Accident.fromJson(json.decode(str!));

String? accidentToJson(Accident data) => json.encode(data.toJson());

class Accident {
  Accident({
    this.id,
    this.refNo,
    this.customerId,
    this.vehicleId,
    this.dateOfAccident,
    this.locationOfAccident,
    this.weatherRoadCondition,
    this.reportingType,
    this.numberOfPassengers,
    this.isVideoCaptured,
    this.purposeOfUse,
    this.details,
    this.vehicleMake,
    this.vehicleModel,
    this.insuranceCompany,
    this.certificateNumber,
    this.insuredNric,
    this.insuredName,
    this.insuredContactNumber,
    this.isVisitingWorkshop,
    this.workshopId,
    this.workshopVisitDate,
    this.isOwnerDrives,
    this.ownerDriverRelationship,
    this.driverName,
    this.driverNric,
    this.driverDob,
    this.driverLicense,
    this.driverAddress,
    this.driverContactNo,
    this.driverEmail,
    this.driverOccupation,
    this.isOtherVehicle,
    this.otherVehicleCarPlate,
    this.otherVehicleMake,
    this.otherVehicleModel,
    this.otherDriverName,
    this.otherDriverNric,
    this.otherDriverContactNo,
    this.otherDriverAddress,
    this.status,
    this.createdAt,
    this.formatAppointmentDate,
    this.formatAppointmentTime,
    this.formatAccidentDate,
    this.formatAccidentTime,
    this.formatDob,
    this.formatLicenseDate,
    this.updatedAt,
    this.deletedAt,
    this.workshop,
    this.documents,
    this.vehicle,
  });

  int? id;
  dynamic refNo;
  int? customerId;
  int? vehicleId;
  DateTime? dateOfAccident;
  String? locationOfAccident;
  String? weatherRoadCondition;
  String? reportingType;
  int? numberOfPassengers;
  int? isVideoCaptured;
  String? purposeOfUse;
  String? details;
  String? vehicleMake;
  String? vehicleModel;
  String? insuranceCompany;
  String? certificateNumber;
  String? insuredNric;
  String? insuredName;
  String? insuredContactNumber;
  int? isVisitingWorkshop;
  int? workshopId;
  DateTime? workshopVisitDate;
  int? isOwnerDrives;
  String? ownerDriverRelationship;
  String? driverName;
  String? driverNric;
  String? driverDob;
  String? driverLicense;
  dynamic driverAddress;
  dynamic driverContactNo;
  dynamic driverEmail;
  dynamic driverOccupation;
  int? isOtherVehicle;
  dynamic otherVehicleCarPlate;
  dynamic otherVehicleMake;
  dynamic otherVehicleModel;
  dynamic otherDriverName;
  dynamic otherDriverNric;
  dynamic otherDriverContactNo;
  dynamic otherDriverAddress;
  String? status;
  String? createdAt;
  String? formatAppointmentDate;
  String? formatAppointmentTime;
  String? formatAccidentDate;
  String? formatAccidentTime;
  String? formatDob;
  String? formatLicenseDate;
  DateTime? updatedAt;
  dynamic deletedAt;
  Workshop? workshop;
  List<Document>? documents;
  Vehicle? vehicle;

  factory Accident.fromJson(Map<String, dynamic> json) => Accident(
        id: json["id"],
        refNo: json["ref_no"],
        customerId: json["customer_id"],
        vehicleId: json["vehicle_id"],
        dateOfAccident: DateTime.parse(json["date_of_accident"]),
        locationOfAccident: json["location_of_accident"],
        weatherRoadCondition: json["weather_road_condition"],
        reportingType: json["reporting_type"],
        numberOfPassengers: json["number_of_passengers"],
        isVideoCaptured: json["is_video_captured"],
        purposeOfUse: json["purpose_of_use"],
        details: json["details"],
        vehicleMake: json["vehicle_make"],
        vehicleModel: json["vehicle_model"],
        insuranceCompany: json["insurance_company"],
        certificateNumber: json["certificate_number"],
        insuredNric: json["insured_nric"],
        insuredName: json["insured_name"],
        insuredContactNumber: json["insured_contact_number"],
        isVisitingWorkshop: json["is_visiting_workshop"],
        workshopId: json["workshop_id"],
        workshopVisitDate: DateTime.parse(json["workshop_visit_date"]),
        isOwnerDrives: json["is_owner_drives"],
        ownerDriverRelationship: json["owner_driver_relationship"],
        driverName: json["driver_name"],
        driverNric: json["driver_nric"],
        driverDob: json["driver_dob"],
        driverLicense: json["driver_license"],
        driverAddress: json["driver_address"],
        driverContactNo: json["driver_contact_no"],
        driverEmail: json["driver_email"],
        driverOccupation: json["driver_occupation"],
        isOtherVehicle: json["is_other_vehicle"],
        otherVehicleCarPlate: json["other_vehicle_car_plate"],
        otherVehicleMake: json["other_vehicle_make"],
        otherVehicleModel: json["other_vehicle_model"],
        otherDriverName: json["other_driver_name"],
        otherDriverNric: json["other_driver_nric"],
        otherDriverContactNo: json["other_driver_contact_no"],
        otherDriverAddress: json["other_driver_address"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        formatAppointmentDate: json["format_appointment_date"],
        formatAppointmentTime: json["format_appointment_time"],
        formatAccidentDate: json["format_accident_date"],
        formatAccidentTime: json["format_accident_time"],
        formatDob: json["format_dob"],
        formatLicenseDate: json["format_license_date"],
        documents: json["documents"] != null
            ? List<Document>.from(
                json["documents"].map((x) => Document.fromJson(x)))
            : null,
        workshop: Workshop.fromJson(json["workshop"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_no": refNo,
        "customer_id": customerId,
        "vehicle_id": vehicleId,
        "date_of_accident": dateOfAccident!.toIso8601String(),
        "location_of_accident": locationOfAccident,
        "weather_road_condition": weatherRoadCondition,
        "reporting_type": reportingType,
        "number_of_passengers": numberOfPassengers,
        "is_video_captured": isVideoCaptured,
        "purpose_of_use": purposeOfUse,
        "details": details,
        "vehicle_make": vehicleMake,
        "vehicle_model": vehicleModel,
        "insurance_company": insuranceCompany,
        "certificate_number": certificateNumber,
        "insured_nric": insuredNric,
        "insured_name": insuredName,
        "insured_contact_number": insuredContactNumber,
        "is_visiting_workshop": isVisitingWorkshop,
        "workshop_id": workshopId,
        "workshop_visit_date": workshopVisitDate!.toIso8601String(),
        "is_owner_drives": isOwnerDrives,
        "owner_driver_relationship": ownerDriverRelationship,
        "driver_name": driverName,
        "driver_nric": driverNric,
        "driver_dob": driverDob,
        "driver_license": driverLicense,
        "driver_address": driverAddress,
        "driver_contact_no": driverContactNo,
        "driver_email": driverEmail,
        "driver_occupation": driverOccupation,
        "is_other_vehicle": isOtherVehicle,
        "other_vehicle_car_plate": otherVehicleCarPlate,
        "other_vehicle_make": otherVehicleMake,
        "other_vehicle_model": otherVehicleModel,
        "other_driver_name": otherDriverName,
        "other_driver_nric": otherDriverNric,
        "other_driver_contact_no": otherDriverContactNo,
        "other_driver_address": otherDriverAddress,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "workshop": workshop!.toJson(),
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
        "vehicle": vehicle!.toJson(),
      };
}
