import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/vehicle/access.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/vehicle/vehicle_summary.dart';
import 'package:boilerplate/models/vehicle/vehicle_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'vehicle_store.g.dart';

class VehicleStore = _VehicleStore with _$VehicleStore;

abstract class _VehicleStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _VehicleStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Vehicle?> emptyVehicleResponse =
      ObservableFuture.value(null);
  static ObservableFuture<VehicleList?> emptyVehiclesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<VehicleSummary?> emptyVehicleSummaryResponse =
      ObservableFuture.value(null);
  static ObservableFuture<Access?> emptyAccessResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Vehicle?> fetchVehicleFuture =
      ObservableFuture<Vehicle?>(emptyVehicleResponse);

  @observable
  ObservableFuture<VehicleList?> fetchVehiclesFuture =
      ObservableFuture<VehicleList?>(emptyVehiclesResponse);

  @observable
  ObservableFuture<VehicleSummary?> fetchVehicleSummaryFuture =
      ObservableFuture<VehicleSummary?>(emptyVehicleSummaryResponse);

  @observable
  ObservableFuture<Access?> fetchAccessFuture =
      ObservableFuture<Access?>(emptyAccessResponse);

  @observable
  Vehicle? vehicle;

  @observable
  int? vehicleId;

  @observable
  Access? access;

  @observable
  VehicleList? vehicles;

  @observable
  VehicleSummary? vehicleSummary;

  @observable
  List<String>? vehicleOptions;

  @observable
  List<String>? vehicleMotorOptions;

  @observable
  bool success = false;

  @observable
  bool deleteSuccess = false;

  @observable
  bool deleteLoading = false;

  @observable
  bool createSuccess = false;

  @observable
  bool createLoading = false;

  @computed
  bool get vehicleLoading => fetchVehicleFuture.status == FutureStatus.pending;

  @computed
  bool get vehicleSummaryLoading =>
      fetchVehicleSummaryFuture.status == FutureStatus.pending;

  @computed
  bool get vehiclesLoading =>
      fetchVehiclesFuture.status == FutureStatus.pending;

  @computed
  bool get accessLoading => fetchAccessFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getVehicle(int id) async {
    this.vehicle = null;
    this.vehicleId = id;
    final future = _repository.getVehicle(id);
    fetchVehicleFuture = ObservableFuture(future);
    future.then((vehicle) {
      this.vehicle = vehicle;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getAccess(int id) async {
    this.access = null;
    this.vehicleId = id;
    final future = _repository.getAccess(id);
    fetchAccessFuture = ObservableFuture(future);
    future.then((access) {
      this.access = access;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future createAccess(String nric, int id) async {
    createLoading = true;
    final future = _repository.createAccess(nric, id);
    future.then((motor) {
      createSuccess = true;
      successStore.successMessage = motor.message!;
      getAccess(id);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => createLoading = false);
  }

  @action
  Future deleteAccess(String nric, int id) async {
    deleteLoading = true;
    final future = _repository.deleteAccess(nric, id);
    future.then((motor) {
      deleteSuccess = true;
      successStore.successMessage = motor.message!;
      getAccess(id);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => deleteLoading = false);
  }

  @action
  Future getVehicleSummary() async {
    this.vehicleSummary = null;
    final future = _repository.getVehicleSummary();
    fetchVehicleSummaryFuture = ObservableFuture(future);
    future.then((vehicleSummary) {
      this.vehicleSummary = vehicleSummary;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getVehicles() async {
    this.vehicles = null;
    final future = _repository.getVehicles();
    fetchVehiclesFuture = ObservableFuture(future);
    vehicleOptions = ['', Strings.quote];
    vehicleMotorOptions = [''];

    future.then((vehicleList) {
      this.vehicles = vehicleList;
      for (int i = 0; i < this.vehicles!.vehicles!.length; i++) {
        if (this.vehicles!.vehicles![i].registrationNo != null) {
          vehicleMotorOptions!.add(this.vehicles!.vehicles![i].registrationNo!);
          vehicleOptions!.add(this.vehicles!.vehicles![i].registrationNo!);
        }
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
