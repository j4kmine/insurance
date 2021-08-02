import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  // store for handling login errors
  final LoginFormErrorStore loginFormErrorStore = LoginFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _LoginFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userNRIC, validateUserNRIC),
      reaction((_) => userPhone, validateUserPhone),
      reaction((_) => userOTP, validateUserOTP),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userNRIC = '';

  @observable
  String userPhone = '';

  @observable
  String userOTP = '';

  @computed
  bool get canLogin =>
      !loginFormErrorStore.hasErrorsInLogin &&
      userNRIC.isNotEmpty &&
      userPhone.isNotEmpty;

  @computed
  bool get canSendOTP =>
      !loginFormErrorStore.hasErrorsInSendOTP && userOTP.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void validateUserNRIC(String value) {
    if (value.isEmpty) {
      loginFormErrorStore.userNRIC = "NRIC can't be empty";
    } else {
      loginFormErrorStore.userNRIC = "";
    }
  }

  @action
  void validateUserPhone(String value) {
    if (value.isEmpty) {
      loginFormErrorStore.userPhone = "Phone can't be empty";
    } else {
      loginFormErrorStore.userPhone = "";
    }
  }

  @action
  void validateUserOTP(String value) {
    if (value.isEmpty) {
      loginFormErrorStore.userOTP = "OTP can't be empty";
    } else {
      loginFormErrorStore.userOTP = "";
    }
  }

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class LoginFormErrorStore = _LoginFormErrorStore with _$LoginFormErrorStore;

abstract class _LoginFormErrorStore with Store {
  @observable
  String userNRIC = "";

  @observable
  String userPhone = "";

  @observable
  String userOTP = "";

  @computed
  bool get hasErrorsInLogin => userNRIC != "" || userPhone != "";

  @computed
  bool get hasErrorsInSendOTP => userOTP != "";
}
