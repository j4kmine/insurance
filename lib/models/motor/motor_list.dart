import 'package:boilerplate/models/motor/motor.dart';

class MotorList {
  final List<Motor>? motors;

  MotorList({
    this.motors,
  });

  factory MotorList.fromJson(List<dynamic> json) {
    List<Motor> motors = <Motor>[];
    motors = json.map((make) => Motor.fromJson(make)).toList();

    return MotorList(
      motors: motors,
    );
  }
}
