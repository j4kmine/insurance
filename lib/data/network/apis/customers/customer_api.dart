import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/customer/activity_list.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/message/access_token.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';

class CustomerApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CustomerApi(this._dioClient, this._restClient);

  Future<AccessToken> login(String idToken, String nric, String phone) async {
    try {
      final res = await _dioClient.post(Endpoints.login,
          data: {"firebase_token": idToken, "nric_uen": nric, "phone": phone});
      return AccessToken.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<Message> register(String userName, String userNRIC, String userDOB,
      String userPhone, String userEmail, bool isCompany) async {
    try {
      final res = await _dioClient.post(Endpoints.register, data: {
        "name": userName,
        "email": userEmail,
        "phone": userPhone,
        "nric_uen": userNRIC,
        "date_of_birth": userDOB,
        "is_company": isCompany
      });
      return Message.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<Customer> updateProfile(
      Customer customer, List<Vehicle> vehicles) async {
    try {
      var data = customer.toProfileJson();
      List<Map<String, dynamic>> vehicleData = [];
      for (var i = 0; i < vehicles.length; i++) {
        vehicleData.add(vehicles[i].toJson());
      }
      data['vehicles'] = vehicleData;
      final res = await _dioClient.post(Endpoints.updateProfile, data: data);
      return Customer.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<Message> check(String userNRIC, String userPhone) async {
    try {
      final res = await _dioClient.post(Endpoints.check, data: {
        "phone": userPhone,
        "nric_uen": userNRIC,
      });
      return Message.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<Customer> getCustomer() async {
    try {
      final res = await _dioClient.get(Endpoints.profile);
      return Customer.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<ActivityList> getActivities() async {
    try {
      final res = await _dioClient.get(Endpoints.activities);
      return ActivityList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<ActivityList> getNotifications() async {
    try {
      final res = await _dioClient.get(Endpoints.notifications);
      return ActivityList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }
}
