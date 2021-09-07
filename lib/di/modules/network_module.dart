/*import 'dart:io';

import 'package:boilerplate/data/network/apis/accidents/accident_api.dart';
import 'package:boilerplate/data/network/apis/customers/customer_api.dart';
import 'package:boilerplate/data/network/apis/motors/motor_api.dart';
import 'package:boilerplate/data/network/apis/services/service_api.dart';
import 'package:boilerplate/data/network/apis/vehicles/vehicle_api.dart';
import 'package:boilerplate/data/network/apis/warranties/warranty_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (request, handler) async {
          var prefs = await SharedPreferences.getInstance();
          // getting token
          var token = prefs.getString(Preferences.auth_token);
          if (token != null && token != '')
            request.headers['Authorization'] = 'Bearer $token';

          return handler.next(request);
        }),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  RestClient provideRestClient() => RestClient();

  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton post_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  VehicleApi providePostApi(DioClient dioClient, RestClient restClient) =>
      VehicleApi(dioClient, restClient);

  @provide
  @singleton
  CustomerApi provideCustomerApi(DioClient dioClient, RestClient restClient) =>
      CustomerApi(dioClient, restClient);

  @provide
  @singleton
  WarrantyApi provideWarrantyApi(DioClient dioClient, RestClient restClient) =>
      WarrantyApi(dioClient, restClient);

  @provide
  @singleton
  MotorApi provideMotorApi(DioClient dioClient, RestClient restClient) =>
      MotorApi(dioClient, restClient);

  @provide
  @singleton
  ServiceApi provideServiceApi(DioClient dioClient, RestClient restClient) =>
      ServiceApi(dioClient, restClient);

  @provide
  @singleton
  AccidentApi provideAccidentApi(DioClient dioClient, RestClient restClient) =>
      AccidentApi(dioClient, restClient);
// Api Providers End:---------------------------------------------------------

}
*/

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            // getting token
            var token = await sharedPrefHelper.authToken;
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}
