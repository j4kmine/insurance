// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterStore on _RegisterStore, Store {
  final _$successAtom = Atom(name: '_RegisterStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loadingAtom = Atom(name: '_RegisterStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$redirectAtom = Atom(name: '_RegisterStore.redirect');

  @override
  bool get redirect {
    _$redirectAtom.reportRead();
    return super.redirect;
  }

  @override
  set redirect(bool value) {
    _$redirectAtom.reportWrite(value, super.redirect, () {
      super.redirect = value;
    });
  }

  final _$myinfoAtom = Atom(name: '_RegisterStore.myinfo');

  @override
  bool get myinfo {
    _$myinfoAtom.reportRead();
    return super.myinfo;
  }

  @override
  set myinfo(bool value) {
    _$myinfoAtom.reportWrite(value, super.myinfo, () {
      super.myinfo = value;
    });
  }

  final _$singpassAtom = Atom(name: '_RegisterStore.singpass');

  @override
  bool get singpass {
    _$singpassAtom.reportRead();
    return super.singpass;
  }

  @override
  set singpass(bool value) {
    _$singpassAtom.reportWrite(value, super.singpass, () {
      super.singpass = value;
    });
  }

  final _$nricAtom = Atom(name: '_RegisterStore.nric');

  @override
  String get nric {
    _$nricAtom.reportRead();
    return super.nric;
  }

  @override
  set nric(String value) {
    _$nricAtom.reportWrite(value, super.nric, () {
      super.nric = value;
    });
  }

  final _$nameAtom = Atom(name: '_RegisterStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$dobAtom = Atom(name: '_RegisterStore.dob');

  @override
  String get dob {
    _$dobAtom.reportRead();
    return super.dob;
  }

  @override
  set dob(String value) {
    _$dobAtom.reportWrite(value, super.dob, () {
      super.dob = value;
    });
  }

  final _$phoneAtom = Atom(name: '_RegisterStore.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$emailAtom = Atom(name: '_RegisterStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_RegisterStore.register');

  @override
  Future<dynamic> register(dynamic userName, dynamic userNRIC, dynamic userDOB,
      dynamic userPhone, dynamic userEmail, dynamic isCompany) {
    return _$registerAsyncAction.run(() => super.register(
        userName, userNRIC, userDOB, userPhone, userEmail, isCompany));
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
redirect: ${redirect},
myinfo: ${myinfo},
singpass: ${singpass},
nric: ${nric},
name: ${name},
dob: ${dob},
phone: ${phone},
email: ${email}
    ''';
  }
}
