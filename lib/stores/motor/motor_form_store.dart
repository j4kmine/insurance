import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/driver/driver_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'motor_form_store.g.dart';

class MotorFormStore = _MotorFormStore with _$MotorFormStore;

abstract class _MotorFormStore with Store {
  // store for handling motor errors
  final MotorFormErrorStore motorFormErrorStore = MotorFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _MotorFormStore() {
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
  String bodyType = '';

  @observable
  String capacity = '';

  @observable
  String seatingCapacity = '';

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
  String expiryDate = '';

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
  String cvv = '';

  @observable
  String recipient = '';

  @observable
  String amount = '';

  @observable
  String referenceId = '';

  @observable
  String packageId = '';

  @observable
  String usage = '';

  @observable
  bool opc = false;

  @observable
  bool modified = false;

  @observable
  String noOfAccidents = '';

  @observable
  String totalClaim = '';

  @observable
  String ncd = '';

  @observable
  bool seriousOffence = false;

  @observable
  bool physicalDisable = false;

  @observable
  bool refused = false;

  @observable
  bool terminated = false;

  @observable
  bool driverOne = false;

  @observable
  bool driverTwo = false;

  @observable
  String idTypeOne = "";

  @observable
  String idNumberOne = "";

  @observable
  String nameOne = "";

  @observable
  String nationalityOne = "";

  @observable
  String residentialOne = "";

  @observable
  String genderOne = "";

  @observable
  String dobOne = "";

  @observable
  String dolOne = "";

  @observable
  String noOfAccidentOne = "";

  @observable
  String totalClaimOne = "";

  @observable
  String idTypeTwo = "";

  @observable
  String idNumberTwo = "";

  @observable
  String nameTwo = "";

  @observable
  String nationalityTwo = "";

  @observable
  String residentialTwo = "";

  @observable
  String genderTwo = "";

  @observable
  String dobTwo = "";

  @observable
  String dolTwo = "";

  @observable
  String noOfAccidentTwo = "";

  @observable
  String totalClaimTwo = "";

  @computed
  bool get canEnquiry => !motorFormErrorStore.hasErrorsInEnquiry;

  @computed
  bool get canQuote =>
      !motorFormErrorStore.hasErrorsInQuote &&
      vehicleNo.isNotEmpty &&
      carMake.isNotEmpty &&
      carModel.isNotEmpty &&
      type.isNotEmpty;

  @computed
  bool get canCreditCard =>
      !motorFormErrorStore.hasErrorsInCreditCard &&
      cardName.isNotEmpty &&
      cardNo.isNotEmpty &&
      expiryDate.isNotEmpty &&
      cvv.isNotEmpty;

  @computed
  bool get canPayNow =>
      !motorFormErrorStore.hasErrorsInPayNow &&
      recipient.isNotEmpty &&
      amount.isNotEmpty &&
      referenceId.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void validateVehicleNo(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.vehicleNo = "Vehicle No. can't be empty";
    } else {
      motorFormErrorStore.vehicleNo = "";
    }
  }

  @action
  void validateCarMake(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.carMake = "Car Make can't be empty";
    } else {
      motorFormErrorStore.carMake = "";
    }
  }

  @action
  void validateCarModel(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.carModel = "Car Model can't be empty";
    } else {
      motorFormErrorStore.carModel = "";
    }
  }

  @action
  void validateType(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.type = "Vehicle type can't be empty";
    } else {
      motorFormErrorStore.type = "";
    }
  }

  @action
  void validateHybrid(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.hybrid = "Hybrid type can't be empty";
    } else {
      motorFormErrorStore.hybrid = "";
    }
  }

  @action
  void validateCardName(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.cardName = "Card Name can't be empty";
    } else {
      motorFormErrorStore.cardName = "";
    }
  }

  @action
  void validateCardNo(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.cardNo = "Card No can't be empty";
    } else {
      motorFormErrorStore.cardNo = "";
    }
  }

  @action
  void validateExpiryDate(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.expiryDate = "Expiry Date can't be empty";
    } else {
      motorFormErrorStore.expiryDate = "";
    }
  }

  @action
  void validateCVV(String value) {
    if (value.isEmpty) {
      motorFormErrorStore.cvv = "CVV can't be empty";
    } else {
      motorFormErrorStore.cvv = "";
    }
  }

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class MotorFormErrorStore = _MotorFormErrorStore with _$MotorFormErrorStore;

abstract class _MotorFormErrorStore with Store {
  @observable
  String vehicleNo = '';

  @observable
  String carMake = '';

  @observable
  String carModel = '';

  @observable
  String bodyType = '';

  @observable
  String usage = '';

  @observable
  String opc = '';

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

  @observable
  String ncd = '';

  // TODO
  @computed
  bool get hasErrorsInEnquiry => false;

  @computed
  bool get hasErrorsInQuote =>
      vehicleNo != null ||
      carMake != null ||
      carModel != null ||
      type != null ||
      hybrid != "";

  @computed
  bool get hasErrorsInCreditCard =>
      cardName != "" || cardNo != "" || expiryDate != "" || cvv != "";

  @computed
  bool get hasErrorsInPayNow =>
      recipient != "" || amount != "" || referenceId != "";
}
