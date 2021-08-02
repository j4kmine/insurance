// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accident_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccidentStore on _AccidentStore, Store {
  Computed<bool>? _$vehicleInfoListLoadingComputed;

  @override
  bool get vehicleInfoListLoading => (_$vehicleInfoListLoadingComputed ??=
          Computed<bool>(() => super.vehicleInfoListLoading,
              name: '_AccidentStore.vehicleInfoListLoading'))
      .value;
  Computed<bool>? _$accidentLoadingComputed;

  @override
  bool get accidentLoading =>
      (_$accidentLoadingComputed ??= Computed<bool>(() => super.accidentLoading,
              name: '_AccidentStore.accidentLoading'))
          .value;
  Computed<bool>? _$vehicleAccidentsLoadingComputed;

  @override
  bool get vehicleAccidentsLoading => (_$vehicleAccidentsLoadingComputed ??=
          Computed<bool>(() => super.vehicleAccidentsLoading,
              name: '_AccidentStore.vehicleAccidentsLoading'))
      .value;

  final _$fetchVehicleInfoFutureAtom =
      Atom(name: '_AccidentStore.fetchVehicleInfoFuture');

  @override
  ObservableFuture<VehicleInfoList?> get fetchVehicleInfoFuture {
    _$fetchVehicleInfoFutureAtom.reportRead();
    return super.fetchVehicleInfoFuture;
  }

  @override
  set fetchVehicleInfoFuture(ObservableFuture<VehicleInfoList?> value) {
    _$fetchVehicleInfoFutureAtom
        .reportWrite(value, super.fetchVehicleInfoFuture, () {
      super.fetchVehicleInfoFuture = value;
    });
  }

  final _$fetchVehicleAccidentsFutureAtom =
      Atom(name: '_AccidentStore.fetchVehicleAccidentsFuture');

  @override
  ObservableFuture<AccidentList?> get fetchVehicleAccidentsFuture {
    _$fetchVehicleAccidentsFutureAtom.reportRead();
    return super.fetchVehicleAccidentsFuture;
  }

  @override
  set fetchVehicleAccidentsFuture(ObservableFuture<AccidentList?> value) {
    _$fetchVehicleAccidentsFutureAtom
        .reportWrite(value, super.fetchVehicleAccidentsFuture, () {
      super.fetchVehicleAccidentsFuture = value;
    });
  }

  final _$fetchAccidentFutureAtom =
      Atom(name: '_AccidentStore.fetchAccidentFuture');

  @override
  ObservableFuture<Accident?> get fetchAccidentFuture {
    _$fetchAccidentFutureAtom.reportRead();
    return super.fetchAccidentFuture;
  }

  @override
  set fetchAccidentFuture(ObservableFuture<Accident?> value) {
    _$fetchAccidentFutureAtom.reportWrite(value, super.fetchAccidentFuture, () {
      super.fetchAccidentFuture = value;
    });
  }

  final _$vehicleInfoListAtom = Atom(name: '_AccidentStore.vehicleInfoList');

  @override
  VehicleInfoList? get vehicleInfoList {
    _$vehicleInfoListAtom.reportRead();
    return super.vehicleInfoList;
  }

  @override
  set vehicleInfoList(VehicleInfoList? value) {
    _$vehicleInfoListAtom.reportWrite(value, super.vehicleInfoList, () {
      super.vehicleInfoList = value;
    });
  }

  final _$vehicleAccidentListAtom =
      Atom(name: '_AccidentStore.vehicleAccidentList');

  @override
  AccidentList? get vehicleAccidentList {
    _$vehicleAccidentListAtom.reportRead();
    return super.vehicleAccidentList;
  }

  @override
  set vehicleAccidentList(AccidentList? value) {
    _$vehicleAccidentListAtom.reportWrite(value, super.vehicleAccidentList, () {
      super.vehicleAccidentList = value;
    });
  }

  final _$accidentAtom = Atom(name: '_AccidentStore.accident');

  @override
  Accident? get accident {
    _$accidentAtom.reportRead();
    return super.accident;
  }

  @override
  set accident(Accident? value) {
    _$accidentAtom.reportWrite(value, super.accident, () {
      super.accident = value;
    });
  }

  final _$accidentSceneFilesAtom =
      Atom(name: '_AccidentStore.accidentSceneFiles');

  @override
  List<String> get accidentSceneFiles {
    _$accidentSceneFilesAtom.reportRead();
    return super.accidentSceneFiles;
  }

  @override
  set accidentSceneFiles(List<String> value) {
    _$accidentSceneFilesAtom.reportWrite(value, super.accidentSceneFiles, () {
      super.accidentSceneFiles = value;
    });
  }

  final _$vehicleCarPlateFilesAtom =
      Atom(name: '_AccidentStore.vehicleCarPlateFiles');

  @override
  List<String> get vehicleCarPlateFiles {
    _$vehicleCarPlateFilesAtom.reportRead();
    return super.vehicleCarPlateFiles;
  }

  @override
  set vehicleCarPlateFiles(List<String> value) {
    _$vehicleCarPlateFilesAtom.reportWrite(value, super.vehicleCarPlateFiles,
        () {
      super.vehicleCarPlateFiles = value;
    });
  }

  final _$closeRangeDamageFilesAtom =
      Atom(name: '_AccidentStore.closeRangeDamageFiles');

  @override
  List<String> get closeRangeDamageFiles {
    _$closeRangeDamageFilesAtom.reportRead();
    return super.closeRangeDamageFiles;
  }

  @override
  set closeRangeDamageFiles(List<String> value) {
    _$closeRangeDamageFilesAtom.reportWrite(value, super.closeRangeDamageFiles,
        () {
      super.closeRangeDamageFiles = value;
    });
  }

  final _$longRangeDamageFilesAtom =
      Atom(name: '_AccidentStore.longRangeDamageFiles');

  @override
  List<String> get longRangeDamageFiles {
    _$longRangeDamageFilesAtom.reportRead();
    return super.longRangeDamageFiles;
  }

  @override
  set longRangeDamageFiles(List<String> value) {
    _$longRangeDamageFilesAtom.reportWrite(value, super.longRangeDamageFiles,
        () {
      super.longRangeDamageFiles = value;
    });
  }

  final _$otherDrivingLicenseFilesAtom =
      Atom(name: '_AccidentStore.otherDrivingLicenseFiles');

  @override
  List<String> get otherDrivingLicenseFiles {
    _$otherDrivingLicenseFilesAtom.reportRead();
    return super.otherDrivingLicenseFiles;
  }

  @override
  set otherDrivingLicenseFiles(List<String> value) {
    _$otherDrivingLicenseFilesAtom
        .reportWrite(value, super.otherDrivingLicenseFiles, () {
      super.otherDrivingLicenseFiles = value;
    });
  }

  final _$otherVehicleCarPlateFilesAtom =
      Atom(name: '_AccidentStore.otherVehicleCarPlateFiles');

  @override
  List<String> get otherVehicleCarPlateFiles {
    _$otherVehicleCarPlateFilesAtom.reportRead();
    return super.otherVehicleCarPlateFiles;
  }

  @override
  set otherVehicleCarPlateFiles(List<String> value) {
    _$otherVehicleCarPlateFilesAtom
        .reportWrite(value, super.otherVehicleCarPlateFiles, () {
      super.otherVehicleCarPlateFiles = value;
    });
  }

  final _$otherCloseRangeDamageFilesAtom =
      Atom(name: '_AccidentStore.otherCloseRangeDamageFiles');

  @override
  List<String> get otherCloseRangeDamageFiles {
    _$otherCloseRangeDamageFilesAtom.reportRead();
    return super.otherCloseRangeDamageFiles;
  }

  @override
  set otherCloseRangeDamageFiles(List<String> value) {
    _$otherCloseRangeDamageFilesAtom
        .reportWrite(value, super.otherCloseRangeDamageFiles, () {
      super.otherCloseRangeDamageFiles = value;
    });
  }

  final _$otherLongRangeDamageFilesAtom =
      Atom(name: '_AccidentStore.otherLongRangeDamageFiles');

  @override
  List<String> get otherLongRangeDamageFiles {
    _$otherLongRangeDamageFilesAtom.reportRead();
    return super.otherLongRangeDamageFiles;
  }

  @override
  set otherLongRangeDamageFiles(List<String> value) {
    _$otherLongRangeDamageFilesAtom
        .reportWrite(value, super.otherLongRangeDamageFiles, () {
      super.otherLongRangeDamageFiles = value;
    });
  }

  final _$fileIndexAtom = Atom(name: '_AccidentStore.fileIndex');

  @override
  int get fileIndex {
    _$fileIndexAtom.reportRead();
    return super.fileIndex;
  }

  @override
  set fileIndex(int value) {
    _$fileIndexAtom.reportWrite(value, super.fileIndex, () {
      super.fileIndex = value;
    });
  }

  final _$photoTitleAtom = Atom(name: '_AccidentStore.photoTitle');

  @override
  String get photoTitle {
    _$photoTitleAtom.reportRead();
    return super.photoTitle;
  }

  @override
  set photoTitle(String value) {
    _$photoTitleAtom.reportWrite(value, super.photoTitle, () {
      super.photoTitle = value;
    });
  }

  final _$submitSuccessAtom = Atom(name: '_AccidentStore.submitSuccess');

  @override
  bool get submitSuccess {
    _$submitSuccessAtom.reportRead();
    return super.submitSuccess;
  }

  @override
  set submitSuccess(bool value) {
    _$submitSuccessAtom.reportWrite(value, super.submitSuccess, () {
      super.submitSuccess = value;
    });
  }

  final _$submitLoadingAtom = Atom(name: '_AccidentStore.submitLoading');

  @override
  bool get submitLoading {
    _$submitLoadingAtom.reportRead();
    return super.submitLoading;
  }

  @override
  set submitLoading(bool value) {
    _$submitLoadingAtom.reportWrite(value, super.submitLoading, () {
      super.submitLoading = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_AccidentStore.submit');

  @override
  Future<dynamic> submit(AccidentSubmit accidentSubmit) {
    return _$submitAsyncAction.run(() => super.submit(accidentSubmit));
  }

  final _$getVehicleAccidentsAsyncAction =
      AsyncAction('_AccidentStore.getVehicleAccidents');

  @override
  Future<dynamic> getVehicleAccidents(String registration) {
    return _$getVehicleAccidentsAsyncAction
        .run(() => super.getVehicleAccidents(registration));
  }

  final _$getVehiclesAsyncAction = AsyncAction('_AccidentStore.getVehicles');

  @override
  Future<dynamic> getVehicles() {
    return _$getVehiclesAsyncAction.run(() => super.getVehicles());
  }

  final _$getAccidentAsyncAction = AsyncAction('_AccidentStore.getAccident');

  @override
  Future<dynamic> getAccident(int id) {
    return _$getAccidentAsyncAction.run(() => super.getAccident(id));
  }

  @override
  String toString() {
    return '''
fetchVehicleInfoFuture: ${fetchVehicleInfoFuture},
fetchVehicleAccidentsFuture: ${fetchVehicleAccidentsFuture},
fetchAccidentFuture: ${fetchAccidentFuture},
vehicleInfoList: ${vehicleInfoList},
vehicleAccidentList: ${vehicleAccidentList},
accident: ${accident},
accidentSceneFiles: ${accidentSceneFiles},
vehicleCarPlateFiles: ${vehicleCarPlateFiles},
closeRangeDamageFiles: ${closeRangeDamageFiles},
longRangeDamageFiles: ${longRangeDamageFiles},
otherDrivingLicenseFiles: ${otherDrivingLicenseFiles},
otherVehicleCarPlateFiles: ${otherVehicleCarPlateFiles},
otherCloseRangeDamageFiles: ${otherCloseRangeDamageFiles},
otherLongRangeDamageFiles: ${otherLongRangeDamageFiles},
fileIndex: ${fileIndex},
photoTitle: ${photoTitle},
submitSuccess: ${submitSuccess},
submitLoading: ${submitLoading},
vehicleInfoListLoading: ${vehicleInfoListLoading},
accidentLoading: ${accidentLoading},
vehicleAccidentsLoading: ${vehicleAccidentsLoading}
    ''';
  }
}
