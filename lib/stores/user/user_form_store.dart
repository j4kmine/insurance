import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/vehicle/vehicle_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'user_form_store.g.dart';

class UserFormStore = _UserFormStore with _$UserFormStore;

abstract class _UserFormStore with Store {
  // store for handling user errors
  final UserFormErrorStore userFormErrorStore = UserFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _UserFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupValidations() {
    _disposers = [];
  }

  // store variables:-----------------------------------------------------------
  // TODO:: Add validation
  @observable
  Customer? customer;

  @observable
  ObservableList<Vehicle>? vehicles;

  @observable
  ObservableList<bool> hideList =
      ObservableList<bool>.of([false, false, false, false]);

  @observable
  ObservableList<bool> hideVehicleList = ObservableList<bool>();

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class UserFormErrorStore = _UserFormErrorStore with _$UserFormErrorStore;

abstract class _UserFormErrorStore with Store {}
