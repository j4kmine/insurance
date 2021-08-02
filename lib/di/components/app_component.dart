/*
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/network_module.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:boilerplate/main.dart';
import 'package:inject/inject.dart';

import 'app_component.inject.dart' as g;

/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [NetworkModule, LocalModule, PreferenceModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
    NetworkModule networkModule,
    LocalModule localModule,
    PreferenceModule preferenceModule,
  ) async {
    return await g.AppComponent$Injector.create(
      networkModule,
      localModule,
      preferenceModule,
    );
  }

  /// An accessor to RestClient object that an application may use.
  @provide
  Repository getRepository();
}
*/
import 'package:boilerplate/data/network/apis/accidents/accident_api.dart';
import 'package:boilerplate/data/network/apis/customers/customer_api.dart';
import 'package:boilerplate/data/network/apis/motors/motor_api.dart';
import 'package:boilerplate/data/network/apis/services/service_api.dart';
import 'package:boilerplate/data/network/apis/vehicles/vehicle_api.dart';
import 'package:boilerplate/data/network/apis/warranties/warranty_api.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/modules/local_module.dart';
import 'package:boilerplate/di/modules/network_module.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/document/document_store.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/login/login_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  // getIt.registerFactory(() => ErrorStore());
  // getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(CustomerApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(VehicleApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(WarrantyApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(MotorApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(ServiceApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(AccidentApi(getIt<DioClient>(), getIt<RestClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
      getIt<CustomerApi>(),
      getIt<VehicleApi>(),
      getIt<WarrantyApi>(),
      getIt<MotorApi>(),
      getIt<ServiceApi>(),
      getIt<AccidentApi>(),
      getIt<SharedPreferenceHelper>()));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(WarrantyStore(getIt<Repository>()));
  getIt.registerSingleton(MotorStore(getIt<Repository>()));
  getIt.registerSingleton(ServicingStore(getIt<Repository>()));
  getIt.registerSingleton(AccidentStore(getIt<Repository>()));
  getIt.registerSingleton(DocumentStore(getIt<Repository>()));
  getIt.registerSingleton(RegisterStore(getIt<Repository>()));
  getIt.registerSingleton(VehicleStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
  getIt.registerSingleton(LoginStore(getIt<Repository>()));
}
