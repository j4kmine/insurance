// To parse this JSON data, do
//
//     final vehicleSummary = vehicleSummaryFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/vehicle/vehicle.dart';

VehicleSummary vehicleSummaryFromJson(String str) =>
    VehicleSummary.fromJson(json.decode(str));

String vehicleSummaryToJson(VehicleSummary data) => json.encode(data.toJson());

class VehicleSummary {
  VehicleSummary({
    this.owned,
    this.grantedAccess,
  });

  List<Vehicle>? owned;
  List<Vehicle>? grantedAccess;

  factory VehicleSummary.fromJson(Map<String, dynamic> json) => VehicleSummary(
        owned:
            List<Vehicle>.from(json["owned"].map((x) => Vehicle.fromJson(x))),
        grantedAccess: List<Vehicle>.from(
            json["granted_access"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "owned": List<dynamic>.from(owned!.map((x) => x.toJson())),
        "granted_access":
            List<dynamic>.from(grantedAccess!.map((x) => x.toJson())),
      };
}
