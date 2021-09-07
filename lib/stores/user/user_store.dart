import 'package:boilerplate/models/customer/activity_list.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/success/success_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value ?? false;
    });
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);
  static ObservableFuture<Customer?> emptyCustomerResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ActivityList?> emptyActivityResponse =
      ObservableFuture.value(null);
  static ObservableFuture<ActivityList?> emptyNotificationResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool updateLoading = false;

  @observable
  bool success = false;

  @observable
  bool myinfo = false;

  @observable
  Customer? customer;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @observable
  ObservableFuture<Customer?> fetchCustomerFuture =
      ObservableFuture<Customer?>(emptyCustomerResponse);

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @computed
  bool get customerLoading =>
      fetchCustomerFuture.status == FutureStatus.pending;

  @observable
  ActivityList? notificationList;

  @observable
  ObservableFuture<ActivityList?> fetchNotificationFuture =
      ObservableFuture<ActivityList?>(emptyNotificationResponse);

  @computed
  bool get notificationLoading =>
      fetchNotificationFuture.status == FutureStatus.pending;

  @observable
  ActivityList? activityList;

  @observable
  ObservableFuture<ActivityList?> fetchActivityFuture =
      ObservableFuture<ActivityList?>(emptyActivityResponse);

  @computed
  bool get activityLoading =>
      fetchActivityFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String token) async {
    this.isLoggedIn = true;
    _repository.saveToken(token);
    _repository.saveIsLoggedIn(true);
  }

  @action
  Future updateProfile(Customer customer, List<Vehicle> vehicles) async {
    updateLoading = true;
    final future = _repository.updateProfile(customer, vehicles);
    future.then((customer) {
      this.customer = customer;
      successStore.successMessage = "Profile saved successfully.";
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    }).whenComplete(() => updateLoading = false);
  }

  logout() {
    this.isLoggedIn = false;
    _repository.saveIsLoggedIn(false);
  }

  @action
  Future getProfile() async {
    this.customer = null;
    final future = _repository.getCustomer();
    fetchCustomerFuture = ObservableFuture(future);
    future.then((customer) {
      this.customer = customer;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getActivities() async {
    this.activityList = null;
    final future = _repository.getActivities();
    fetchActivityFuture = ObservableFuture(future);
    future.then((activities) {
      this.activityList = activities;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getNotifications() async {
    this.notificationList = null;
    final future = _repository.getNotifications();
    fetchNotificationFuture = ObservableFuture(future);
    future.then((notifications) {
      this.notificationList = notifications;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}
