import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'servicing_form_store.g.dart';

class ServicingFormStore = _ServicingFormStore with _$ServicingFormStore;

abstract class _ServicingFormStore with Store {
  // store for handling servicing errors
  final ServicingFormErrorStore servicingFormErrorStore =
      ServicingFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _ServicingFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => vehicleNo, validateVehicleNo),
      reaction((_) => carMake, validateCarMake),
      reaction((_) => carModel, validateCarModel),
      reaction((_) => type, validateType),
      reaction((_) => hybrid, validateHybrid)
    ];
  }

  // store variables:-----------------------------------------------------------
  // TODO:: Add validation
  @observable
  String vehicleNo = '';

  @observable
  String carMake = '';

  @observable
  String carModel = '';

  @observable
  String type = '';

  @observable
  String hybrid = '';

  @observable
  String mileage = '';

  @observable
  String manufactureYear = '';

  @observable
  String date = '';

  @observable
  String time = '';

  @observable
  String serviceOption = '';

  @observable
  String workshopOption = '';

  @observable
  String timeOption = '';

  @observable
  int paymentOption = 0;

  @observable
  String referenceId = '';

  @observable
  String remarks = '';

  @computed
  bool get canEnquiry => !servicingFormErrorStore.hasErrorsInEnquiry;

  @computed
  bool get canQuote =>
      !servicingFormErrorStore.hasErrorsInQuote &&
      vehicleNo.isNotEmpty &&
      carMake.isNotEmpty &&
      carModel.isNotEmpty &&
      type.isNotEmpty &&
      hybrid.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void validateVehicleNo(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.vehicleNo = "Vehicle No. can't be empty";
    } else {
      servicingFormErrorStore.vehicleNo = "";
    }
  }

  @action
  void validateCarMake(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.carMake = "Car Make can't be empty";
    } else {
      servicingFormErrorStore.carMake = "";
    }
  }

  @action
  void validateCarModel(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.carModel = "Car Model can't be empty";
    } else {
      servicingFormErrorStore.carModel = "";
    }
  }

  @action
  void validateType(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.type = "Vehicle type can't be empty";
    } else {
      servicingFormErrorStore.type = "";
    }
  }

  @action
  void validateHybrid(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.hybrid = "Hybrid type can't be empty";
    } else {
      servicingFormErrorStore.hybrid = "";
    }
  }

  @action
  void validateCardName(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.cardName = "Card Name can't be empty";
    } else {
      servicingFormErrorStore.cardName = "";
    }
  }

  @action
  void validateCardNo(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.cardNo = "Card No can't be empty";
    } else {
      servicingFormErrorStore.cardNo = "";
    }
  }

  @action
  void validateExpiryDate(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.expiryDate = "Expiry Date can't be empty";
    } else {
      servicingFormErrorStore.expiryDate = "";
    }
  }

  @action
  void validateCVV(String value) {
    if (value.isEmpty) {
      servicingFormErrorStore.cvv = "CVV can't be empty";
    } else {
      servicingFormErrorStore.cvv = "";
    }
  }

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class ServicingFormErrorStore = _ServicingFormErrorStore
    with _$ServicingFormErrorStore;

abstract class _ServicingFormErrorStore with Store {
  @observable
  String vehicleNo = '';

  @observable
  String carMake = '';

  @observable
  String carModel = '';

  @observable
  String type = '';

  @observable
  String hybrid = '';

  @observable
  String cardName = '';

  @observable
  String cardNo = '';

  @observable
  String expiryDate = '';

  @observable
  String cvv = '';

  @observable
  String recipient = '';

  @observable
  String amount = '';

  @observable
  String referenceId = '';

  @observable
  String packageId = '';

  // TODO
  @computed
  bool get hasErrorsInEnquiry => false;

  @computed
  bool get hasErrorsInQuote =>
      vehicleNo != "" ||
      carMake != "" ||
      carModel != "" ||
      type != "" ||
      hybrid != "";

  @computed
  bool get hasErrorsInCreditCard =>
      cardName != "" || cardNo != "" || expiryDate != "" || cvv != "";

  @computed
  bool get hasErrorsInPayNow =>
      recipient != "" || amount != "" || referenceId != "";
}
