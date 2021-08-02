import 'app_component.dart' as _i1;
import '../modules/local_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import '../../data/network/dio_client.dart' as _i6;
import '../../data/network/rest_client.dart' as _i7;
import '../../data/network/apis/customers/customer_api.dart' as _i8;
import '../../data/network/apis/vehicles/vehicle_api.dart' as _i9;
import '../../data/network/apis/warranties/warranty_api.dart' as _i10;
import '../../data/network/apis/motors/motor_api.dart' as _i11;
import '../../data/network/apis/services/service_api.dart' as _i12;
import '../../data/network/apis/accidents/accident_api.dart' as _i13;
import '../../data/local/datasources/vehicle/vehicle_datasource.dart' as _i14;
import '../../data/repository.dart' as _i15;
import 'dart:async' as _i16;
import '../modules/network_module.dart' as _i17;
import '../../main.dart' as _i18;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._localModule, this._preferenceModule);

  final _i2.LocalModule _localModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Dio _singletonDio;

  _i6.DioClient _singletonDioClient;

  _i7.RestClient _singletonRestClient;

  _i8.CustomerApi _singletonCustomerApi;

  _i9.VehicleApi _singletonVehicleApi;

  _i10.WarrantyApi _singletonWarrantyApi;

  _i11.MotorApi _singletonMotorApi;

  _i12.ServiceApi _singletonServiceApi;

  _i13.AccidentApi _singletonAccidentApi;

  _i14.VehicleDataSource _singletonVehicleDataSource;

  _i15.Repository _singletonRepository;

  static _i16.Future<_i1.AppComponent> create(
      _i17.NetworkModule _,
      _i2.LocalModule localModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(localModule, preferenceModule);

    return injector;
  }

  _i18.MyApp _createMyApp() => _i18.MyApp();
  _i15.Repository _createRepository() =>
      _singletonRepository ??= _localModule.provideRepository(
          _createCustomerApi(),
          _createVehicleApi(),
          _createWarrantyApi(),
          _createMotorApi(),
          _createServiceApi(),
          _createAccidentApi(),
          _createSharedPreferenceHelper(),
          _createVehicleDataSource());
  _i8.CustomerApi _createCustomerApi() => _singletonCustomerApi ??=
      _localModule.provideCustomerApi(_createDioClient(), _createRestClient());
  _i6.DioClient _createDioClient() =>
      _singletonDioClient ??= _localModule.provideDioClient(_createDio());
  _i5.Dio _createDio() => _singletonDio ??=
      _localModule.provideDio(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  _i7.RestClient _createRestClient() =>
      _singletonRestClient ??= _localModule.provideRestClient();
  _i9.VehicleApi _createVehicleApi() => _singletonVehicleApi ??=
      _localModule.providePostApi(_createDioClient(), _createRestClient());
  _i10.WarrantyApi _createWarrantyApi() => _singletonWarrantyApi ??=
      _localModule.provideWarrantyApi(_createDioClient(), _createRestClient());
  _i11.MotorApi _createMotorApi() => _singletonMotorApi ??=
      _localModule.provideMotorApi(_createDioClient(), _createRestClient());
  _i12.ServiceApi _createServiceApi() => _singletonServiceApi ??=
      _localModule.provideServiceApi(_createDioClient(), _createRestClient());
  _i13.AccidentApi _createAccidentApi() => _singletonAccidentApi ??=
      _localModule.provideAccidentApi(_createDioClient(), _createRestClient());
  _i14.VehicleDataSource _createVehicleDataSource() =>
      _singletonVehicleDataSource ??= _localModule.provideVehicleDataSource();
  @override
  _i18.MyApp get app => _createMyApp();
  @override
  _i15.Repository getRepository() => _createRepository();
}
