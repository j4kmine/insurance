import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'register_form_store.g.dart';

class RegisterFormStore = _RegisterFormStore with _$RegisterFormStore;

abstract class _RegisterFormStore with Store {
  // store for handling register errors
  final RegisterFormErrorStore registerFormErrorStore =
      RegisterFormErrorStore();

  _RegisterFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userNRIC, validateUserNRIC),
      reaction((_) => userName, validateUserName),
      reaction((_) => userDOB, validateUserDOB),
      reaction((_) => userPhone, validateUserPhone),
      reaction((_) => userEmail, validateUserEmail)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userName = '';

  @observable
  String userNRIC = '';

  @observable
  String userDOB = '';

  @observable
  String userPhone = '';

  @observable
  String userEmail = '';

  @observable
  String companyName = '';

  @observable
  String companyUEN = '';

  @observable
  String companyDOB = '';

  @observable
  String companyPhone = '';

  @observable
  String companyEmail = '';

  @computed
  bool get canRegister =>
      !registerFormErrorStore.hasErrorsInRegister &&
      userName.isNotEmpty &&
      userNRIC.isNotEmpty &&
      userPhone.isNotEmpty &&
      userDOB.isNotEmpty &&
      userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      registerFormErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      registerFormErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      registerFormErrorStore.userEmail = "";
    }
  }

  @action
  void validateUserName(String value) {
    if (value.isEmpty) {
      registerFormErrorStore.userName = "Name can't be empty";
    } else {
      registerFormErrorStore.userName = "";
    }
  }

  @action
  void validateUserNRIC(String value) {
    if (value.isEmpty) {
      registerFormErrorStore.userNRIC = "NRIC can't be empty";
    } else {
      registerFormErrorStore.userNRIC = "";
    }
  }

  @action
  void validateUserDOB(String value) {
    if (value.isEmpty) {
      registerFormErrorStore.userDOB = "Date of birth can't be empty";
    } else {
      registerFormErrorStore.userDOB = "";
    }
  }

  @action
  void validateUserPhone(String value) {
    if (value.isEmpty) {
      registerFormErrorStore.userEmail = "Phone can't be empty";
    } else {
      registerFormErrorStore.userEmail = "";
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class RegisterFormErrorStore = _RegisterFormErrorStore
    with _$RegisterFormErrorStore;

abstract class _RegisterFormErrorStore with Store {
  @observable
  String userName = "";

  @observable
  String userNRIC = "";

  @observable
  String userDOB = "";

  @observable
  String userPhone = "";

  @observable
  String userEmail = "";

  @computed
  bool get hasErrorsInRegister =>
      userNRIC != "" ||
      userName != "" ||
      userDOB != "" ||
      userPhone != "" ||
      userEmail != "";
}
