// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterFormStore on _RegisterFormStore, Store {
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_RegisterFormStore.canRegister'))
          .value;

  final _$userNameAtom = Atom(name: '_RegisterFormStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$userNRICAtom = Atom(name: '_RegisterFormStore.userNRIC');

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

  final _$userDOBAtom = Atom(name: '_RegisterFormStore.userDOB');

  @override
  String get userDOB {
    _$userDOBAtom.reportRead();
    return super.userDOB;
  }

  @override
  set userDOB(String value) {
    _$userDOBAtom.reportWrite(value, super.userDOB, () {
      super.userDOB = value;
    });
  }

  final _$userPhoneAtom = Atom(name: '_RegisterFormStore.userPhone');

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

  final _$userEmailAtom = Atom(name: '_RegisterFormStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$companyNameAtom = Atom(name: '_RegisterFormStore.companyName');

  @override
  String get companyName {
    _$companyNameAtom.reportRead();
    return super.companyName;
  }

  @override
  set companyName(String value) {
    _$companyNameAtom.reportWrite(value, super.companyName, () {
      super.companyName = value;
    });
  }

  final _$companyUENAtom = Atom(name: '_RegisterFormStore.companyUEN');

  @override
  String get companyUEN {
    _$companyUENAtom.reportRead();
    return super.companyUEN;
  }

  @override
  set companyUEN(String value) {
    _$companyUENAtom.reportWrite(value, super.companyUEN, () {
      super.companyUEN = value;
    });
  }

  final _$companyDOBAtom = Atom(name: '_RegisterFormStore.companyDOB');

  @override
  String get companyDOB {
    _$companyDOBAtom.reportRead();
    return super.companyDOB;
  }

  @override
  set companyDOB(String value) {
    _$companyDOBAtom.reportWrite(value, super.companyDOB, () {
      super.companyDOB = value;
    });
  }

  final _$companyPhoneAtom = Atom(name: '_RegisterFormStore.companyPhone');

  @override
  String get companyPhone {
    _$companyPhoneAtom.reportRead();
    return super.companyPhone;
  }

  @override
  set companyPhone(String value) {
    _$companyPhoneAtom.reportWrite(value, super.companyPhone, () {
      super.companyPhone = value;
    });
  }

  final _$companyEmailAtom = Atom(name: '_RegisterFormStore.companyEmail');

  @override
  String get companyEmail {
    _$companyEmailAtom.reportRead();
    return super.companyEmail;
  }

  @override
  set companyEmail(String value) {
    _$companyEmailAtom.reportWrite(value, super.companyEmail, () {
      super.companyEmail = value;
    });
  }

  final _$_RegisterFormStoreActionController =
      ActionController(name: '_RegisterFormStore');

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_RegisterFormStoreActionController.startAction(
        name: '_RegisterFormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_RegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserName(String value) {
    final _$actionInfo = _$_RegisterFormStoreActionController.startAction(
        name: '_RegisterFormStore.validateUserName');
    try {
      return super.validateUserName(value);
    } finally {
      _$_RegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserNRIC(String value) {
    final _$actionInfo = _$_RegisterFormStoreActionController.startAction(
        name: '_RegisterFormStore.validateUserNRIC');
    try {
      return super.validateUserNRIC(value);
    } finally {
      _$_RegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserDOB(String value) {
    final _$actionInfo = _$_RegisterFormStoreActionController.startAction(
        name: '_RegisterFormStore.validateUserDOB');
    try {
      return super.validateUserDOB(value);
    } finally {
      _$_RegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserPhone(String value) {
    final _$actionInfo = _$_RegisterFormStoreActionController.startAction(
        name: '_RegisterFormStore.validateUserPhone');
    try {
      return super.validateUserPhone(value);
    } finally {
      _$_RegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userNRIC: ${userNRIC},
userDOB: ${userDOB},
userPhone: ${userPhone},
userEmail: ${userEmail},
companyName: ${companyName},
companyUEN: ${companyUEN},
companyDOB: ${companyDOB},
companyPhone: ${companyPhone},
companyEmail: ${companyEmail},
canRegister: ${canRegister}
    ''';
  }
}

mixin _$RegisterFormErrorStore on _RegisterFormErrorStore, Store {
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_RegisterFormErrorStore.hasErrorsInRegister'))
      .value;

  final _$userNameAtom = Atom(name: '_RegisterFormErrorStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$userNRICAtom = Atom(name: '_RegisterFormErrorStore.userNRIC');

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

  final _$userDOBAtom = Atom(name: '_RegisterFormErrorStore.userDOB');

  @override
  String get userDOB {
    _$userDOBAtom.reportRead();
    return super.userDOB;
  }

  @override
  set userDOB(String value) {
    _$userDOBAtom.reportWrite(value, super.userDOB, () {
      super.userDOB = value;
    });
  }

  final _$userPhoneAtom = Atom(name: '_RegisterFormErrorStore.userPhone');

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

  final _$userEmailAtom = Atom(name: '_RegisterFormErrorStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userNRIC: ${userNRIC},
userDOB: ${userDOB},
userPhone: ${userPhone},
userEmail: ${userEmail},
hasErrorsInRegister: ${hasErrorsInRegister}
    ''';
  }
}
