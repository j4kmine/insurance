import 'dart:async';
import 'dart:core';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/models/motor/motor_enquiry.dart';
import 'package:boilerplate/models/motor/motor_list.dart';
import 'package:boilerplate/models/motor/motor_make_list.dart';
import 'package:boilerplate/models/motor/motor_model_list.dart';
import 'package:boilerplate/models/motor/motor_search_car.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/models/warranty/warranty.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class MotorApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  MotorApi(this._dioClient, this._restClient);

  Future<MotorList> getMotors() async {
    try {
      final res = await _dioClient.get(Endpoints.motors);
      return MotorList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MotorList> getPendingMotors() async {
    try {
      final res =
          await _dioClient.get(Endpoints.motors + "?limit=3&status=pending");
      return MotorList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Motor> getMotor(int id) async {
    try {
      final res = await _dioClient.get(Endpoints.motors + "/" + id.toString());
      return Motor.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MotorMakeList> getMakes() async {
    try {
      final res = await _dioClient.get(Endpoints.motorMakes);
      return MotorMakeList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MotorModelList> getModels(String make) async {
    try {
      final res =
          await _dioClient.post(Endpoints.motorModels, data: {"make": make});
      return MotorModelList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MotorSearchCar> searchCar(String make, String model) async {
    try {
      final res = await _dioClient
          .post(Endpoints.motorSearchCar, data: {"make": make, "model": model});
      return MotorSearchCar.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> checkout(int id, String paymentId) async {
    try {
      final res = await _dioClient.post(Endpoints.motorCheckout,
          data: {"motor_id": id, "payment_id": paymentId});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> transfer(int id) async {
    try {
      final res =
          await _dioClient.post(Endpoints.motorPayNow, data: {"motor_id": id});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<PayNow> getPayNow(int id) async {
    try {
      final res = await _dioClient
          .post(Endpoints.motorPayNowRef, data: {"motor_id": id});
      return PayNow.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Motor> enquiry(MotorEnquiry data, List<String> logs) async {
    try {
      Map<String, dynamic> map = data.toJson();
      if (logs != null) {
        map['log_cards'] = [
          for (var i = 0; i < logs.length; i++)
            await MultipartFile.fromFile(logs[i])
        ];
      }
      FormData formData = FormData.fromMap(map, ListFormat.multiCompatible);
      final res = await _dioClient.post(Endpoints.motorEnquiry, data: formData);
      return Motor.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Warranty> buy(
      WarrantyBuy data, List<String> logs, List<String> assessments) async {
    try {
      Map<String, dynamic> map = data.toJson();
      if (logs != null) {
        map['log_cards'] = [
          for (var i = 0; i < logs.length; i++)
            await MultipartFile.fromFile(logs[i])
        ];
      }
      if (assessments != null) {
        map['assessment_reports'] = [
          for (var i = 0; i < assessments.length; i++)
            await MultipartFile.fromFile(assessments[i])
        ];
      }
      FormData formData = FormData.fromMap(map, ListFormat.multiCompatible);
      final res = await _dioClient.post(Endpoints.warrantyBuy, data: formData);
      return Warranty.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
