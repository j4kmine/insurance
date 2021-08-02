// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServicingStore on _ServicingStore, Store {
  Computed<bool>? _$workshopsLoadingComputed;

  @override
  bool get workshopsLoading => (_$workshopsLoadingComputed ??= Computed<bool>(
          () => super.workshopsLoading,
          name: '_ServicingStore.workshopsLoading'))
      .value;
  Computed<bool>? _$serviceTypesLoadingComputed;

  @override
  bool get serviceTypesLoading => (_$serviceTypesLoadingComputed ??=
          Computed<bool>(() => super.serviceTypesLoading,
              name: '_ServicingStore.serviceTypesLoading'))
      .value;
  Computed<bool>? _$pendingServicesLoadingComputed;

  @override
  bool get pendingServicesLoading => (_$pendingServicesLoadingComputed ??=
          Computed<bool>(() => super.pendingServicesLoading,
              name: '_ServicingStore.pendingServicesLoading'))
      .value;
  Computed<bool>? _$servicesLoadingComputed;

  @override
  bool get servicesLoading =>
      (_$servicesLoadingComputed ??= Computed<bool>(() => super.servicesLoading,
              name: '_ServicingStore.servicesLoading'))
          .value;
  Computed<bool>? _$serviceLoadingComputed;

  @override
  bool get serviceLoading =>
      (_$serviceLoadingComputed ??= Computed<bool>(() => super.serviceLoading,
              name: '_ServicingStore.serviceLoading'))
          .value;
  Computed<bool>? _$vehicleServicesLoadingComputed;

  @override
  bool get vehicleServicesLoading => (_$vehicleServicesLoadingComputed ??=
          Computed<bool>(() => super.vehicleServicesLoading,
              name: '_ServicingStore.vehicleServicesLoading'))
      .value;
  Computed<bool>? _$serviceSlotsLoadingComputed;

  @override
  bool get serviceSlotsLoading => (_$serviceSlotsLoadingComputed ??=
          Computed<bool>(() => super.serviceSlotsLoading,
              name: '_ServicingStore.serviceSlotsLoading'))
      .value;

  final _$fetchWorkshopsFutureAtom =
      Atom(name: '_ServicingStore.fetchWorkshopsFuture');

  @override
  ObservableFuture<WorkshopList?> get fetchWorkshopsFuture {
    _$fetchWorkshopsFutureAtom.reportRead();
    return super.fetchWorkshopsFuture;
  }

  @override
  set fetchWorkshopsFuture(ObservableFuture<WorkshopList?> value) {
    _$fetchWorkshopsFutureAtom.reportWrite(value, super.fetchWorkshopsFuture,
        () {
      super.fetchWorkshopsFuture = value;
    });
  }

  final _$fetchServiceTypesFutureAtom =
      Atom(name: '_ServicingStore.fetchServiceTypesFuture');

  @override
  ObservableFuture<ServiceTypeList?> get fetchServiceTypesFuture {
    _$fetchServiceTypesFutureAtom.reportRead();
    return super.fetchServiceTypesFuture;
  }

  @override
  set fetchServiceTypesFuture(ObservableFuture<ServiceTypeList?> value) {
    _$fetchServiceTypesFutureAtom
        .reportWrite(value, super.fetchServiceTypesFuture, () {
      super.fetchServiceTypesFuture = value;
    });
  }

  final _$fetchPendingServicesFutureAtom =
      Atom(name: '_ServicingStore.fetchPendingServicesFuture');

  @override
  ObservableFuture<ServiceList?> get fetchPendingServicesFuture {
    _$fetchPendingServicesFutureAtom.reportRead();
    return super.fetchPendingServicesFuture;
  }

  @override
  set fetchPendingServicesFuture(ObservableFuture<ServiceList?> value) {
    _$fetchPendingServicesFutureAtom
        .reportWrite(value, super.fetchPendingServicesFuture, () {
      super.fetchPendingServicesFuture = value;
    });
  }

  final _$fetchVehicleServicesFutureAtom =
      Atom(name: '_ServicingStore.fetchVehicleServicesFuture');

  @override
  ObservableFuture<ServiceList?> get fetchVehicleServicesFuture {
    _$fetchVehicleServicesFutureAtom.reportRead();
    return super.fetchVehicleServicesFuture;
  }

  @override
  set fetchVehicleServicesFuture(ObservableFuture<ServiceList?> value) {
    _$fetchVehicleServicesFutureAtom
        .reportWrite(value, super.fetchVehicleServicesFuture, () {
      super.fetchVehicleServicesFuture = value;
    });
  }

  final _$fetchServicesFutureAtom =
      Atom(name: '_ServicingStore.fetchServicesFuture');

  @override
  ObservableFuture<ServiceList?> get fetchServicesFuture {
    _$fetchServicesFutureAtom.reportRead();
    return super.fetchServicesFuture;
  }

  @override
  set fetchServicesFuture(ObservableFuture<ServiceList?> value) {
    _$fetchServicesFutureAtom.reportWrite(value, super.fetchServicesFuture, () {
      super.fetchServicesFuture = value;
    });
  }

  final _$fetchServiceFutureAtom =
      Atom(name: '_ServicingStore.fetchServiceFuture');

  @override
  ObservableFuture<Service?> get fetchServiceFuture {
    _$fetchServiceFutureAtom.reportRead();
    return super.fetchServiceFuture;
  }

  @override
  set fetchServiceFuture(ObservableFuture<Service?> value) {
    _$fetchServiceFutureAtom.reportWrite(value, super.fetchServiceFuture, () {
      super.fetchServiceFuture = value;
    });
  }

  final _$fetchServiceSlotsFutureAtom =
      Atom(name: '_ServicingStore.fetchServiceSlotsFuture');

  @override
  ObservableFuture<ServiceSlotList?> get fetchServiceSlotsFuture {
    _$fetchServiceSlotsFutureAtom.reportRead();
    return super.fetchServiceSlotsFuture;
  }

  @override
  set fetchServiceSlotsFuture(ObservableFuture<ServiceSlotList?> value) {
    _$fetchServiceSlotsFutureAtom
        .reportWrite(value, super.fetchServiceSlotsFuture, () {
      super.fetchServiceSlotsFuture = value;
    });
  }

  final _$workshopListAtom = Atom(name: '_ServicingStore.workshopList');

  @override
  WorkshopList? get workshopList {
    _$workshopListAtom.reportRead();
    return super.workshopList;
  }

  @override
  set workshopList(WorkshopList? value) {
    _$workshopListAtom.reportWrite(value, super.workshopList, () {
      super.workshopList = value;
    });
  }

  final _$serviceTypeListAtom = Atom(name: '_ServicingStore.serviceTypeList');

  @override
  ServiceTypeList? get serviceTypeList {
    _$serviceTypeListAtom.reportRead();
    return super.serviceTypeList;
  }

  @override
  set serviceTypeList(ServiceTypeList? value) {
    _$serviceTypeListAtom.reportWrite(value, super.serviceTypeList, () {
      super.serviceTypeList = value;
    });
  }

  final _$pendingServiceListAtom =
      Atom(name: '_ServicingStore.pendingServiceList');

  @override
  ServiceList? get pendingServiceList {
    _$pendingServiceListAtom.reportRead();
    return super.pendingServiceList;
  }

  @override
  set pendingServiceList(ServiceList? value) {
    _$pendingServiceListAtom.reportWrite(value, super.pendingServiceList, () {
      super.pendingServiceList = value;
    });
  }

  final _$vehicleServiceListAtom =
      Atom(name: '_ServicingStore.vehicleServiceList');

  @override
  ServiceList? get vehicleServiceList {
    _$vehicleServiceListAtom.reportRead();
    return super.vehicleServiceList;
  }

  @override
  set vehicleServiceList(ServiceList? value) {
    _$vehicleServiceListAtom.reportWrite(value, super.vehicleServiceList, () {
      super.vehicleServiceList = value;
    });
  }

  final _$serviceListAtom = Atom(name: '_ServicingStore.serviceList');

  @override
  ServiceList? get serviceList {
    _$serviceListAtom.reportRead();
    return super.serviceList;
  }

  @override
  set serviceList(ServiceList? value) {
    _$serviceListAtom.reportWrite(value, super.serviceList, () {
      super.serviceList = value;
    });
  }

  final _$serviceSlotListAtom = Atom(name: '_ServicingStore.serviceSlotList');

  @override
  ServiceSlotList? get serviceSlotList {
    _$serviceSlotListAtom.reportRead();
    return super.serviceSlotList;
  }

  @override
  set serviceSlotList(ServiceSlotList? value) {
    _$serviceSlotListAtom.reportWrite(value, super.serviceSlotList, () {
      super.serviceSlotList = value;
    });
  }

  final _$serviceAtom = Atom(name: '_ServicingStore.service');

  @override
  Service? get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(Service? value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  final _$serviceOptionsAtom = Atom(name: '_ServicingStore.serviceOptions');

  @override
  Map<int, String> get serviceOptions {
    _$serviceOptionsAtom.reportRead();
    return super.serviceOptions;
  }

  @override
  set serviceOptions(Map<int, String> value) {
    _$serviceOptionsAtom.reportWrite(value, super.serviceOptions, () {
      super.serviceOptions = value;
    });
  }

  final _$workshopOptionsAtom = Atom(name: '_ServicingStore.workshopOptions');

  @override
  Map<int, String> get workshopOptions {
    _$workshopOptionsAtom.reportRead();
    return super.workshopOptions;
  }

  @override
  set workshopOptions(Map<int, String> value) {
    _$workshopOptionsAtom.reportWrite(value, super.workshopOptions, () {
      super.workshopOptions = value;
    });
  }

  final _$bookSuccessAtom = Atom(name: '_ServicingStore.bookSuccess');

  @override
  bool get bookSuccess {
    _$bookSuccessAtom.reportRead();
    return super.bookSuccess;
  }

  @override
  set bookSuccess(bool value) {
    _$bookSuccessAtom.reportWrite(value, super.bookSuccess, () {
      super.bookSuccess = value;
    });
  }

  final _$bookLoadingAtom = Atom(name: '_ServicingStore.bookLoading');

  @override
  bool get bookLoading {
    _$bookLoadingAtom.reportRead();
    return super.bookLoading;
  }

  @override
  set bookLoading(bool value) {
    _$bookLoadingAtom.reportWrite(value, super.bookLoading, () {
      super.bookLoading = value;
    });
  }

  final _$updateLoadingAtom = Atom(name: '_ServicingStore.updateLoading');

  @override
  bool get updateLoading {
    _$updateLoadingAtom.reportRead();
    return super.updateLoading;
  }

  @override
  set updateLoading(bool value) {
    _$updateLoadingAtom.reportWrite(value, super.updateLoading, () {
      super.updateLoading = value;
    });
  }

  final _$scheduleSuccessAtom = Atom(name: '_ServicingStore.scheduleSuccess');

  @override
  bool get scheduleSuccess {
    _$scheduleSuccessAtom.reportRead();
    return super.scheduleSuccess;
  }

  @override
  set scheduleSuccess(bool value) {
    _$scheduleSuccessAtom.reportWrite(value, super.scheduleSuccess, () {
      super.scheduleSuccess = value;
    });
  }

  final _$submitServiceAsyncAction =
      AsyncAction('_ServicingStore.submitService');

  @override
  Future<dynamic> submitService(ServiceRequest request) {
    return _$submitServiceAsyncAction.run(() => super.submitService(request));
  }

  final _$rescheduleServiceAsyncAction =
      AsyncAction('_ServicingStore.rescheduleService');

  @override
  Future<dynamic> rescheduleService(ServiceRequest request, int id) {
    return _$rescheduleServiceAsyncAction
        .run(() => super.rescheduleService(request, id));
  }

  final _$cancelServiceAsyncAction =
      AsyncAction('_ServicingStore.cancelService');

  @override
  Future<dynamic> cancelService(int id) {
    return _$cancelServiceAsyncAction.run(() => super.cancelService(id));
  }

  final _$getWorkshopsAsyncAction = AsyncAction('_ServicingStore.getWorkshops');

  @override
  Future<dynamic> getWorkshops() {
    return _$getWorkshopsAsyncAction.run(() => super.getWorkshops());
  }

  final _$getServiceTypesAsyncAction =
      AsyncAction('_ServicingStore.getServiceTypes');

  @override
  Future<dynamic> getServiceTypes(int id) {
    return _$getServiceTypesAsyncAction.run(() => super.getServiceTypes(id));
  }

  final _$getServiceAsyncAction = AsyncAction('_ServicingStore.getService');

  @override
  Future<dynamic> getService(int id) {
    return _$getServiceAsyncAction.run(() => super.getService(id));
  }

  final _$getServicesAsyncAction = AsyncAction('_ServicingStore.getServices');

  @override
  Future<dynamic> getServices() {
    return _$getServicesAsyncAction.run(() => super.getServices());
  }

  final _$getVehicleServicesAsyncAction =
      AsyncAction('_ServicingStore.getVehicleServices');

  @override
  Future<dynamic> getVehicleServices(String registration) {
    return _$getVehicleServicesAsyncAction
        .run(() => super.getVehicleServices(registration));
  }

  final _$getPendingServicesAsyncAction =
      AsyncAction('_ServicingStore.getPendingServices');

  @override
  Future<dynamic> getPendingServices() {
    return _$getPendingServicesAsyncAction
        .run(() => super.getPendingServices());
  }

  final _$getServiceSlotsAsyncAction =
      AsyncAction('_ServicingStore.getServiceSlots');

  @override
  Future<dynamic> getServiceSlots(int id) {
    return _$getServiceSlotsAsyncAction.run(() => super.getServiceSlots(id));
  }

  @override
  String toString() {
    return '''
fetchWorkshopsFuture: ${fetchWorkshopsFuture},
fetchServiceTypesFuture: ${fetchServiceTypesFuture},
fetchPendingServicesFuture: ${fetchPendingServicesFuture},
fetchVehicleServicesFuture: ${fetchVehicleServicesFuture},
fetchServicesFuture: ${fetchServicesFuture},
fetchServiceFuture: ${fetchServiceFuture},
fetchServiceSlotsFuture: ${fetchServiceSlotsFuture},
workshopList: ${workshopList},
serviceTypeList: ${serviceTypeList},
pendingServiceList: ${pendingServiceList},
vehicleServiceList: ${vehicleServiceList},
serviceList: ${serviceList},
serviceSlotList: ${serviceSlotList},
service: ${service},
serviceOptions: ${serviceOptions},
workshopOptions: ${workshopOptions},
bookSuccess: ${bookSuccess},
bookLoading: ${bookLoading},
updateLoading: ${updateLoading},
scheduleSuccess: ${scheduleSuccess},
workshopsLoading: ${workshopsLoading},
serviceTypesLoading: ${serviceTypesLoading},
pendingServicesLoading: ${pendingServicesLoading},
servicesLoading: ${servicesLoading},
serviceLoading: ${serviceLoading},
vehicleServicesLoading: ${vehicleServicesLoading},
serviceSlotsLoading: ${serviceSlotsLoading}
    ''';
  }
}
