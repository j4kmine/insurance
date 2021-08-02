// To parse this JSON data, do
//
//     final motorMotorModel = motorMotorModelFromJson(jsonString);

import 'dart:convert';

List<MotorModel> motorModelFromJson(String str) =>
    List<MotorModel>.from(json.decode(str).map((x) => MotorModel.fromJson(x)));

String motorModelToJson(List<MotorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MotorModel {
  MotorModel({this.model});

  String? model;

  factory MotorModel.fromJson(Map<String, dynamic> json) =>
      MotorModel(model: json["model"]);

  Map<String, dynamic> toJson() => {"model": model};
}
