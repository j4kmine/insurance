import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/models/servicing/service_list.dart';
import 'package:boilerplate/models/servicing/service_request.dart';
import 'package:boilerplate/models/servicing/service_slot.dart';
import 'package:boilerplate/models/servicing/service_slot_list.dart';
import 'package:boilerplate/models/servicing/service_type_list.dart';
import 'package:boilerplate/models/workshop/workshop_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'servicing_store.g.dart';

class ServicingStore = _ServicingStore with _$ServicingStore;

abstract class _ServicingStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _ServicingStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<WorkshopList?> emptyWorkshopsResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ServiceTypeList?> emptyServiceTypesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ServiceList?> emptyPendingServicesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ServiceList?> emptyVehicleServicesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ServiceList?> emptyServicesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<Service?> emptyServiceResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ServiceSlotList?> emptySlotsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<WorkshopList?> fetchWorkshopsFuture =
      ObservableFuture<WorkshopList?>(emptyWorkshopsResponse);

  @observable
  ObservableFuture<ServiceTypeList?> fetchServiceTypesFuture =
      ObservableFuture<ServiceTypeList?>(emptyServiceTypesResponse);

  @observable
  ObservableFuture<ServiceList?> fetchPendingServicesFuture =
      ObservableFuture<ServiceList?>(emptyPendingServicesResponse);

  @observable
  ObservableFuture<ServiceList?> fetchVehicleServicesFuture =
      ObservableFuture<ServiceList?>(emptyVehicleServicesResponse);

  @observable
  ObservableFuture<ServiceList?> fetchServicesFuture =
      ObservableFuture<ServiceList?>(emptyServicesResponse);

  @observable
  ObservableFuture<Service?> fetchServiceFuture =
      ObservableFuture<Service?>(emptyServiceResponse);

  @observable
  ObservableFuture<ServiceSlotList?> fetchServiceSlotsFuture =
      ObservableFuture<ServiceSlotList?>(emptySlotsResponse);

  @observable
  WorkshopList? workshopList;

  @observable
  ServiceTypeList? serviceTypeList;

  @observable
  ServiceList? pendingServiceList;

  @observable
  ServiceList? vehicleServiceList;

  @observable
  ServiceList? serviceList;

  @observable
  ServiceSlotList? serviceSlotList;

  @observable
  Service? service;

  @observable
  Map<int, String> serviceOptions = {};

  @observable
  Map<int, String> workshopOptions = {};

  @observable
  bool bookSuccess = false;

  @observable
  bool bookLoading = false;

  @observable
  bool updateLoading = false;

  @observable
  bool scheduleSuccess = false;

  @computed
  bool get workshopsLoading =>
      fetchWorkshopsFuture.status == FutureStatus.pending;

  @computed
  bool get serviceTypesLoading =>
      fetchServiceTypesFuture.status == FutureStatus.pending;

  @computed
  bool get pendingServicesLoading =>
      fetchPendingServicesFuture.status == FutureStatus.pending;

  @computed
  bool get servicesLoading =>
      fetchServicesFuture.status == FutureStatus.pending;

  @computed
  bool get serviceLoading => fetchServiceFuture.status == FutureStatus.pending;

  @computed
  bool get vehicleServicesLoading =>
      fetchVehicleServicesFuture.status == FutureStatus.pending;

  @computed
  bool get serviceSlotsLoading =>
      fetchServiceSlotsFuture.status == FutureStatus.pending;

  @action
  Future submitService(ServiceRequest request) async {
    bookLoading = true;
    final future = _repository.submitService(request);
    future.then((service) {
      this.service = service;
      bookSuccess = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => bookLoading = false);
  }

  @action
  Future rescheduleService(ServiceRequest request, int id) async {
    updateLoading = true;
    final future = _repository.rescheduleService(request, id);
    future.then((service) {
      this.service = service;
      getPendingServices();
      scheduleSuccess = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => updateLoading = false);
  }

  @action
  Future cancelService(int id) async {
    updateLoading = true;
    final future = _repository.cancelService(id);
    future.then((service) {
      this.service = service;
      getPendingServices();
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => updateLoading = false);
  }

  @action
  Future getWorkshops() async {
    this.workshopList = null;
    final future = _repository.getWorkshops();
    fetchWorkshopsFuture = ObservableFuture(future);
    workshopOptions[0] = "";
    future.then((workshops) {
      this.workshopList = workshops;
      for (var i = 0; i < workshopList!.workshops!.length; i++) {
        workshopOptions[workshopList!.workshops![i].id!] =
            workshopList!.workshops![i].name!;
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getServiceTypes(int id) async {
    this.serviceTypeList = null;
    final future = _repository.getServiceTypes(id);
    fetchServiceTypesFuture = ObservableFuture(future);
    future.then((services) {
      this.serviceTypeList = services;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getService(int id) async {
    this.service = null;
    final future = _repository.getService(id);
    fetchServiceFuture = ObservableFuture(future);
    future.then((service) {
      this.service = service;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getServices() async {
    this.serviceList = null;
    final future = _repository.getServices();
    fetchServicesFuture = ObservableFuture(future);
    future.then((services) {
      this.serviceList = services;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getVehicleServices(String registration) async {
    this.vehicleServiceList = null;
    final future = _repository.getVehicleServices(registration);
    fetchVehicleServicesFuture = ObservableFuture(future);
    future.then((services) {
      this.vehicleServiceList = services;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPendingServices() async {
    this.pendingServiceList = null;
    final future = _repository.getPendingServices();
    fetchServicesFuture = ObservableFuture(future);
    future.then((servicing) {
      this.pendingServiceList = servicing;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getServiceSlots(int id) async {
    this.serviceSlotList = null;
    final future = _repository.getServiceSlots(id);
    fetchServiceSlotsFuture = ObservableFuture(future);
    future.then((services) {
      this.serviceSlotList = services;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
