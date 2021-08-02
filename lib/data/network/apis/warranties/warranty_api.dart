import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/models/warranty/warranty_make_list.dart';
import 'package:boilerplate/models/warranty/warranty_model_list.dart';
import 'package:boilerplate/models/warranty/package_list.dart';
import 'package:boilerplate/models/warranty/price.dart';
import 'package:boilerplate/models/warranty/price_list.dart';
import 'package:boilerplate/models/warranty/warranty.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:boilerplate/models/warranty/warranty_enquiry.dart';
import 'package:boilerplate/models/warranty/warranty_list.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

class WarrantyApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  WarrantyApi(this._dioClient, this._restClient);

  Future<WarrantyList> getWarranties() async {
    try {
      final res = await _dioClient.get(Endpoints.warranties);
      return WarrantyList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyList> getPendingWarranties() async {
    try {
      final res = await _dioClient
          .get(Endpoints.warranties + "?limit=3&status=pending");
      return WarrantyList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Warranty> getWarranty(int id) async {
    try {
      final res =
          await _dioClient.get(Endpoints.warranties + "/" + id.toString());
      return Warranty.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyMakeList> getMakes() async {
    try {
      final res = await _dioClient.get(Endpoints.warrantyMakes);
      return WarrantyMakeList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyModelList> getModels(String make) async {
    try {
      final res =
          await _dioClient.post(Endpoints.warrantyModels, data: {"make": make});
      return WarrantyModelList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<PayNow> getPayNow(int id) async {
    try {
      final res = await _dioClient
          .post(Endpoints.warrantyPayNowRef, data: {"warranty_id": id});
      return PayNow.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyPriceList> getPrices(
      String make, String model, String type, String fuel) async {
    try {
      final res = await _dioClient.post(Endpoints.warrantyPrices, data: {
        "car_make": make,
        "car_model": model,
        "type": type,
        "fuel": fuel
      });
      return WarrantyPriceList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyPackageList> getPackages() async {
    try {
      final res = await _dioClient.get(Endpoints.warrantyPackages);
      return WarrantyPackageList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<WarrantyPrice> getPrice(int id) async {
    try {
      final res =
          await _dioClient.get(Endpoints.warrantyPrices + "/" + id.toString());
      return WarrantyPrice.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> checkout(int id, String paymentId) async {
    try {
      final res = await _dioClient.post(Endpoints.warrantyCheckout,
          data: {"warranty_id": id, "payment_id": paymentId});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Message> transfer(int id) async {
    try {
      final res = await _dioClient
          .post(Endpoints.warrantyPayNow, data: {"warranty_id": id});
      return Message.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Warranty> enquiry(
      WarrantyEnquiry data, List<String> logs, List<String> assessments) async {
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
      final res =
          await _dioClient.post(Endpoints.warrantyEnquiry, data: formData);
      return Warranty.fromJson(res);
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
