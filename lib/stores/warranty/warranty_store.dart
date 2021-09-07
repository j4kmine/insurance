import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/models/warranty/warranty_make_list.dart';
import 'package:boilerplate/models/warranty/warranty_model_list.dart';
import 'package:boilerplate/models/warranty/package_list.dart';
import 'package:boilerplate/models/warranty/price.dart';
import 'package:boilerplate/models/warranty/price_list.dart';
import 'package:boilerplate/models/warranty/warranty.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:boilerplate/models/warranty/warranty_enquiry.dart';
import 'package:boilerplate/models/warranty/warranty_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'warranty_store.g.dart';

class WarrantyStore = _WarrantyStore with _$WarrantyStore;

abstract class _WarrantyStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _WarrantyStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<WarrantyMakeList?> emptyMakesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyModelList?> emptyModelsResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyPriceList?> emptyPricesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyPrice?> emptyPriceResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyList?> emptyWarrantiesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyList?> emptyPendingWarrantiesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<Warranty?> emptyWarrantyResponse =
      ObservableFuture.value(null);
  static ObservableFuture<WarrantyPackageList?> emptyPackagesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<PayNow?> emptyPayNowResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<WarrantyMakeList?> fetchMakesFuture =
      ObservableFuture<WarrantyMakeList?>(emptyMakesResponse);

  @observable
  ObservableFuture<WarrantyModelList?> fetchModelsFuture =
      ObservableFuture<WarrantyModelList?>(emptyModelsResponse);

  @observable
  ObservableFuture<WarrantyPriceList?> fetchPricesFuture =
      ObservableFuture<WarrantyPriceList?>(emptyPricesResponse);

  @observable
  ObservableFuture<WarrantyPrice?> fetchPriceFuture =
      ObservableFuture<WarrantyPrice?>(emptyPriceResponse);

  @observable
  ObservableFuture<WarrantyList?> fetchWarrantiesFuture =
      ObservableFuture<WarrantyList?>(emptyWarrantiesResponse);

  @observable
  ObservableFuture<WarrantyList?> fetchPendingWarrantiesFuture =
      ObservableFuture<WarrantyList?>(emptyPendingWarrantiesResponse);

  @observable
  ObservableFuture<Warranty?> fetchWarrantyFuture =
      ObservableFuture<Warranty?>(emptyWarrantyResponse);

  @observable
  ObservableFuture<WarrantyPackageList?> fetchPackagesFuture =
      ObservableFuture<WarrantyPackageList?>(emptyPackagesResponse);

  @observable
  ObservableFuture<PayNow?> fetchPayNowFuture =
      ObservableFuture<PayNow?>(emptyPayNowResponse);

  @observable
  PayNow? payNow;

  @observable
  WarrantyMakeList? makeList;

  @observable
  WarrantyModelList? modelList;

  @observable
  WarrantyPackageList? packageList;

  @observable
  WarrantyList? warrantyList;

  @observable
  WarrantyList? pendingWarrantyList;

  @observable
  Warranty? warranty;

  @observable
  WarrantyPriceList? priceList;

  @observable
  WarrantyPrice? price;

  @observable
  String? selectedOption;

  @observable
  bool pricesLoaded = false;

  @observable
  String status = '';

  @observable
  bool enquiryLoading = false;

  @observable
  bool enquirySuccess = false;

  @observable
  bool buyLoading = false;

  @observable
  bool buySuccess = false;

  @observable
  bool checkoutLoading = false;

  @observable
  bool checkoutSuccess = false;

  @observable
  bool transferLoading = false;

  @observable
  bool transferSuccess = false;

  @computed
  bool get payNowLoading => fetchPayNowFuture.status == FutureStatus.pending;

  @computed
  bool get makesLoading => fetchMakesFuture.status == FutureStatus.pending;

  @computed
  bool get modelsLoading => fetchModelsFuture.status == FutureStatus.pending;

  @computed
  bool get pricesLoading => fetchPricesFuture.status == FutureStatus.pending;

  @computed
  bool get priceLoading => fetchPriceFuture.status == FutureStatus.pending;

  @computed
  bool get packagesLoading =>
      fetchPackagesFuture.status == FutureStatus.pending;

  @computed
  bool get warrantiesLoading =>
      fetchWarrantiesFuture.status == FutureStatus.pending;

  @computed
  bool get pendingWarrantiesLoading =>
      fetchPendingWarrantiesFuture.status == FutureStatus.pending;

  @computed
  bool get warrantyLoading =>
      fetchWarrantyFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future enquiry(WarrantyEnquiry warrantyEnquiry, List<String> logs,
      List<String> assessments) async {
    this.warranty = null;
    enquiryLoading = true;
    final future =
        _repository.submitWarrantyEnquiry(warrantyEnquiry, logs, assessments);
    future.then((warranty) {
      enquirySuccess = true;
      this.warranty = warranty;
      enquiryLoading = false;
    }).catchError((error) {
      enquiryLoading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future buy(WarrantyBuy warrantyBuy, List<String> logs,
      List<String> assessments) async {
    this.warranty = null;
    buyLoading = true;
    final future = _repository.buyWarranty(warrantyBuy, logs, assessments);
    future.then((warranty) {
      buySuccess = true;
      this.warranty = warranty;
      buyLoading = false;
    }).catchError((error) {
      buyLoading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future checkout(CreditCard card, int id) async {
    checkoutLoading = true;
    final payment = await StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: card,
      ),
    );
    final future = _repository.checkoutWarranty(id, payment.id!);
    future.then((warranty) {
      status = 'success';
      checkoutSuccess = true;
      checkoutLoading = false;
    }).catchError((error) {
      checkoutLoading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future transfer(int id) async {
    transferLoading = true;
    final future = _repository.transferWarranty(id);
    future.then((message) {
      status = 'verifying';
      transferSuccess = true;
      transferLoading = false;
    }).catchError((error) {
      transferLoading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPayNow(int id) async {
    this.payNow = null;

    final future = _repository.getWarrantyPayNow(id);
    fetchPayNowFuture = ObservableFuture(future);

    future.then((payNow) {
      this.payNow = payNow;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getWarranties() async {
    this.warrantyList = null;
    final future = _repository.getWarranties();
    fetchWarrantiesFuture = ObservableFuture(future);

    future.then((warrantyList) {
      this.warrantyList = warrantyList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPendingWarranties() async {
    this.pendingWarrantyList = null;
    final future = _repository.getPendingWarranties();
    fetchPendingWarrantiesFuture = ObservableFuture(future);

    future.then((warrantyList) {
      this.pendingWarrantyList = warrantyList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getWarranty(int id) async {
    this.warranty = null;
    final future = _repository.getWarranty(id);
    fetchWarrantyFuture = ObservableFuture(future);
    future.then((warranty) {
      this.warranty = warranty;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getMakes() async {
    this.makeList = null;
    final future = _repository.getWarrantyMakes();
    fetchMakesFuture = ObservableFuture(future);
    future.then((makes) {
      this.makeList = makes;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getModels(String make) async {
    this.modelList = null;
    final future = _repository.getWarrantyModels(make);
    fetchModelsFuture = ObservableFuture(future);
    future.then((models) {
      this.modelList = models;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPrices(String make, String model, String type, String fuel) async {
    this.priceList = null;
    final future = _repository.getWarrantyPrices(make, model, type, fuel);
    fetchPricesFuture = ObservableFuture(future);
    future.then((prices) {
      this.priceList = prices;
      this.pricesLoaded = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPrice(int id) async {
    final future = _repository.getWarrantyPrice(id);
    fetchPriceFuture = ObservableFuture(future);
    future.then((price) {
      this.price = price;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPackages() async {
    final future = _repository.getWarrantyPackages();
    fetchPackagesFuture = ObservableFuture(future);
    future.then((packageList) {
      this.packageList = packageList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
