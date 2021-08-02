import 'package:boilerplate/models/vehicle/vehicle.dart';

class VehicleList {
  final List<Vehicle>? vehicles;

  VehicleList({
    this.vehicles,
  });

  factory VehicleList.fromJson(List<dynamic> json) {
    List<Vehicle> vehicles = <Vehicle>[];
    vehicles = json.map((make) => Vehicle.fromJson(make)).toList();

    return VehicleList(
      vehicles: vehicles,
    );
  }
}
