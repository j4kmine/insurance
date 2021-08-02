import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/accident/accident.dart';
import 'package:boilerplate/models/accident/accident_list.dart';
import 'package:boilerplate/models/accident/accident_submit.dart';
import 'package:boilerplate/models/accident/vehicle_info.dart';
import 'package:boilerplate/models/accident/vehicle_info_list.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/message/access_token.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:dio/dio.dart';

class AccidentApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AccidentApi(this._dioClient, this._restClient);

  Future<VehicleInfoList> getVehicleInfo() async {
    try {
      final res = await _dioClient.get(Endpoints.accidentVehicleInfo);
      return VehicleInfoList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> submit(
      AccidentSubmit data,
      List<String> accidentSceneFiles,
      List<String> vehicleCarPlateFiles,
      List<String> closeRangeDamageFiles,
      List<String> longRangeDamageFiles,
      List<String> otherDrivingLicenseFiles,
      List<String> otherVehicleCarPlateFiles,
      List<String> otherCloseRangeDamageFiles,
      List<String> otherLongRangeDamageFiles) async {
    try {
      Map<String, dynamic> map = data.toJson();
      print(map);
      map['accident_scene'] = [
        for (var i = 0; i < accidentSceneFiles.length; i++)
          await MultipartFile.fromFile(accidentSceneFiles[i])
      ];
      map['vehicle_car_plate'] = [
        for (var i = 0; i < vehicleCarPlateFiles.length; i++)
          await MultipartFile.fromFile(vehicleCarPlateFiles[i])
      ];
      map['close_range_damage'] = [
        for (var i = 0; i < closeRangeDamageFiles.length; i++)
          await MultipartFile.fromFile(closeRangeDamageFiles[i])
      ];
      map['long_range_damage'] = [
        for (var i = 0; i < longRangeDamageFiles.length; i++)
          await MultipartFile.fromFile(longRangeDamageFiles[i])
      ];
      map['other_driving_license'] = [
        for (var i = 0; i < otherDrivingLicenseFiles.length; i++)
          await MultipartFile.fromFile(otherDrivingLicenseFiles[i])
      ];
      map['other_car_plate'] = [
        for (var i = 0; i < otherVehicleCarPlateFiles.length; i++)
          await MultipartFile.fromFile(otherVehicleCarPlateFiles[i])
      ];
      map['other_close_range'] = [
        for (var i = 0; i < otherCloseRangeDamageFiles.length; i++)
          await MultipartFile.fromFile(otherCloseRangeDamageFiles[i])
      ];
      map['other_long_range'] = [
        for (var i = 0; i < otherLongRangeDamageFiles.length; i++)
          await MultipartFile.fromFile(otherLongRangeDamageFiles[i])
      ];
      FormData formData = FormData.fromMap(map, ListFormat.multiCompatible);
      final res = await _dioClient.post(Endpoints.accident, data: formData);
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Accident> getAccident(int id) async {
    try {
      final res =
          await _dioClient.get(Endpoints.accident + "/" + id.toString());
      return Accident.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<AccidentList> getVehicleAccidents(String registration) async {
    try {
      final res = await _dioClient
          .get(Endpoints.accident + "?registration=" + registration);
      return AccidentList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
