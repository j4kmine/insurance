import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  // store for handling register errors
  Repository? _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  _RegisterStore(Repository repository) {
    this._repository = repository;
  }

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool redirect = false;

  @observable
  bool myinfo = false;

  @observable
  bool singpass = false;

  @observable
  String nric = '';

  @observable
  String name = '';

  @observable
  String dob = '';

  @observable
  String phone = '';

  @observable
  String email = '';

  // actions:-------------------------------------------------------------------
  @action
  Future register(
      userName, userNRIC, userDOB, userPhone, userEmail, isCompany) async {
    loading = true;
    final future = _repository!
        .register(userName, userNRIC, userDOB, userPhone, userEmail, isCompany);
    future.then((res) {
      loading = false;
      success = true;
      successStore.successMessage = res.message!;
    }).catchError((error) {
      loading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
