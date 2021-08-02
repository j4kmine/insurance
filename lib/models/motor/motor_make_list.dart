import 'package:boilerplate/models/motor/motor_make.dart';
import 'package:boilerplate/models/warranty/warranty_make.dart';

class MotorMakeList {
  final List<MotorMake>? makes;

  MotorMakeList({
    this.makes,
  });

  factory MotorMakeList.fromJson(List<dynamic> json) {
    List<MotorMake> makes = <MotorMake>[];
    makes = json.map((make) => MotorMake.fromJson(make)).toList();

    return MotorMakeList(
      makes: makes,
    );
  }
}
