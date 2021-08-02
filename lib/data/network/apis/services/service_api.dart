import 'dart:async';
import 'dart:core';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/models/servicing/service_list.dart';
import 'package:boilerplate/models/servicing/service_request.dart';
import 'package:boilerplate/models/servicing/service_slot_list.dart';
import 'package:boilerplate/models/servicing/service_type_list.dart';
import 'package:boilerplate/models/workshop/workshop_list.dart';

class ServiceApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ServiceApi(this._dioClient, this._restClient);

  Future<WorkshopList> getWorkshops() async {
    try {
      final res = await _dioClient.get(Endpoints.workshops);
      return WorkshopList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ServiceTypeList> getServiceTypes(int id) async {
    try {
      final res = await _dioClient.get(
          Endpoints.serviceTypes.replaceAll("{company_id}", id.toString()));
      return ServiceTypeList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ServiceList> getServices() async {
    try {
      final res = await _dioClient.get(Endpoints.services);
      return ServiceList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ServiceList> getPendingServices() async {
    try {
      final res =
          await _dioClient.get(Endpoints.services + "?limit=3&status=upcoming");
      return ServiceList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Service> getService(int id) async {
    try {
      final res =
          await _dioClient.get(Endpoints.services + "/" + id.toString());
      return Service.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ServiceSlotList> getServiceSlots(id) async {
    try {
      final res = await _dioClient.get(
          Endpoints.serviceSlots.replaceAll("{company_id}", id.toString()));
      return ServiceSlotList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Service> submitService(ServiceRequest request) async {
    try {
      final res =
          await _dioClient.post(Endpoints.services, data: request.toJson());
      return Service.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Service> rescheduleService(ServiceRequest request, int id) async {
    try {
      final res = await _dioClient.post(
          Endpoints.services + "/" + id.toString() + "/update",
          data: request.toJson());
      return Service.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Service> cancelService(int id) async {
    try {
      final res = await _dioClient.get("${Endpoints.services}/${id}/cancel");
      return Service.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ServiceList> getVehicleServices(String registration) async {
    try {
      final res = await _dioClient
          .get(Endpoints.services + "?registration=" + registration);
      return ServiceList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
