import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'warranty_form_store.g.dart';

class WarrantyFormStore = _WarrantyFormStore with _$WarrantyFormStore;

abstract class _WarrantyFormStore with Store {
  // store for handling warranty errors
  final WarrantyFormErrorStore warrantyFormErrorStore =
      WarrantyFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _WarrantyFormStore() {
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
      reaction((_) => hybrid, validateHybrid),
      reaction((_) => cardName, validateCardName),
      reaction((_) => cardNo, validateCardNo),
      reaction((_) => expiryDate, validateExpiryDate),
      reaction((_) => cvv, validateCVV),
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
  String registrationDate = '';

  @observable
  String chassisNo = '';

  @observable
  String engineNo = '';

  @observable
  String capacity = '';

  @observable
  String driverNricUen = '';

  @observable
  String driverSalutation = '';

  @observable
  String driverName = '';

  @observable
  String driverAddress = '';

  @observable
  String driverGender = '';

  @observable
  String driverEmail = '';

  @observable
  String driverContactNo = '';

  @observable
  String startDate = '';

  @observable
  List<String> logCards = <String>[];

  @observable
  List<String> assessmentReports = <String>[];

  @observable
  int paymentOption = 0;

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

  @computed
  bool get canEnquiry => !warrantyFormErrorStore.hasErrorsInEnquiry;

  @computed
  bool get canQuote =>
      !warrantyFormErrorStore.hasErrorsInQuote &&
      vehicleNo.isNotEmpty &&
      carMake.isNotEmpty &&
      carModel.isNotEmpty &&
      type.isNotEmpty &&
      hybrid.isNotEmpty;

  @computed
  bool get canCreditCard =>
      !warrantyFormErrorStore.hasErrorsInCreditCard &&
      cardName.isNotEmpty &&
      cardNo.isNotEmpty &&
      expiryDate.isNotEmpty &&
      cvv.isNotEmpty;

  @computed
  bool get canPayNow =>
      !warrantyFormErrorStore.hasErrorsInPayNow &&
      recipient.isNotEmpty &&
      amount.isNotEmpty &&
      referenceId.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void validateVehicleNo(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.vehicleNo = "Vehicle No. can't be empty";
    } else {
      warrantyFormErrorStore.vehicleNo = "";
    }
  }

  @action
  void validateCarMake(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.carMake = "Car Make can't be empty";
    } else {
      warrantyFormErrorStore.carMake = "";
    }
  }

  @action
  void validateCarModel(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.carModel = "Car Model can't be empty";
    } else {
      warrantyFormErrorStore.carModel = "";
    }
  }

  @action
  void validateType(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.type = "Vehicle type can't be empty";
    } else {
      warrantyFormErrorStore.type = "";
    }
  }

  @action
  void validateHybrid(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.hybrid = "Hybrid type can't be empty";
    } else {
      warrantyFormErrorStore.hybrid = "";
    }
  }

  @action
  void validateCardName(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.cardName = "Card Name can't be empty";
    } else {
      warrantyFormErrorStore.cardName = "";
    }
  }

  @action
  void validateCardNo(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.cardNo = "Card No can't be empty";
    } else {
      warrantyFormErrorStore.cardNo = "";
    }
  }

  @action
  void validateExpiryDate(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.expiryDate = "Expiry Date can't be empty";
    } else {
      warrantyFormErrorStore.expiryDate = "";
    }
  }

  @action
  void validateCVV(String value) {
    if (value.isEmpty) {
      warrantyFormErrorStore.cvv = "CVV can't be empty";
    } else {
      warrantyFormErrorStore.cvv = "";
    }
  }

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class WarrantyFormErrorStore = _WarrantyFormErrorStore
    with _$WarrantyFormErrorStore;

abstract class _WarrantyFormErrorStore with Store {
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
