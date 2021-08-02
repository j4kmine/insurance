// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginFormStore on _LoginFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_LoginFormStore.canLogin'))
          .value;
  Computed<bool>? _$canSendOTPComputed;

  @override
  bool get canSendOTP =>
      (_$canSendOTPComputed ??= Computed<bool>(() => super.canSendOTP,
              name: '_LoginFormStore.canSendOTP'))
          .value;

  final _$userNRICAtom = Atom(name: '_LoginFormStore.userNRIC');

  @override
  String get userNRIC {
    _$userNRICAtom.reportRead();
    return super.userNRIC;
  }

  @override
  set userNRIC(String value) {
    _$userNRICAtom.reportWrite(value, super.userNRIC, () {
      super.userNRIC = value;
    });
  }

  final _$userPhoneAtom = Atom(name: '_LoginFormStore.userPhone');

  @override
  String get userPhone {
    _$userPhoneAtom.reportRead();
    return super.userPhone;
  }

  @override
  set userPhone(String value) {
    _$userPhoneAtom.reportWrite(value, super.userPhone, () {
      super.userPhone = value;
    });
  }

  final _$userOTPAtom = Atom(name: '_LoginFormStore.userOTP');

  @override
  String get userOTP {
    _$userOTPAtom.reportRead();
    return super.userOTP;
  }

  @override
  set userOTP(String value) {
    _$userOTPAtom.reportWrite(value, super.userOTP, () {
      super.userOTP = value;
    });
  }

  final _$_LoginFormStoreActionController =
      ActionController(name: '_LoginFormStore');

  @override
  void validateUserNRIC(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateUserNRIC');
    try {
      return super.validateUserNRIC(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserPhone(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateUserPhone');
    try {
      return super.validateUserPhone(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserOTP(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateUserOTP');
    try {
      return super.validateUserOTP(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userNRIC: ${userNRIC},
userPhone: ${userPhone},
userOTP: ${userOTP},
canLogin: ${canLogin},
canSendOTP: ${canSendOTP}
    ''';
  }
}

mixin _$LoginFormErrorStore on _LoginFormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_LoginFormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInSendOTPComputed;

  @override
  bool get hasErrorsInSendOTP => (_$hasErrorsInSendOTPComputed ??=
          Computed<bool>(() => super.hasErrorsInSendOTP,
              name: '_LoginFormErrorStore.hasErrorsInSendOTP'))
      .value;

  final _$userNRICAtom = Atom(name: '_LoginFormErrorStore.userNRIC');

  @override
  String get userNRIC {
    _$userNRICAtom.reportRead();
    return super.userNRIC;
  }

  @override
  set userNRIC(String value) {
    _$userNRICAtom.reportWrite(value, super.userNRIC, () {
      super.userNRIC = value;
    });
  }

  final _$userPhoneAtom = Atom(name: '_LoginFormErrorStore.userPhone');

  @override
  String get userPhone {
    _$userPhoneAtom.reportRead();
    return super.userPhone;
  }

  @override
  set userPhone(String value) {
    _$userPhoneAtom.reportWrite(value, super.userPhone, () {
      super.userPhone = value;
    });
  }

  final _$userOTPAtom = Atom(name: '_LoginFormErrorStore.userOTP');

  @override
  String get userOTP {
    _$userOTPAtom.reportRead();
    return super.userOTP;
  }

  @override
  set userOTP(String value) {
    _$userOTPAtom.reportWrite(value, super.userOTP, () {
      super.userOTP = value;
    });
  }

  @override
  String toString() {
    return '''
userNRIC: ${userNRIC},
userPhone: ${userPhone},
userOTP: ${userOTP},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInSendOTP: ${hasErrorsInSendOTP}
    ''';
  }
}
