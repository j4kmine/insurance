import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/accident/accident.dart';
import 'package:boilerplate/models/accident/accident_list.dart';
import 'package:boilerplate/models/accident/accident_submit.dart';
import 'package:boilerplate/models/accident/vehicle_info.dart';
import 'package:boilerplate/models/accident/vehicle_info_list.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'accident_store.g.dart';

class AccidentStore = _AccidentStore with _$AccidentStore;

abstract class _AccidentStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _AccidentStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------

  static ObservableFuture<VehicleInfoList?> emptyVehicleInfoResponse =
      ObservableFuture.value(null);

  static ObservableFuture<AccidentList?> emptyVehicleAccidentsResponse =
      ObservableFuture.value(null);

  static ObservableFuture<Accident?> emptyAccidentResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<VehicleInfoList?> fetchVehicleInfoFuture =
      ObservableFuture<VehicleInfoList?>(emptyVehicleInfoResponse);

  @computed
  bool get vehicleInfoListLoading =>
      fetchVehicleInfoFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<AccidentList?> fetchVehicleAccidentsFuture =
      ObservableFuture<AccidentList?>(emptyVehicleAccidentsResponse);

  @observable
  ObservableFuture<Accident?> fetchAccidentFuture =
      ObservableFuture<Accident?>(emptyAccidentResponse);

  @observable
  VehicleInfoList? vehicleInfoList;

  @observable
  AccidentList? vehicleAccidentList;

  @observable
  Accident? accident;

  @observable
  List<String> accidentSceneFiles = <String>[];

  @observable
  List<String> vehicleCarPlateFiles = <String>[];

  @observable
  List<String> closeRangeDamageFiles = <String>[];

  @observable
  List<String> longRangeDamageFiles = <String>[];

  @observable
  List<String> otherDrivingLicenseFiles = <String>[];

  @observable
  List<String> otherVehicleCarPlateFiles = <String>[];

  @observable
  List<String> otherCloseRangeDamageFiles = <String>[];

  @observable
  List<String> otherLongRangeDamageFiles = <String>[];

  @computed
  bool get accidentLoading =>
      fetchAccidentFuture.status == FutureStatus.pending;

  @computed
  bool get vehicleAccidentsLoading =>
      fetchVehicleAccidentsFuture.status == FutureStatus.pending;

  @observable
  int fileIndex = 0;

  @observable
  String photoTitle = "";

  @observable
  bool submitSuccess = false;

  @observable
  bool submitLoading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future submit(AccidentSubmit accidentSubmit) async {
    submitLoading = true;
    final future = _repository.submitAccident(
        accidentSubmit,
        accidentSceneFiles,
        vehicleCarPlateFiles,
        closeRangeDamageFiles,
        longRangeDamageFiles,
        otherDrivingLicenseFiles,
        otherVehicleCarPlateFiles,
        otherCloseRangeDamageFiles,
        otherLongRangeDamageFiles);
    future.then((accident) {
      submitSuccess = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => submitLoading = false);
  }

  @action
  Future getVehicleAccidents(String registration) async {
    this.vehicleAccidentList = null;
    final future = _repository.getVehicleAccidents(registration);
    fetchVehicleAccidentsFuture = ObservableFuture(future);
    future.then((accidents) {
      this.vehicleAccidentList = accidents;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getVehicles() async {
    this.vehicleInfoList = null;
    final future = _repository.getAccidentVehicleInfo();
    fetchVehicleInfoFuture = ObservableFuture(future);
    future.then((vehicle) {
      this.vehicleInfoList = vehicle;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getAccident(int id) async {
    this.accident = null;
    final future = _repository.getAccident(id);
    fetchAccidentFuture = ObservableFuture(future);
    future.then((accident) {
      this.accident = accident;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
