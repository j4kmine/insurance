import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/motor/motor_make_list.dart';
import 'package:boilerplate/models/motor/motor_model_list.dart';
import 'package:boilerplate/models/motor/motor_search_car.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/models/motor/motor_buy.dart';
import 'package:boilerplate/models/motor/motor_enquiry.dart';
import 'package:boilerplate/models/motor/motor_list.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'motor_store.g.dart';

class MotorStore = _MotorStore with _$MotorStore;

abstract class _MotorStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _MotorStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<MotorMakeList?> emptyMakesResponse =
      ObservableFuture.value(null);
  static ObservableFuture<MotorModelList?> emptyModelsResponse =
      ObservableFuture.value(null);
  static ObservableFuture<MotorSearchCar?> emptySearchCarResponse =
      ObservableFuture.value(null);
  static ObservableFuture<MotorList?> emptyMotorsResponse =
      ObservableFuture.value(null);
  static ObservableFuture<MotorList?> emptyPendingMotorsResponse =
      ObservableFuture.value(null);
  static ObservableFuture<Motor?> emptyMotorResponse =
      ObservableFuture.value(null);
  static ObservableFuture<PayNow?> emptyPayNowResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<MotorMakeList?> fetchMakesFuture =
      ObservableFuture<MotorMakeList?>(emptyMakesResponse);

  @observable
  ObservableFuture<MotorModelList?> fetchModelsFuture =
      ObservableFuture<MotorModelList?>(emptyModelsResponse);

  @observable
  ObservableFuture<MotorList?> fetchMotorsFuture =
      ObservableFuture<MotorList?>(emptyMotorsResponse);

  @observable
  ObservableFuture<MotorSearchCar?> fetchSearchCarFuture =
      ObservableFuture<MotorSearchCar?>(emptySearchCarResponse);

  @observable
  ObservableFuture<MotorList?> fetchPendingMotorsFuture =
      ObservableFuture<MotorList?>(emptyPendingMotorsResponse);

  @observable
  ObservableFuture<Motor?> fetchMotorFuture =
      ObservableFuture<Motor?>(emptyMotorResponse);

  @observable
  ObservableFuture<PayNow?> fetchPayNowFuture =
      ObservableFuture<PayNow?>(emptyPayNowResponse);

  @observable
  PayNow? payNow;

  @observable
  MotorMakeList? makeList;

  @observable
  MotorModelList? modelList;

  @observable
  MotorSearchCar? searchCarResult;

  @observable
  MotorList? motorList;

  @observable
  MotorList? pendingMotorList;

  @observable
  Motor? motor;

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
  bool transferLoading = false;

  @observable
  bool transferSuccess = false;

  @observable
  bool checkoutLoading = false;

  @observable
  bool checkoutSuccess = false;

  @computed
  bool get makesLoading => fetchMakesFuture.status == FutureStatus.pending;

  @computed
  bool get modelsLoading => fetchModelsFuture.status == FutureStatus.pending;

  @computed
  bool get payNowLoading => fetchPayNowFuture.status == FutureStatus.pending;

  @computed
  bool get searchCarLoading =>
      fetchSearchCarFuture.status == FutureStatus.pending;

  @computed
  bool get motorsLoading => fetchMotorsFuture.status == FutureStatus.pending;

  @computed
  bool get pendingMotorsLoading =>
      fetchPendingMotorsFuture.status == FutureStatus.pending;

  @computed
  bool get motorLoading => fetchMotorFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future enquiry(MotorEnquiry motorEnquiry, List<String> logs) async {
    this.motor = null;
    enquiryLoading = true;
    final future = _repository.submitMotorEnquiry(motorEnquiry, logs);
    future.then((motor) {
      enquirySuccess = true;
      this.motor = motor;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => enquiryLoading = false);
  }

  @action
  Future transfer(int id) async {
    transferLoading = true;
    final future = _repository.transferMotor(id);
    future.then((message) {
      status = 'verifying';
      transferSuccess = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => transferLoading = false);
  }

  @action
  Future checkout(CreditCard card, int id) async {
    checkoutLoading = true;
    try {
      final payment = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: card,
        ),
      );
      final future = _repository.checkoutMotor(id, payment.id!);
      future.then((motor) {
        status = 'success';
        checkoutSuccess = true;
      }).catchError((error) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      }).whenComplete(() => checkoutLoading = false);
    } on PlatformException catch (err) {
      errorStore.errorMessage = err.toString().split(",")[1];
      checkoutLoading = false;
    }
  }

  @action
  Future getMotors() async {
    this.payNow = null;

    final future = _repository.getMotors();
    fetchMotorsFuture = ObservableFuture(future);

    future.then((motorList) {
      this.motorList = motorList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPayNow(int id) async {
    this.payNow = null;

    final future = _repository.getMotorPayNow(id);
    fetchPayNowFuture = ObservableFuture(future);

    future.then((payNow) {
      this.payNow = payNow;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getPendingMotors() async {
    this.pendingMotorList = null;
    final future = _repository.getPendingMotors();
    fetchPendingMotorsFuture = ObservableFuture(future);
    future.then((motorList) {
      this.pendingMotorList = motorList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getMotor(int id) async {
    this.motor = null;
    final future = _repository.getMotor(id);
    fetchMotorFuture = ObservableFuture(future);
    future.then((motor) {
      this.motor = motor;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getMakes() async {
    this.makeList = null;
    final future = _repository.getMotorMakes();
    fetchMakesFuture = ObservableFuture(future);
    future.then((makes) {
      this.makeList = makes;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getModels(String make) async {
    if (make != '') {
      this.modelList = null;
      final future = _repository.getMotorModels(make);
      fetchModelsFuture = ObservableFuture(future);
      future.then((models) {
        this.modelList = models;
      }).catchError((error) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  @action
  Future searchCar(String make, String model) async {
    if (make != '' && model != '') {
      this.searchCarResult = null;
      final future = _repository.motorSearchCar(make, model);
      fetchSearchCarFuture = ObservableFuture(future);
      future.then((car) {
        this.searchCarResult = car;
      }).catchError((error) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }
}
