// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MotorStore on _MotorStore, Store {
  Computed<bool>? _$makesLoadingComputed;

  @override
  bool get makesLoading =>
      (_$makesLoadingComputed ??= Computed<bool>(() => super.makesLoading,
              name: '_MotorStore.makesLoading'))
          .value;
  Computed<bool>? _$modelsLoadingComputed;

  @override
  bool get modelsLoading =>
      (_$modelsLoadingComputed ??= Computed<bool>(() => super.modelsLoading,
              name: '_MotorStore.modelsLoading'))
          .value;
  Computed<bool>? _$payNowLoadingComputed;

  @override
  bool get payNowLoading =>
      (_$payNowLoadingComputed ??= Computed<bool>(() => super.payNowLoading,
              name: '_MotorStore.payNowLoading'))
          .value;
  Computed<bool>? _$searchCarLoadingComputed;

  @override
  bool get searchCarLoading => (_$searchCarLoadingComputed ??= Computed<bool>(
          () => super.searchCarLoading,
          name: '_MotorStore.searchCarLoading'))
      .value;
  Computed<bool>? _$motorsLoadingComputed;

  @override
  bool get motorsLoading =>
      (_$motorsLoadingComputed ??= Computed<bool>(() => super.motorsLoading,
              name: '_MotorStore.motorsLoading'))
          .value;
  Computed<bool>? _$pendingMotorsLoadingComputed;

  @override
  bool get pendingMotorsLoading => (_$pendingMotorsLoadingComputed ??=
          Computed<bool>(() => super.pendingMotorsLoading,
              name: '_MotorStore.pendingMotorsLoading'))
      .value;
  Computed<bool>? _$motorLoadingComputed;

  @override
  bool get motorLoading =>
      (_$motorLoadingComputed ??= Computed<bool>(() => super.motorLoading,
              name: '_MotorStore.motorLoading'))
          .value;

  final _$fetchMakesFutureAtom = Atom(name: '_MotorStore.fetchMakesFuture');

  @override
  ObservableFuture<MotorMakeList?> get fetchMakesFuture {
    _$fetchMakesFutureAtom.reportRead();
    return super.fetchMakesFuture;
  }

  @override
  set fetchMakesFuture(ObservableFuture<MotorMakeList?> value) {
    _$fetchMakesFutureAtom.reportWrite(value, super.fetchMakesFuture, () {
      super.fetchMakesFuture = value;
    });
  }

  final _$fetchModelsFutureAtom = Atom(name: '_MotorStore.fetchModelsFuture');

  @override
  ObservableFuture<MotorModelList?> get fetchModelsFuture {
    _$fetchModelsFutureAtom.reportRead();
    return super.fetchModelsFuture;
  }

  @override
  set fetchModelsFuture(ObservableFuture<MotorModelList?> value) {
    _$fetchModelsFutureAtom.reportWrite(value, super.fetchModelsFuture, () {
      super.fetchModelsFuture = value;
    });
  }

  final _$fetchMotorsFutureAtom = Atom(name: '_MotorStore.fetchMotorsFuture');

  @override
  ObservableFuture<MotorList?> get fetchMotorsFuture {
    _$fetchMotorsFutureAtom.reportRead();
    return super.fetchMotorsFuture;
  }

  @override
  set fetchMotorsFuture(ObservableFuture<MotorList?> value) {
    _$fetchMotorsFutureAtom.reportWrite(value, super.fetchMotorsFuture, () {
      super.fetchMotorsFuture = value;
    });
  }

  final _$fetchSearchCarFutureAtom =
      Atom(name: '_MotorStore.fetchSearchCarFuture');

  @override
  ObservableFuture<MotorSearchCar?> get fetchSearchCarFuture {
    _$fetchSearchCarFutureAtom.reportRead();
    return super.fetchSearchCarFuture;
  }

  @override
  set fetchSearchCarFuture(ObservableFuture<MotorSearchCar?> value) {
    _$fetchSearchCarFutureAtom.reportWrite(value, super.fetchSearchCarFuture,
        () {
      super.fetchSearchCarFuture = value;
    });
  }

  final _$fetchPendingMotorsFutureAtom =
      Atom(name: '_MotorStore.fetchPendingMotorsFuture');

  @override
  ObservableFuture<MotorList?> get fetchPendingMotorsFuture {
    _$fetchPendingMotorsFutureAtom.reportRead();
    return super.fetchPendingMotorsFuture;
  }

  @override
  set fetchPendingMotorsFuture(ObservableFuture<MotorList?> value) {
    _$fetchPendingMotorsFutureAtom
        .reportWrite(value, super.fetchPendingMotorsFuture, () {
      super.fetchPendingMotorsFuture = value;
    });
  }

  final _$fetchMotorFutureAtom = Atom(name: '_MotorStore.fetchMotorFuture');

  @override
  ObservableFuture<Motor?> get fetchMotorFuture {
    _$fetchMotorFutureAtom.reportRead();
    return super.fetchMotorFuture;
  }

  @override
  set fetchMotorFuture(ObservableFuture<Motor?> value) {
    _$fetchMotorFutureAtom.reportWrite(value, super.fetchMotorFuture, () {
      super.fetchMotorFuture = value;
    });
  }

  final _$fetchPayNowFutureAtom = Atom(name: '_MotorStore.fetchPayNowFuture');

  @override
  ObservableFuture<PayNow?> get fetchPayNowFuture {
    _$fetchPayNowFutureAtom.reportRead();
    return super.fetchPayNowFuture;
  }

  @override
  set fetchPayNowFuture(ObservableFuture<PayNow?> value) {
    _$fetchPayNowFutureAtom.reportWrite(value, super.fetchPayNowFuture, () {
      super.fetchPayNowFuture = value;
    });
  }

  final _$payNowAtom = Atom(name: '_MotorStore.payNow');

  @override
  PayNow? get payNow {
    _$payNowAtom.reportRead();
    return super.payNow;
  }

  @override
  set payNow(PayNow? value) {
    _$payNowAtom.reportWrite(value, super.payNow, () {
      super.payNow = value;
    });
  }

  final _$makeListAtom = Atom(name: '_MotorStore.makeList');

  @override
  MotorMakeList? get makeList {
    _$makeListAtom.reportRead();
    return super.makeList;
  }

  @override
  set makeList(MotorMakeList? value) {
    _$makeListAtom.reportWrite(value, super.makeList, () {
      super.makeList = value;
    });
  }

  final _$modelListAtom = Atom(name: '_MotorStore.modelList');

  @override
  MotorModelList? get modelList {
    _$modelListAtom.reportRead();
    return super.modelList;
  }

  @override
  set modelList(MotorModelList? value) {
    _$modelListAtom.reportWrite(value, super.modelList, () {
      super.modelList = value;
    });
  }

  final _$searchCarResultAtom = Atom(name: '_MotorStore.searchCarResult');

  @override
  MotorSearchCar? get searchCarResult {
    _$searchCarResultAtom.reportRead();
    return super.searchCarResult;
  }

  @override
  set searchCarResult(MotorSearchCar? value) {
    _$searchCarResultAtom.reportWrite(value, super.searchCarResult, () {
      super.searchCarResult = value;
    });
  }

  final _$motorListAtom = Atom(name: '_MotorStore.motorList');

  @override
  MotorList? get motorList {
    _$motorListAtom.reportRead();
    return super.motorList;
  }

  @override
  set motorList(MotorList? value) {
    _$motorListAtom.reportWrite(value, super.motorList, () {
      super.motorList = value;
    });
  }

  final _$pendingMotorListAtom = Atom(name: '_MotorStore.pendingMotorList');

  @override
  MotorList? get pendingMotorList {
    _$pendingMotorListAtom.reportRead();
    return super.pendingMotorList;
  }

  @override
  set pendingMotorList(MotorList? value) {
    _$pendingMotorListAtom.reportWrite(value, super.pendingMotorList, () {
      super.pendingMotorList = value;
    });
  }

  final _$motorAtom = Atom(name: '_MotorStore.motor');

  @override
  Motor? get motor {
    _$motorAtom.reportRead();
    return super.motor;
  }

  @override
  set motor(Motor? value) {
    _$motorAtom.reportWrite(value, super.motor, () {
      super.motor = value;
    });
  }

  final _$selectedOptionAtom = Atom(name: '_MotorStore.selectedOption');

  @override
  String? get selectedOption {
    _$selectedOptionAtom.reportRead();
    return super.selectedOption;
  }

  @override
  set selectedOption(String? value) {
    _$selectedOptionAtom.reportWrite(value, super.selectedOption, () {
      super.selectedOption = value;
    });
  }

  final _$pricesLoadedAtom = Atom(name: '_MotorStore.pricesLoaded');

  @override
  bool get pricesLoaded {
    _$pricesLoadedAtom.reportRead();
    return super.pricesLoaded;
  }

  @override
  set pricesLoaded(bool value) {
    _$pricesLoadedAtom.reportWrite(value, super.pricesLoaded, () {
      super.pricesLoaded = value;
    });
  }

  final _$statusAtom = Atom(name: '_MotorStore.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$enquiryLoadingAtom = Atom(name: '_MotorStore.enquiryLoading');

  @override
  bool get enquiryLoading {
    _$enquiryLoadingAtom.reportRead();
    return super.enquiryLoading;
  }

  @override
  set enquiryLoading(bool value) {
    _$enquiryLoadingAtom.reportWrite(value, super.enquiryLoading, () {
      super.enquiryLoading = value;
    });
  }

  final _$enquirySuccessAtom = Atom(name: '_MotorStore.enquirySuccess');

  @override
  bool get enquirySuccess {
    _$enquirySuccessAtom.reportRead();
    return super.enquirySuccess;
  }

  @override
  set enquirySuccess(bool value) {
    _$enquirySuccessAtom.reportWrite(value, super.enquirySuccess, () {
      super.enquirySuccess = value;
    });
  }

  final _$buyLoadingAtom = Atom(name: '_MotorStore.buyLoading');

  @override
  bool get buyLoading {
    _$buyLoadingAtom.reportRead();
    return super.buyLoading;
  }

  @override
  set buyLoading(bool value) {
    _$buyLoadingAtom.reportWrite(value, super.buyLoading, () {
      super.buyLoading = value;
    });
  }

  final _$buySuccessAtom = Atom(name: '_MotorStore.buySuccess');

  @override
  bool get buySuccess {
    _$buySuccessAtom.reportRead();
    return super.buySuccess;
  }

  @override
  set buySuccess(bool value) {
    _$buySuccessAtom.reportWrite(value, super.buySuccess, () {
      super.buySuccess = value;
    });
  }

  final _$transferLoadingAtom = Atom(name: '_MotorStore.transferLoading');

  @override
  bool get transferLoading {
    _$transferLoadingAtom.reportRead();
    return super.transferLoading;
  }

  @override
  set transferLoading(bool value) {
    _$transferLoadingAtom.reportWrite(value, super.transferLoading, () {
      super.transferLoading = value;
    });
  }

  final _$transferSuccessAtom = Atom(name: '_MotorStore.transferSuccess');

  @override
  bool get transferSuccess {
    _$transferSuccessAtom.reportRead();
    return super.transferSuccess;
  }

  @override
  set transferSuccess(bool value) {
    _$transferSuccessAtom.reportWrite(value, super.transferSuccess, () {
      super.transferSuccess = value;
    });
  }

  final _$checkoutLoadingAtom = Atom(name: '_MotorStore.checkoutLoading');

  @override
  bool get checkoutLoading {
    _$checkoutLoadingAtom.reportRead();
    return super.checkoutLoading;
  }

  @override
  set checkoutLoading(bool value) {
    _$checkoutLoadingAtom.reportWrite(value, super.checkoutLoading, () {
      super.checkoutLoading = value;
    });
  }

  final _$checkoutSuccessAtom = Atom(name: '_MotorStore.checkoutSuccess');

  @override
  bool get checkoutSuccess {
    _$checkoutSuccessAtom.reportRead();
    return super.checkoutSuccess;
  }

  @override
  set checkoutSuccess(bool value) {
    _$checkoutSuccessAtom.reportWrite(value, super.checkoutSuccess, () {
      super.checkoutSuccess = value;
    });
  }

  final _$enquiryAsyncAction = AsyncAction('_MotorStore.enquiry');

  @override
  Future<dynamic> enquiry(MotorEnquiry motorEnquiry, List<String> logs) {
    return _$enquiryAsyncAction.run(() => super.enquiry(motorEnquiry, logs));
  }

  final _$transferAsyncAction = AsyncAction('_MotorStore.transfer');

  @override
  Future<dynamic> transfer(int id) {
    return _$transferAsyncAction.run(() => super.transfer(id));
  }

  final _$checkoutAsyncAction = AsyncAction('_MotorStore.checkout');

  @override
  Future<dynamic> checkout(CreditCard card, int id) {
    return _$checkoutAsyncAction.run(() => super.checkout(card, id));
  }

  final _$getMotorsAsyncAction = AsyncAction('_MotorStore.getMotors');

  @override
  Future<dynamic> getMotors() {
    return _$getMotorsAsyncAction.run(() => super.getMotors());
  }

  final _$getPayNowAsyncAction = AsyncAction('_MotorStore.getPayNow');

  @override
  Future<dynamic> getPayNow(int id) {
    return _$getPayNowAsyncAction.run(() => super.getPayNow(id));
  }

  final _$getPendingMotorsAsyncAction =
      AsyncAction('_MotorStore.getPendingMotors');

  @override
  Future<dynamic> getPendingMotors() {
    return _$getPendingMotorsAsyncAction.run(() => super.getPendingMotors());
  }

  final _$getMotorAsyncAction = AsyncAction('_MotorStore.getMotor');

  @override
  Future<dynamic> getMotor(int id) {
    return _$getMotorAsyncAction.run(() => super.getMotor(id));
  }

  final _$getMakesAsyncAction = AsyncAction('_MotorStore.getMakes');

  @override
  Future<dynamic> getMakes() {
    return _$getMakesAsyncAction.run(() => super.getMakes());
  }

  final _$getModelsAsyncAction = AsyncAction('_MotorStore.getModels');

  @override
  Future<dynamic> getModels(String make) {
    return _$getModelsAsyncAction.run(() => super.getModels(make));
  }

  final _$searchCarAsyncAction = AsyncAction('_MotorStore.searchCar');

  @override
  Future<dynamic> searchCar(String make, String model) {
    return _$searchCarAsyncAction.run(() => super.searchCar(make, model));
  }

  @override
  String toString() {
    return '''
fetchMakesFuture: ${fetchMakesFuture},
fetchModelsFuture: ${fetchModelsFuture},
fetchMotorsFuture: ${fetchMotorsFuture},
fetchSearchCarFuture: ${fetchSearchCarFuture},
fetchPendingMotorsFuture: ${fetchPendingMotorsFuture},
fetchMotorFuture: ${fetchMotorFuture},
fetchPayNowFuture: ${fetchPayNowFuture},
payNow: ${payNow},
makeList: ${makeList},
modelList: ${modelList},
searchCarResult: ${searchCarResult},
motorList: ${motorList},
pendingMotorList: ${pendingMotorList},
motor: ${motor},
selectedOption: ${selectedOption},
pricesLoaded: ${pricesLoaded},
status: ${status},
enquiryLoading: ${enquiryLoading},
enquirySuccess: ${enquirySuccess},
buyLoading: ${buyLoading},
buySuccess: ${buySuccess},
transferLoading: ${transferLoading},
transferSuccess: ${transferSuccess},
checkoutLoading: ${checkoutLoading},
checkoutSuccess: ${checkoutSuccess},
makesLoading: ${makesLoading},
modelsLoading: ${modelsLoading},
payNowLoading: ${payNowLoading},
searchCarLoading: ${searchCarLoading},
motorsLoading: ${motorsLoading},
pendingMotorsLoading: ${pendingMotorsLoading},
motorLoading: ${motorLoading}
    ''';
  }
}
