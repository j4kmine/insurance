// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WarrantyStore on _WarrantyStore, Store {
  Computed<bool>? _$payNowLoadingComputed;

  @override
  bool get payNowLoading =>
      (_$payNowLoadingComputed ??= Computed<bool>(() => super.payNowLoading,
              name: '_WarrantyStore.payNowLoading'))
          .value;
  Computed<bool>? _$makesLoadingComputed;

  @override
  bool get makesLoading =>
      (_$makesLoadingComputed ??= Computed<bool>(() => super.makesLoading,
              name: '_WarrantyStore.makesLoading'))
          .value;
  Computed<bool>? _$modelsLoadingComputed;

  @override
  bool get modelsLoading =>
      (_$modelsLoadingComputed ??= Computed<bool>(() => super.modelsLoading,
              name: '_WarrantyStore.modelsLoading'))
          .value;
  Computed<bool>? _$pricesLoadingComputed;

  @override
  bool get pricesLoading =>
      (_$pricesLoadingComputed ??= Computed<bool>(() => super.pricesLoading,
              name: '_WarrantyStore.pricesLoading'))
          .value;
  Computed<bool>? _$priceLoadingComputed;

  @override
  bool get priceLoading =>
      (_$priceLoadingComputed ??= Computed<bool>(() => super.priceLoading,
              name: '_WarrantyStore.priceLoading'))
          .value;
  Computed<bool>? _$packagesLoadingComputed;

  @override
  bool get packagesLoading =>
      (_$packagesLoadingComputed ??= Computed<bool>(() => super.packagesLoading,
              name: '_WarrantyStore.packagesLoading'))
          .value;
  Computed<bool>? _$warrantiesLoadingComputed;

  @override
  bool get warrantiesLoading => (_$warrantiesLoadingComputed ??= Computed<bool>(
          () => super.warrantiesLoading,
          name: '_WarrantyStore.warrantiesLoading'))
      .value;
  Computed<bool>? _$pendingWarrantiesLoadingComputed;

  @override
  bool get pendingWarrantiesLoading => (_$pendingWarrantiesLoadingComputed ??=
          Computed<bool>(() => super.pendingWarrantiesLoading,
              name: '_WarrantyStore.pendingWarrantiesLoading'))
      .value;
  Computed<bool>? _$warrantyLoadingComputed;

  @override
  bool get warrantyLoading =>
      (_$warrantyLoadingComputed ??= Computed<bool>(() => super.warrantyLoading,
              name: '_WarrantyStore.warrantyLoading'))
          .value;

  final _$fetchMakesFutureAtom = Atom(name: '_WarrantyStore.fetchMakesFuture');

  @override
  ObservableFuture<WarrantyMakeList?> get fetchMakesFuture {
    _$fetchMakesFutureAtom.reportRead();
    return super.fetchMakesFuture;
  }

  @override
  set fetchMakesFuture(ObservableFuture<WarrantyMakeList?> value) {
    _$fetchMakesFutureAtom.reportWrite(value, super.fetchMakesFuture, () {
      super.fetchMakesFuture = value;
    });
  }

  final _$fetchModelsFutureAtom =
      Atom(name: '_WarrantyStore.fetchModelsFuture');

  @override
  ObservableFuture<WarrantyModelList?> get fetchModelsFuture {
    _$fetchModelsFutureAtom.reportRead();
    return super.fetchModelsFuture;
  }

  @override
  set fetchModelsFuture(ObservableFuture<WarrantyModelList?> value) {
    _$fetchModelsFutureAtom.reportWrite(value, super.fetchModelsFuture, () {
      super.fetchModelsFuture = value;
    });
  }

  final _$fetchPricesFutureAtom =
      Atom(name: '_WarrantyStore.fetchPricesFuture');

  @override
  ObservableFuture<WarrantyPriceList?> get fetchPricesFuture {
    _$fetchPricesFutureAtom.reportRead();
    return super.fetchPricesFuture;
  }

  @override
  set fetchPricesFuture(ObservableFuture<WarrantyPriceList?> value) {
    _$fetchPricesFutureAtom.reportWrite(value, super.fetchPricesFuture, () {
      super.fetchPricesFuture = value;
    });
  }

  final _$fetchPriceFutureAtom = Atom(name: '_WarrantyStore.fetchPriceFuture');

  @override
  ObservableFuture<WarrantyPrice?> get fetchPriceFuture {
    _$fetchPriceFutureAtom.reportRead();
    return super.fetchPriceFuture;
  }

  @override
  set fetchPriceFuture(ObservableFuture<WarrantyPrice?> value) {
    _$fetchPriceFutureAtom.reportWrite(value, super.fetchPriceFuture, () {
      super.fetchPriceFuture = value;
    });
  }

  final _$fetchWarrantiesFutureAtom =
      Atom(name: '_WarrantyStore.fetchWarrantiesFuture');

  @override
  ObservableFuture<WarrantyList?> get fetchWarrantiesFuture {
    _$fetchWarrantiesFutureAtom.reportRead();
    return super.fetchWarrantiesFuture;
  }

  @override
  set fetchWarrantiesFuture(ObservableFuture<WarrantyList?> value) {
    _$fetchWarrantiesFutureAtom.reportWrite(value, super.fetchWarrantiesFuture,
        () {
      super.fetchWarrantiesFuture = value;
    });
  }

  final _$fetchPendingWarrantiesFutureAtom =
      Atom(name: '_WarrantyStore.fetchPendingWarrantiesFuture');

  @override
  ObservableFuture<WarrantyList?> get fetchPendingWarrantiesFuture {
    _$fetchPendingWarrantiesFutureAtom.reportRead();
    return super.fetchPendingWarrantiesFuture;
  }

  @override
  set fetchPendingWarrantiesFuture(ObservableFuture<WarrantyList?> value) {
    _$fetchPendingWarrantiesFutureAtom
        .reportWrite(value, super.fetchPendingWarrantiesFuture, () {
      super.fetchPendingWarrantiesFuture = value;
    });
  }

  final _$fetchWarrantyFutureAtom =
      Atom(name: '_WarrantyStore.fetchWarrantyFuture');

  @override
  ObservableFuture<Warranty?> get fetchWarrantyFuture {
    _$fetchWarrantyFutureAtom.reportRead();
    return super.fetchWarrantyFuture;
  }

  @override
  set fetchWarrantyFuture(ObservableFuture<Warranty?> value) {
    _$fetchWarrantyFutureAtom.reportWrite(value, super.fetchWarrantyFuture, () {
      super.fetchWarrantyFuture = value;
    });
  }

  final _$fetchPackagesFutureAtom =
      Atom(name: '_WarrantyStore.fetchPackagesFuture');

  @override
  ObservableFuture<WarrantyPackageList?> get fetchPackagesFuture {
    _$fetchPackagesFutureAtom.reportRead();
    return super.fetchPackagesFuture;
  }

  @override
  set fetchPackagesFuture(ObservableFuture<WarrantyPackageList?> value) {
    _$fetchPackagesFutureAtom.reportWrite(value, super.fetchPackagesFuture, () {
      super.fetchPackagesFuture = value;
    });
  }

  final _$fetchPayNowFutureAtom =
      Atom(name: '_WarrantyStore.fetchPayNowFuture');

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

  final _$payNowAtom = Atom(name: '_WarrantyStore.payNow');

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

  final _$makeListAtom = Atom(name: '_WarrantyStore.makeList');

  @override
  WarrantyMakeList? get makeList {
    _$makeListAtom.reportRead();
    return super.makeList;
  }

  @override
  set makeList(WarrantyMakeList? value) {
    _$makeListAtom.reportWrite(value, super.makeList, () {
      super.makeList = value;
    });
  }

  final _$modelListAtom = Atom(name: '_WarrantyStore.modelList');

  @override
  WarrantyModelList? get modelList {
    _$modelListAtom.reportRead();
    return super.modelList;
  }

  @override
  set modelList(WarrantyModelList? value) {
    _$modelListAtom.reportWrite(value, super.modelList, () {
      super.modelList = value;
    });
  }

  final _$packageListAtom = Atom(name: '_WarrantyStore.packageList');

  @override
  WarrantyPackageList? get packageList {
    _$packageListAtom.reportRead();
    return super.packageList;
  }

  @override
  set packageList(WarrantyPackageList? value) {
    _$packageListAtom.reportWrite(value, super.packageList, () {
      super.packageList = value;
    });
  }

  final _$warrantyListAtom = Atom(name: '_WarrantyStore.warrantyList');

  @override
  WarrantyList? get warrantyList {
    _$warrantyListAtom.reportRead();
    return super.warrantyList;
  }

  @override
  set warrantyList(WarrantyList? value) {
    _$warrantyListAtom.reportWrite(value, super.warrantyList, () {
      super.warrantyList = value;
    });
  }

  final _$pendingWarrantyListAtom =
      Atom(name: '_WarrantyStore.pendingWarrantyList');

  @override
  WarrantyList? get pendingWarrantyList {
    _$pendingWarrantyListAtom.reportRead();
    return super.pendingWarrantyList;
  }

  @override
  set pendingWarrantyList(WarrantyList? value) {
    _$pendingWarrantyListAtom.reportWrite(value, super.pendingWarrantyList, () {
      super.pendingWarrantyList = value;
    });
  }

  final _$warrantyAtom = Atom(name: '_WarrantyStore.warranty');

  @override
  Warranty? get warranty {
    _$warrantyAtom.reportRead();
    return super.warranty;
  }

  @override
  set warranty(Warranty? value) {
    _$warrantyAtom.reportWrite(value, super.warranty, () {
      super.warranty = value;
    });
  }

  final _$priceListAtom = Atom(name: '_WarrantyStore.priceList');

  @override
  WarrantyPriceList? get priceList {
    _$priceListAtom.reportRead();
    return super.priceList;
  }

  @override
  set priceList(WarrantyPriceList? value) {
    _$priceListAtom.reportWrite(value, super.priceList, () {
      super.priceList = value;
    });
  }

  final _$priceAtom = Atom(name: '_WarrantyStore.price');

  @override
  WarrantyPrice? get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(WarrantyPrice? value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  final _$selectedOptionAtom = Atom(name: '_WarrantyStore.selectedOption');

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

  final _$pricesLoadedAtom = Atom(name: '_WarrantyStore.pricesLoaded');

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

  final _$statusAtom = Atom(name: '_WarrantyStore.status');

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

  final _$enquiryLoadingAtom = Atom(name: '_WarrantyStore.enquiryLoading');

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

  final _$enquirySuccessAtom = Atom(name: '_WarrantyStore.enquirySuccess');

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

  final _$buyLoadingAtom = Atom(name: '_WarrantyStore.buyLoading');

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

  final _$buySuccessAtom = Atom(name: '_WarrantyStore.buySuccess');

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

  final _$checkoutLoadingAtom = Atom(name: '_WarrantyStore.checkoutLoading');

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

  final _$checkoutSuccessAtom = Atom(name: '_WarrantyStore.checkoutSuccess');

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

  final _$transferLoadingAtom = Atom(name: '_WarrantyStore.transferLoading');

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

  final _$transferSuccessAtom = Atom(name: '_WarrantyStore.transferSuccess');

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

  final _$enquiryAsyncAction = AsyncAction('_WarrantyStore.enquiry');

  @override
  Future<dynamic> enquiry(WarrantyEnquiry warrantyEnquiry, List<String> logs,
      List<String> assessments) {
    return _$enquiryAsyncAction
        .run(() => super.enquiry(warrantyEnquiry, logs, assessments));
  }

  final _$buyAsyncAction = AsyncAction('_WarrantyStore.buy');

  @override
  Future<dynamic> buy(
      WarrantyBuy warrantyBuy, List<String> logs, List<String> assessments) {
    return _$buyAsyncAction
        .run(() => super.buy(warrantyBuy, logs, assessments));
  }

  final _$checkoutAsyncAction = AsyncAction('_WarrantyStore.checkout');

  @override
  Future<dynamic> checkout(CreditCard card, int id) {
    return _$checkoutAsyncAction.run(() => super.checkout(card, id));
  }

  final _$transferAsyncAction = AsyncAction('_WarrantyStore.transfer');

  @override
  Future<dynamic> transfer(int id) {
    return _$transferAsyncAction.run(() => super.transfer(id));
  }

  final _$getPayNowAsyncAction = AsyncAction('_WarrantyStore.getPayNow');

  @override
  Future<dynamic> getPayNow(int id) {
    return _$getPayNowAsyncAction.run(() => super.getPayNow(id));
  }

  final _$getWarrantiesAsyncAction =
      AsyncAction('_WarrantyStore.getWarranties');

  @override
  Future<dynamic> getWarranties() {
    return _$getWarrantiesAsyncAction.run(() => super.getWarranties());
  }

  final _$getPendingWarrantiesAsyncAction =
      AsyncAction('_WarrantyStore.getPendingWarranties');

  @override
  Future<dynamic> getPendingWarranties() {
    return _$getPendingWarrantiesAsyncAction
        .run(() => super.getPendingWarranties());
  }

  final _$getWarrantyAsyncAction = AsyncAction('_WarrantyStore.getWarranty');

  @override
  Future<dynamic> getWarranty(int id) {
    return _$getWarrantyAsyncAction.run(() => super.getWarranty(id));
  }

  final _$getMakesAsyncAction = AsyncAction('_WarrantyStore.getMakes');

  @override
  Future<dynamic> getMakes() {
    return _$getMakesAsyncAction.run(() => super.getMakes());
  }

  final _$getModelsAsyncAction = AsyncAction('_WarrantyStore.getModels');

  @override
  Future<dynamic> getModels(String make) {
    return _$getModelsAsyncAction.run(() => super.getModels(make));
  }

  final _$getPricesAsyncAction = AsyncAction('_WarrantyStore.getPrices');

  @override
  Future<dynamic> getPrices(
      String make, String model, String type, String fuel) {
    return _$getPricesAsyncAction
        .run(() => super.getPrices(make, model, type, fuel));
  }

  final _$getPriceAsyncAction = AsyncAction('_WarrantyStore.getPrice');

  @override
  Future<dynamic> getPrice(int id) {
    return _$getPriceAsyncAction.run(() => super.getPrice(id));
  }

  final _$getPackagesAsyncAction = AsyncAction('_WarrantyStore.getPackages');

  @override
  Future<dynamic> getPackages() {
    return _$getPackagesAsyncAction.run(() => super.getPackages());
  }

  @override
  String toString() {
    return '''
fetchMakesFuture: ${fetchMakesFuture},
fetchModelsFuture: ${fetchModelsFuture},
fetchPricesFuture: ${fetchPricesFuture},
fetchPriceFuture: ${fetchPriceFuture},
fetchWarrantiesFuture: ${fetchWarrantiesFuture},
fetchPendingWarrantiesFuture: ${fetchPendingWarrantiesFuture},
fetchWarrantyFuture: ${fetchWarrantyFuture},
fetchPackagesFuture: ${fetchPackagesFuture},
fetchPayNowFuture: ${fetchPayNowFuture},
payNow: ${payNow},
makeList: ${makeList},
modelList: ${modelList},
packageList: ${packageList},
warrantyList: ${warrantyList},
pendingWarrantyList: ${pendingWarrantyList},
warranty: ${warranty},
priceList: ${priceList},
price: ${price},
selectedOption: ${selectedOption},
pricesLoaded: ${pricesLoaded},
status: ${status},
enquiryLoading: ${enquiryLoading},
enquirySuccess: ${enquirySuccess},
buyLoading: ${buyLoading},
buySuccess: ${buySuccess},
checkoutLoading: ${checkoutLoading},
checkoutSuccess: ${checkoutSuccess},
transferLoading: ${transferLoading},
transferSuccess: ${transferSuccess},
payNowLoading: ${payNowLoading},
makesLoading: ${makesLoading},
modelsLoading: ${modelsLoading},
pricesLoading: ${pricesLoading},
priceLoading: ${priceLoading},
packagesLoading: ${packagesLoading},
warrantiesLoading: ${warrantiesLoading},
pendingWarrantiesLoading: ${pendingWarrantiesLoading},
warrantyLoading: ${warrantyLoading}
    ''';
  }
}
