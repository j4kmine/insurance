// To parse this JSON data, do
//
//     final accidentVehicleInfo = accidentVehicleInfoFromJson(jsonString);

import 'dart:convert';

VehicleInfo vehicleInfoFromJson(String? str) =>
    VehicleInfo.fromJson(json.decode(str!));

String? vehicleInfoToJson(VehicleInfo data) => json.encode(data.toJson());

class VehicleInfo {
  VehicleInfo({
    this.vehicleId,
    this.registrationNo,
    this.vehicleMake,
    this.vehicleModel,
    this.insuranceCompany,
    this.certificateNumber,
    this.insuredNric,
    this.insuredName,
    this.insuredContactNumber,
  });

  int? vehicleId;
  String? registrationNo;
  String? vehicleMake;
  String? vehicleModel;
  String? insuranceCompany;
  String? certificateNumber;
  String? insuredNric;
  String? insuredName;
  dynamic insuredContactNumber;

  factory VehicleInfo.fromJson(Map<String, dynamic> json) => VehicleInfo(
        vehicleId: json["vehicle_id"],
        registrationNo: json["registration_no"],
        vehicleMake: json["vehicle_make"],
        vehicleModel: json["vehicle_model"],
        insuranceCompany: json["insurance_company"],
        certificateNumber: json["certificate_number"],
        insuredNric: json["insured_nric"],
        insuredName: json["insured_name"],
        insuredContactNumber: json["insured_contact_number"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "registration_no": registrationNo,
        "vehicle_make": vehicleMake,
        "vehicle_model": vehicleModel,
        "insurance_company": insuranceCompany,
        "certificate_number": certificateNumber,
        "insured_nric": insuredNric,
        "insured_name": insuredName,
        "insured_contact_number": insuredContactNumber,
      };
}
