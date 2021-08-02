import 'package:boilerplate/models/motor/motor_model.dart';

class MotorModelList {
  final List<MotorModel>? models;

  MotorModelList({
    this.models,
  });

  factory MotorModelList.fromJson(List<dynamic> json) {
    List<MotorModel> models = <MotorModel>[];
    models = json.map((make) => MotorModel.fromJson(make)).toList();

    return MotorModelList(
      models: models,
    );
  }
}
