// To parse this JSON data, do
//
//     final accidentSubmit = accidentSubmitFromJson(jsonString);

import 'dart:convert';

AccidentSubmit accidentSubmitFromJson(String? str) =>
    AccidentSubmit.fromJson(json.decode(str!));

String? accidentSubmitToJson(AccidentSubmit data) => json.encode(data.toJson());

class AccidentSubmit {
  AccidentSubmit(
      {this.vehicleId,
      this.vehicleMake,
      this.vehicleModel,
      this.insuranceCompany,
      this.certificateNumber,
      this.insuredNric,
      this.insuredName,
      this.insuredContactNumber,
      this.dateOfAccident,
      this.timeOfAccident,
      this.locationOfAccident,
      this.weatherRoadCondition,
      this.reportingType,
      this.numberOfPassengers,
      this.isVideoCaptured,
      this.purposeOfUse,
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
      this.otherVehicle,
      this.otherVehicleCarPlate,
      this.otherVehicleMake,
      this.otherVehicleModel,
      this.otherDriverName,
      this.otherDriverNric,
      this.otherDriverContactNo,
      this.otherDriverAddress,
      this.isVisitingWorkshop,
      this.workshopId,
      this.workshopVisitDate,
      this.workshopVisitTime,
      this.details});

  String? vehicleId;
  String? vehicleMake;
  String? vehicleModel;
  String? insuranceCompany;
  String? certificateNumber;
  String? insuredNric;
  String? insuredName;
  String? insuredContactNumber;
  String? dateOfAccident;
  String? timeOfAccident;
  String? locationOfAccident;
  String? weatherRoadCondition;
  String? reportingType;
  String? numberOfPassengers;
  String? isVideoCaptured;
  String? purposeOfUse;
  String? isOwnerDrives;
  String? ownerDriverRelationship;

  String? driverName;
  String? driverNric;
  String? driverDob;
  String? driverLicense;
  String? driverAddress;
  String? driverContactNo;
  String? driverEmail;
  String? driverOccupation;
  String? otherVehicle;
  String? otherVehicleCarPlate;
  String? otherVehicleMake;
  String? otherVehicleModel;
  String? otherDriverName;
  String? otherDriverNric;
  String? otherDriverContactNo;
  String? otherDriverAddress;

  String? isVisitingWorkshop;
  String? workshopId;
  String? workshopVisitDate;
  String? workshopVisitTime;

  String? details;

  factory AccidentSubmit.fromJson(Map<String, dynamic> json) => AccidentSubmit(
        vehicleId: json["vehicle_id"],
        vehicleMake: json["vehicle_make"],
        vehicleModel: json["vehicle_model"],
        insuranceCompany: json["insurance_company"],
        certificateNumber: json["certificate_number"],
        insuredNric: json["insured_nric"],
        insuredName: json["insured_name"],
        insuredContactNumber: json["insured_contact_number"],
        dateOfAccident: json["date_of_accident"],
        timeOfAccident: json["time_of_accident"],
        locationOfAccident: json["location_of_accident"],
        weatherRoadCondition: json["weather_road_condition"],
        reportingType: json["reporting_type"],
        numberOfPassengers: json["number_of_passengers"],
        isVideoCaptured: json["is_video_captured"],
        purposeOfUse: json["purpose_of_use"],
        isOwnerDrives: json["is_owner_drives"],
        ownerDriverRelationship: json["owner_driver_relationship"],
        isVisitingWorkshop: json["is_visiting_workshop"],
        workshopId: json["workshop_id"],
        workshopVisitDate: json["workshop_visit_date"],
        workshopVisitTime: json["workshop_visit_time"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "vehicle_make": vehicleMake,
        "vehicle_model": vehicleModel,
        "insurance_company": insuranceCompany,
        "certificate_number": certificateNumber,
        "insured_nric": insuredNric,
        "insured_name": insuredName,
        "insured_contact_number": insuredContactNumber,
        "date_of_accident": dateOfAccident,
        "time_of_accident": timeOfAccident,
        "location_of_accident": locationOfAccident,
        "weather_road_condition": weatherRoadCondition,
        "reporting_type": reportingType,
        "number_of_passengers": numberOfPassengers,
        "is_video_captured": isVideoCaptured,
        "purpose_of_use": purposeOfUse,
        "is_owner_drives": isOwnerDrives,
        "owner_driver_relationship": ownerDriverRelationship,
        'driver_name': driverName,
        'driver_nric': driverNric,
        'driver_dob': driverDob,
        'driver_license': driverLicense,
        'driver_address': driverAddress,
        'driver_contact_no': driverContactNo,
        'driver_email': driverEmail,
        'driver_occupation': driverOccupation,
        'is_other_vehicle': otherVehicle,
        'other_vehicle_car_plate': otherVehicleCarPlate,
        'other_vehicle_make': otherVehicleMake,
        'other_vehicle_model': otherVehicleModel,
        'other_driver_name': otherDriverName,
        'other_driver_nric': otherDriverNric,
        'other_driver_contact_no': otherDriverContactNo,
        'other_driver_address': otherDriverAddress,
        "is_visiting_workshop": isVisitingWorkshop,
        "workshop_id": workshopId,
        "workshop_visit_date": workshopVisitDate,
        "workshop_visit_time": workshopVisitTime,
        "details": details
      };
}
