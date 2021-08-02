// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicing_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServicingFormStore on _ServicingFormStore, Store {
  Computed<bool>? _$canEnquiryComputed;

  @override
  bool get canEnquiry =>
      (_$canEnquiryComputed ??= Computed<bool>(() => super.canEnquiry,
              name: '_ServicingFormStore.canEnquiry'))
          .value;
  Computed<bool>? _$canQuoteComputed;

  @override
  bool get canQuote =>
      (_$canQuoteComputed ??= Computed<bool>(() => super.canQuote,
              name: '_ServicingFormStore.canQuote'))
          .value;

  final _$vehicleNoAtom = Atom(name: '_ServicingFormStore.vehicleNo');

  @override
  String get vehicleNo {
    _$vehicleNoAtom.reportRead();
    return super.vehicleNo;
  }

  @override
  set vehicleNo(String value) {
    _$vehicleNoAtom.reportWrite(value, super.vehicleNo, () {
      super.vehicleNo = value;
    });
  }

  final _$carMakeAtom = Atom(name: '_ServicingFormStore.carMake');

  @override
  String get carMake {
    _$carMakeAtom.reportRead();
    return super.carMake;
  }

  @override
  set carMake(String value) {
    _$carMakeAtom.reportWrite(value, super.carMake, () {
      super.carMake = value;
    });
  }

  final _$carModelAtom = Atom(name: '_ServicingFormStore.carModel');

  @override
  String get carModel {
    _$carModelAtom.reportRead();
    return super.carModel;
  }

  @override
  set carModel(String value) {
    _$carModelAtom.reportWrite(value, super.carModel, () {
      super.carModel = value;
    });
  }

  final _$typeAtom = Atom(name: '_ServicingFormStore.type');

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$hybridAtom = Atom(name: '_ServicingFormStore.hybrid');

  @override
  String get hybrid {
    _$hybridAtom.reportRead();
    return super.hybrid;
  }

  @override
  set hybrid(String value) {
    _$hybridAtom.reportWrite(value, super.hybrid, () {
      super.hybrid = value;
    });
  }

  final _$mileageAtom = Atom(name: '_ServicingFormStore.mileage');

  @override
  String get mileage {
    _$mileageAtom.reportRead();
    return super.mileage;
  }

  @override
  set mileage(String value) {
    _$mileageAtom.reportWrite(value, super.mileage, () {
      super.mileage = value;
    });
  }

  final _$manufactureYearAtom =
      Atom(name: '_ServicingFormStore.manufactureYear');

  @override
  String get manufactureYear {
    _$manufactureYearAtom.reportRead();
    return super.manufactureYear;
  }

  @override
  set manufactureYear(String value) {
    _$manufactureYearAtom.reportWrite(value, super.manufactureYear, () {
      super.manufactureYear = value;
    });
  }

  final _$dateAtom = Atom(name: '_ServicingFormStore.date');

  @override
  String get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$timeAtom = Atom(name: '_ServicingFormStore.time');

  @override
  String get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$serviceOptionAtom = Atom(name: '_ServicingFormStore.serviceOption');

  @override
  String get serviceOption {
    _$serviceOptionAtom.reportRead();
    return super.serviceOption;
  }

  @override
  set serviceOption(String value) {
    _$serviceOptionAtom.reportWrite(value, super.serviceOption, () {
      super.serviceOption = value;
    });
  }

  final _$workshopOptionAtom = Atom(name: '_ServicingFormStore.workshopOption');

  @override
  String get workshopOption {
    _$workshopOptionAtom.reportRead();
    return super.workshopOption;
  }

  @override
  set workshopOption(String value) {
    _$workshopOptionAtom.reportWrite(value, super.workshopOption, () {
      super.workshopOption = value;
    });
  }

  final _$timeOptionAtom = Atom(name: '_ServicingFormStore.timeOption');

  @override
  String get timeOption {
    _$timeOptionAtom.reportRead();
    return super.timeOption;
  }

  @override
  set timeOption(String value) {
    _$timeOptionAtom.reportWrite(value, super.timeOption, () {
      super.timeOption = value;
    });
  }

  final _$paymentOptionAtom = Atom(name: '_ServicingFormStore.paymentOption');

  @override
  int get paymentOption {
    _$paymentOptionAtom.reportRead();
    return super.paymentOption;
  }

  @override
  set paymentOption(int value) {
    _$paymentOptionAtom.reportWrite(value, super.paymentOption, () {
      super.paymentOption = value;
    });
  }

  final _$referenceIdAtom = Atom(name: '_ServicingFormStore.referenceId');

  @override
  String get referenceId {
    _$referenceIdAtom.reportRead();
    return super.referenceId;
  }

  @override
  set referenceId(String value) {
    _$referenceIdAtom.reportWrite(value, super.referenceId, () {
      super.referenceId = value;
    });
  }

  final _$remarksAtom = Atom(name: '_ServicingFormStore.remarks');

  @override
  String get remarks {
    _$remarksAtom.reportRead();
    return super.remarks;
  }

  @override
  set remarks(String value) {
    _$remarksAtom.reportWrite(value, super.remarks, () {
      super.remarks = value;
    });
  }

  final _$_ServicingFormStoreActionController =
      ActionController(name: '_ServicingFormStore');

  @override
  void validateVehicleNo(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateVehicleNo');
    try {
      return super.validateVehicleNo(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCarMake(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateCarMake');
    try {
      return super.validateCarMake(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCarModel(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateCarModel');
    try {
      return super.validateCarModel(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateType(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateType');
    try {
      return super.validateType(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateHybrid(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateHybrid');
    try {
      return super.validateHybrid(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCardName(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateCardName');
    try {
      return super.validateCardName(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCardNo(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateCardNo');
    try {
      return super.validateCardNo(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateExpiryDate(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateExpiryDate');
    try {
      return super.validateExpiryDate(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCVV(String value) {
    final _$actionInfo = _$_ServicingFormStoreActionController.startAction(
        name: '_ServicingFormStore.validateCVV');
    try {
      return super.validateCVV(value);
    } finally {
      _$_ServicingFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vehicleNo: ${vehicleNo},
carMake: ${carMake},
carModel: ${carModel},
type: ${type},
hybrid: ${hybrid},
mileage: ${mileage},
manufactureYear: ${manufactureYear},
date: ${date},
time: ${time},
serviceOption: ${serviceOption},
workshopOption: ${workshopOption},
timeOption: ${timeOption},
paymentOption: ${paymentOption},
referenceId: ${referenceId},
remarks: ${remarks},
canEnquiry: ${canEnquiry},
canQuote: ${canQuote}
    ''';
  }
}

mixin _$ServicingFormErrorStore on _ServicingFormErrorStore, Store {
  Computed<bool>? _$hasErrorsInEnquiryComputed;

  @override
  bool get hasErrorsInEnquiry => (_$hasErrorsInEnquiryComputed ??=
          Computed<bool>(() => super.hasErrorsInEnquiry,
              name: '_ServicingFormErrorStore.hasErrorsInEnquiry'))
      .value;
  Computed<bool>? _$hasErrorsInQuoteComputed;

  @override
  bool get hasErrorsInQuote => (_$hasErrorsInQuoteComputed ??= Computed<bool>(
          () => super.hasErrorsInQuote,
          name: '_ServicingFormErrorStore.hasErrorsInQuote'))
      .value;
  Computed<bool>? _$hasErrorsInCreditCardComputed;

  @override
  bool get hasErrorsInCreditCard => (_$hasErrorsInCreditCardComputed ??=
          Computed<bool>(() => super.hasErrorsInCreditCard,
              name: '_ServicingFormErrorStore.hasErrorsInCreditCard'))
      .value;
  Computed<bool>? _$hasErrorsInPayNowComputed;

  @override
  bool get hasErrorsInPayNow => (_$hasErrorsInPayNowComputed ??= Computed<bool>(
          () => super.hasErrorsInPayNow,
          name: '_ServicingFormErrorStore.hasErrorsInPayNow'))
      .value;

  final _$vehicleNoAtom = Atom(name: '_ServicingFormErrorStore.vehicleNo');

  @override
  String get vehicleNo {
    _$vehicleNoAtom.reportRead();
    return super.vehicleNo;
  }

  @override
  set vehicleNo(String value) {
    _$vehicleNoAtom.reportWrite(value, super.vehicleNo, () {
      super.vehicleNo = value;
    });
  }

  final _$carMakeAtom = Atom(name: '_ServicingFormErrorStore.carMake');

  @override
  String get carMake {
    _$carMakeAtom.reportRead();
    return super.carMake;
  }

  @override
  set carMake(String value) {
    _$carMakeAtom.reportWrite(value, super.carMake, () {
      super.carMake = value;
    });
  }

  final _$carModelAtom = Atom(name: '_ServicingFormErrorStore.carModel');

  @override
  String get carModel {
    _$carModelAtom.reportRead();
    return super.carModel;
  }

  @override
  set carModel(String value) {
    _$carModelAtom.reportWrite(value, super.carModel, () {
      super.carModel = value;
    });
  }

  final _$typeAtom = Atom(name: '_ServicingFormErrorStore.type');

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$hybridAtom = Atom(name: '_ServicingFormErrorStore.hybrid');

  @override
  String get hybrid {
    _$hybridAtom.reportRead();
    return super.hybrid;
  }

  @override
  set hybrid(String value) {
    _$hybridAtom.reportWrite(value, super.hybrid, () {
      super.hybrid = value;
    });
  }

  final _$cardNameAtom = Atom(name: '_ServicingFormErrorStore.cardName');

  @override
  String get cardName {
    _$cardNameAtom.reportRead();
    return super.cardName;
  }

  @override
  set cardName(String value) {
    _$cardNameAtom.reportWrite(value, super.cardName, () {
      super.cardName = value;
    });
  }

  final _$cardNoAtom = Atom(name: '_ServicingFormErrorStore.cardNo');

  @override
  String get cardNo {
    _$cardNoAtom.reportRead();
    return super.cardNo;
  }

  @override
  set cardNo(String value) {
    _$cardNoAtom.reportWrite(value, super.cardNo, () {
      super.cardNo = value;
    });
  }

  final _$expiryDateAtom = Atom(name: '_ServicingFormErrorStore.expiryDate');

  @override
  String get expiryDate {
    _$expiryDateAtom.reportRead();
    return super.expiryDate;
  }

  @override
  set expiryDate(String value) {
    _$expiryDateAtom.reportWrite(value, super.expiryDate, () {
      super.expiryDate = value;
    });
  }

  final _$cvvAtom = Atom(name: '_ServicingFormErrorStore.cvv');

  @override
  String get cvv {
    _$cvvAtom.reportRead();
    return super.cvv;
  }

  @override
  set cvv(String value) {
    _$cvvAtom.reportWrite(value, super.cvv, () {
      super.cvv = value;
    });
  }

  final _$recipientAtom = Atom(name: '_ServicingFormErrorStore.recipient');

  @override
  String get recipient {
    _$recipientAtom.reportRead();
    return super.recipient;
  }

  @override
  set recipient(String value) {
    _$recipientAtom.reportWrite(value, super.recipient, () {
      super.recipient = value;
    });
  }

  final _$amountAtom = Atom(name: '_ServicingFormErrorStore.amount');

  @override
  String get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(String value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  final _$referenceIdAtom = Atom(name: '_ServicingFormErrorStore.referenceId');

  @override
  String get referenceId {
    _$referenceIdAtom.reportRead();
    return super.referenceId;
  }

  @override
  set referenceId(String value) {
    _$referenceIdAtom.reportWrite(value, super.referenceId, () {
      super.referenceId = value;
    });
  }

  final _$packageIdAtom = Atom(name: '_ServicingFormErrorStore.packageId');

  @override
  String get packageId {
    _$packageIdAtom.reportRead();
    return super.packageId;
  }

  @override
  set packageId(String value) {
    _$packageIdAtom.reportWrite(value, super.packageId, () {
      super.packageId = value;
    });
  }

  @override
  String toString() {
    return '''
vehicleNo: ${vehicleNo},
carMake: ${carMake},
carModel: ${carModel},
type: ${type},
hybrid: ${hybrid},
cardName: ${cardName},
cardNo: ${cardNo},
expiryDate: ${expiryDate},
cvv: ${cvv},
recipient: ${recipient},
amount: ${amount},
referenceId: ${referenceId},
packageId: ${packageId},
hasErrorsInEnquiry: ${hasErrorsInEnquiry},
hasErrorsInQuote: ${hasErrorsInQuote},
hasErrorsInCreditCard: ${hasErrorsInCreditCard},
hasErrorsInPayNow: ${hasErrorsInPayNow}
    ''';
  }
}
