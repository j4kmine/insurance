import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/motor/motor_make.dart';
import 'package:boilerplate/models/warranty/warranty_make.dart';

class DriverList {
  final List<Driver>? drivers;

  DriverList({
    this.drivers,
  });

  factory DriverList.fromJson(List<dynamic> json) {
    List<Driver> drivers = <Driver>[];
    drivers = json.map((driver) => Driver.fromJson(driver)).toList();

    return DriverList(drivers: drivers);
  }
}
