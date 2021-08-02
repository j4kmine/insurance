/*import 'dart:async';

import 'package:boilerplate/data/network/apis/accidents/accident_api.dart';
import 'package:boilerplate/data/network/apis/customers/customer_api.dart';
import 'package:boilerplate/data/network/apis/motors/motor_api.dart';
import 'package:boilerplate/data/network/apis/services/service_api.dart';
import 'package:boilerplate/data/network/apis/vehicles/vehicle_api.dart';
import 'package:boilerplate/data/network/apis/warranties/warranty_api.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:inject/inject.dart';
import 'package:path/path.dart';

import 'network_module.dart';

@module
class LocalModule extends NetworkModule {
  // DI variables:--------------------------------------------------------------

  // constructor
  // Note: Do not change the order in which providers are called, it might cause
  // some issues
  LocalModule() {}

  // DataSources:---------------------------------------------------------------
  // Define all your data sources here
  /// A singleton vehicle dataSource provider.
  ///
  /// Calling it multiple times will return the same instance.

  // DataSources End:-----------------------------------------------------------

  /// A singleton repository provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Repository provideRepository(
          CustomerApi customerApi,
          VehicleApi vehicleApi,
          WarrantyApi warrantyApi,
          MotorApi motorApi,
          ServiceApi serviceApi,
          AccidentApi accidentApi,
          SharedPreferenceHelper preferenceHelper) =>
      Repository(customerApi, vehicleApi, warrantyApi, motorApi, serviceApi,
          accidentApi, preferenceHelper);
}
*/

import 'dart:async';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }
}
