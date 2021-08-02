import 'dart:async';
import 'dart:core';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/document/document_list.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:boilerplate/models/vehicle/access.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/vehicle/vehicle_summary.dart';
import 'package:boilerplate/models/vehicle/vehicle_list.dart';

class VehicleApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  VehicleApi(this._dioClient, this._restClient);

  Future<VehicleSummary> getVehicleSummary() async {
    try {
      final res = await _dioClient.get(Endpoints.vehicleSummary);
      return VehicleSummary.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<VehicleList> getVehicles() async {
    try {
      final res = await _dioClient.get(Endpoints.vehicles);
      return VehicleList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Vehicle> getVehicle(int id) async {
    try {
      final res =
          await _dioClient.get(Endpoints.vehicles + "/" + id.toString());
      return Vehicle.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Access> getAccess(int id) async {
    try {
      final res = await _dioClient
          .get(Endpoints.vehicles + "/" + id.toString() + "/access");
      return Access.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> deleteAccess(String nric, int id) async {
    try {
      final res = await _dioClient.delete(
          Endpoints.vehicles + "/" + id.toString() + "/access",
          data: {"nric": nric});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> createAccess(String nric, int id) async {
    try {
      final res = await _dioClient.post(
          Endpoints.vehicles + "/" + id.toString() + "/access",
          data: {"nric": nric});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<DocumentList> getVehicleInsurances(int id) async {
    try {
      final res = await _dioClient
          .get(Endpoints.vehicles + "/" + id.toString() + "/motors");
      return DocumentList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<DocumentList> getVehicleWarranties(int id) async {
    try {
      final res = await _dioClient
          .get(Endpoints.vehicles + "/" + id.toString() + "/warranties");
      return DocumentList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
