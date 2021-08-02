// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VehicleStore on _VehicleStore, Store {
  Computed<bool>? _$vehicleLoadingComputed;

  @override
  bool get vehicleLoading =>
      (_$vehicleLoadingComputed ??= Computed<bool>(() => super.vehicleLoading,
              name: '_VehicleStore.vehicleLoading'))
          .value;
  Computed<bool>? _$vehicleSummaryLoadingComputed;

  @override
  bool get vehicleSummaryLoading => (_$vehicleSummaryLoadingComputed ??=
          Computed<bool>(() => super.vehicleSummaryLoading,
              name: '_VehicleStore.vehicleSummaryLoading'))
      .value;
  Computed<bool>? _$vehiclesLoadingComputed;

  @override
  bool get vehiclesLoading =>
      (_$vehiclesLoadingComputed ??= Computed<bool>(() => super.vehiclesLoading,
              name: '_VehicleStore.vehiclesLoading'))
          .value;
  Computed<bool>? _$accessLoadingComputed;

  @override
  bool get accessLoading =>
      (_$accessLoadingComputed ??= Computed<bool>(() => super.accessLoading,
              name: '_VehicleStore.accessLoading'))
          .value;

  final _$fetchVehicleFutureAtom =
      Atom(name: '_VehicleStore.fetchVehicleFuture');

  @override
  ObservableFuture<Vehicle?> get fetchVehicleFuture {
    _$fetchVehicleFutureAtom.reportRead();
    return super.fetchVehicleFuture;
  }

  @override
  set fetchVehicleFuture(ObservableFuture<Vehicle?> value) {
    _$fetchVehicleFutureAtom.reportWrite(value, super.fetchVehicleFuture, () {
      super.fetchVehicleFuture = value;
    });
  }

  final _$fetchVehiclesFutureAtom =
      Atom(name: '_VehicleStore.fetchVehiclesFuture');

  @override
  ObservableFuture<VehicleList?> get fetchVehiclesFuture {
    _$fetchVehiclesFutureAtom.reportRead();
    return super.fetchVehiclesFuture;
  }

  @override
  set fetchVehiclesFuture(ObservableFuture<VehicleList?> value) {
    _$fetchVehiclesFutureAtom.reportWrite(value, super.fetchVehiclesFuture, () {
      super.fetchVehiclesFuture = value;
    });
  }

  final _$fetchVehicleSummaryFutureAtom =
      Atom(name: '_VehicleStore.fetchVehicleSummaryFuture');

  @override
  ObservableFuture<VehicleSummary?> get fetchVehicleSummaryFuture {
    _$fetchVehicleSummaryFutureAtom.reportRead();
    return super.fetchVehicleSummaryFuture;
  }

  @override
  set fetchVehicleSummaryFuture(ObservableFuture<VehicleSummary?> value) {
    _$fetchVehicleSummaryFutureAtom
        .reportWrite(value, super.fetchVehicleSummaryFuture, () {
      super.fetchVehicleSummaryFuture = value;
    });
  }

  final _$fetchAccessFutureAtom = Atom(name: '_VehicleStore.fetchAccessFuture');

  @override
  ObservableFuture<Access?> get fetchAccessFuture {
    _$fetchAccessFutureAtom.reportRead();
    return super.fetchAccessFuture;
  }

  @override
  set fetchAccessFuture(ObservableFuture<Access?> value) {
    _$fetchAccessFutureAtom.reportWrite(value, super.fetchAccessFuture, () {
      super.fetchAccessFuture = value;
    });
  }

  final _$vehicleAtom = Atom(name: '_VehicleStore.vehicle');

  @override
  Vehicle? get vehicle {
    _$vehicleAtom.reportRead();
    return super.vehicle;
  }

  @override
  set vehicle(Vehicle? value) {
    _$vehicleAtom.reportWrite(value, super.vehicle, () {
      super.vehicle = value;
    });
  }

  final _$vehicleIdAtom = Atom(name: '_VehicleStore.vehicleId');

  @override
  int? get vehicleId {
    _$vehicleIdAtom.reportRead();
    return super.vehicleId;
  }

  @override
  set vehicleId(int? value) {
    _$vehicleIdAtom.reportWrite(value, super.vehicleId, () {
      super.vehicleId = value;
    });
  }

  final _$accessAtom = Atom(name: '_VehicleStore.access');

  @override
  Access? get access {
    _$accessAtom.reportRead();
    return super.access;
  }

  @override
  set access(Access? value) {
    _$accessAtom.reportWrite(value, super.access, () {
      super.access = value;
    });
  }

  final _$vehiclesAtom = Atom(name: '_VehicleStore.vehicles');

  @override
  VehicleList? get vehicles {
    _$vehiclesAtom.reportRead();
    return super.vehicles;
  }

  @override
  set vehicles(VehicleList? value) {
    _$vehiclesAtom.reportWrite(value, super.vehicles, () {
      super.vehicles = value;
    });
  }

  final _$vehicleSummaryAtom = Atom(name: '_VehicleStore.vehicleSummary');

  @override
  VehicleSummary? get vehicleSummary {
    _$vehicleSummaryAtom.reportRead();
    return super.vehicleSummary;
  }

  @override
  set vehicleSummary(VehicleSummary? value) {
    _$vehicleSummaryAtom.reportWrite(value, super.vehicleSummary, () {
      super.vehicleSummary = value;
    });
  }

  final _$vehicleOptionsAtom = Atom(name: '_VehicleStore.vehicleOptions');

  @override
  List<String>? get vehicleOptions {
    _$vehicleOptionsAtom.reportRead();
    return super.vehicleOptions;
  }

  @override
  set vehicleOptions(List<String>? value) {
    _$vehicleOptionsAtom.reportWrite(value, super.vehicleOptions, () {
      super.vehicleOptions = value;
    });
  }

  final _$vehicleMotorOptionsAtom =
      Atom(name: '_VehicleStore.vehicleMotorOptions');

  @override
  List<String>? get vehicleMotorOptions {
    _$vehicleMotorOptionsAtom.reportRead();
    return super.vehicleMotorOptions;
  }

  @override
  set vehicleMotorOptions(List<String>? value) {
    _$vehicleMotorOptionsAtom.reportWrite(value, super.vehicleMotorOptions, () {
      super.vehicleMotorOptions = value;
    });
  }

  final _$successAtom = Atom(name: '_VehicleStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$deleteSuccessAtom = Atom(name: '_VehicleStore.deleteSuccess');

  @override
  bool get deleteSuccess {
    _$deleteSuccessAtom.reportRead();
    return super.deleteSuccess;
  }

  @override
  set deleteSuccess(bool value) {
    _$deleteSuccessAtom.reportWrite(value, super.deleteSuccess, () {
      super.deleteSuccess = value;
    });
  }

  final _$deleteLoadingAtom = Atom(name: '_VehicleStore.deleteLoading');

  @override
  bool get deleteLoading {
    _$deleteLoadingAtom.reportRead();
    return super.deleteLoading;
  }

  @override
  set deleteLoading(bool value) {
    _$deleteLoadingAtom.reportWrite(value, super.deleteLoading, () {
      super.deleteLoading = value;
    });
  }

  final _$createSuccessAtom = Atom(name: '_VehicleStore.createSuccess');

  @override
  bool get createSuccess {
    _$createSuccessAtom.reportRead();
    return super.createSuccess;
  }

  @override
  set createSuccess(bool value) {
    _$createSuccessAtom.reportWrite(value, super.createSuccess, () {
      super.createSuccess = value;
    });
  }

  final _$createLoadingAtom = Atom(name: '_VehicleStore.createLoading');

  @override
  bool get createLoading {
    _$createLoadingAtom.reportRead();
    return super.createLoading;
  }

  @override
  set createLoading(bool value) {
    _$createLoadingAtom.reportWrite(value, super.createLoading, () {
      super.createLoading = value;
    });
  }

  final _$getVehicleAsyncAction = AsyncAction('_VehicleStore.getVehicle');

  @override
  Future<dynamic> getVehicle(int id) {
    return _$getVehicleAsyncAction.run(() => super.getVehicle(id));
  }

  final _$getAccessAsyncAction = AsyncAction('_VehicleStore.getAccess');

  @override
  Future<dynamic> getAccess(int id) {
    return _$getAccessAsyncAction.run(() => super.getAccess(id));
  }

  final _$createAccessAsyncAction = AsyncAction('_VehicleStore.createAccess');

  @override
  Future<dynamic> createAccess(String nric, int id) {
    return _$createAccessAsyncAction.run(() => super.createAccess(nric, id));
  }

  final _$deleteAccessAsyncAction = AsyncAction('_VehicleStore.deleteAccess');

  @override
  Future<dynamic> deleteAccess(String nric, int id) {
    return _$deleteAccessAsyncAction.run(() => super.deleteAccess(nric, id));
  }

  final _$getVehicleSummaryAsyncAction =
      AsyncAction('_VehicleStore.getVehicleSummary');

  @override
  Future<dynamic> getVehicleSummary() {
    return _$getVehicleSummaryAsyncAction.run(() => super.getVehicleSummary());
  }

  final _$getVehiclesAsyncAction = AsyncAction('_VehicleStore.getVehicles');

  @override
  Future<dynamic> getVehicles() {
    return _$getVehiclesAsyncAction.run(() => super.getVehicles());
  }

  @override
  String toString() {
    return '''
fetchVehicleFuture: ${fetchVehicleFuture},
fetchVehiclesFuture: ${fetchVehiclesFuture},
fetchVehicleSummaryFuture: ${fetchVehicleSummaryFuture},
fetchAccessFuture: ${fetchAccessFuture},
vehicle: ${vehicle},
vehicleId: ${vehicleId},
access: ${access},
vehicles: ${vehicles},
vehicleSummary: ${vehicleSummary},
vehicleOptions: ${vehicleOptions},
vehicleMotorOptions: ${vehicleMotorOptions},
success: ${success},
deleteSuccess: ${deleteSuccess},
deleteLoading: ${deleteLoading},
createSuccess: ${createSuccess},
createLoading: ${createLoading},
vehicleLoading: ${vehicleLoading},
vehicleSummaryLoading: ${vehicleSummaryLoading},
vehiclesLoading: ${vehiclesLoading},
accessLoading: ${accessLoading}
    ''';
  }
}
