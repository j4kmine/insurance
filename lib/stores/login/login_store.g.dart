// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$verificationIdAtom = Atom(name: '_LoginStore.verificationId');

  @override
  String get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  final _$userNRICAtom = Atom(name: '_LoginStore.userNRIC');

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

  final _$userPhoneAtom = Atom(name: '_LoginStore.userPhone');

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

  final _$submittedAtom = Atom(name: '_LoginStore.submitted');

  @override
  bool get submitted {
    _$submittedAtom.reportRead();
    return super.submitted;
  }

  @override
  set submitted(bool value) {
    _$submittedAtom.reportWrite(value, super.submitted, () {
      super.submitted = value;
    });
  }

  final _$successAtom = Atom(name: '_LoginStore.success');

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

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

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

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<dynamic> login(
      BuildContext context, String userNRIC, String userPhone) {
    return _$loginAsyncAction
        .run(() => super.login(context, userNRIC, userPhone));
  }

  final _$sendOTPAsyncAction = AsyncAction('_LoginStore.sendOTP');

  @override
  Future<dynamic> sendOTP(BuildContext context, String userOTP) {
    return _$sendOTPAsyncAction.run(() => super.sendOTP(context, userOTP));
  }

  @override
  String toString() {
    return '''
verificationId: ${verificationId},
userNRIC: ${userNRIC},
userPhone: ${userPhone},
submitted: ${submitted},
success: ${success},
loading: ${loading}
    ''';
  }
}
