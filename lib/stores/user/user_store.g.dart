// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;
  Computed<bool>? _$customerLoadingComputed;

  @override
  bool get customerLoading =>
      (_$customerLoadingComputed ??= Computed<bool>(() => super.customerLoading,
              name: '_UserStore.customerLoading'))
          .value;
  Computed<bool>? _$notificationLoadingComputed;

  @override
  bool get notificationLoading => (_$notificationLoadingComputed ??=
          Computed<bool>(() => super.notificationLoading,
              name: '_UserStore.notificationLoading'))
      .value;
  Computed<bool>? _$activityLoadingComputed;

  @override
  bool get activityLoading =>
      (_$activityLoadingComputed ??= Computed<bool>(() => super.activityLoading,
              name: '_UserStore.activityLoading'))
          .value;

  final _$updateLoadingAtom = Atom(name: '_UserStore.updateLoading');

  @override
  bool get updateLoading {
    _$updateLoadingAtom.reportRead();
    return super.updateLoading;
  }

  @override
  set updateLoading(bool value) {
    _$updateLoadingAtom.reportWrite(value, super.updateLoading, () {
      super.updateLoading = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStore.success');

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

  final _$myinfoAtom = Atom(name: '_UserStore.myinfo');

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

  final _$customerAtom = Atom(name: '_UserStore.customer');

  @override
  Customer? get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(Customer? value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  final _$loginFutureAtom = Atom(name: '_UserStore.loginFuture');

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$fetchCustomerFutureAtom =
      Atom(name: '_UserStore.fetchCustomerFuture');

  @override
  ObservableFuture<Customer?> get fetchCustomerFuture {
    _$fetchCustomerFutureAtom.reportRead();
    return super.fetchCustomerFuture;
  }

  @override
  set fetchCustomerFuture(ObservableFuture<Customer?> value) {
    _$fetchCustomerFutureAtom.reportWrite(value, super.fetchCustomerFuture, () {
      super.fetchCustomerFuture = value;
    });
  }

  final _$notificationListAtom = Atom(name: '_UserStore.notificationList');

  @override
  ActivityList? get notificationList {
    _$notificationListAtom.reportRead();
    return super.notificationList;
  }

  @override
  set notificationList(ActivityList? value) {
    _$notificationListAtom.reportWrite(value, super.notificationList, () {
      super.notificationList = value;
    });
  }

  final _$fetchNotificationFutureAtom =
      Atom(name: '_UserStore.fetchNotificationFuture');

  @override
  ObservableFuture<ActivityList?> get fetchNotificationFuture {
    _$fetchNotificationFutureAtom.reportRead();
    return super.fetchNotificationFuture;
  }

  @override
  set fetchNotificationFuture(ObservableFuture<ActivityList?> value) {
    _$fetchNotificationFutureAtom
        .reportWrite(value, super.fetchNotificationFuture, () {
      super.fetchNotificationFuture = value;
    });
  }

  final _$activityListAtom = Atom(name: '_UserStore.activityList');

  @override
  ActivityList? get activityList {
    _$activityListAtom.reportRead();
    return super.activityList;
  }

  @override
  set activityList(ActivityList? value) {
    _$activityListAtom.reportWrite(value, super.activityList, () {
      super.activityList = value;
    });
  }

  final _$fetchActivityFutureAtom =
      Atom(name: '_UserStore.fetchActivityFuture');

  @override
  ObservableFuture<ActivityList?> get fetchActivityFuture {
    _$fetchActivityFutureAtom.reportRead();
    return super.fetchActivityFuture;
  }

  @override
  set fetchActivityFuture(ObservableFuture<ActivityList?> value) {
    _$fetchActivityFutureAtom.reportWrite(value, super.fetchActivityFuture, () {
      super.fetchActivityFuture = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String token) {
    return _$loginAsyncAction.run(() => super.login(token));
  }

  final _$updateProfileAsyncAction = AsyncAction('_UserStore.updateProfile');

  @override
  Future<dynamic> updateProfile(Customer customer, List<Vehicle> vehicles) {
    return _$updateProfileAsyncAction
        .run(() => super.updateProfile(customer, vehicles));
  }

  final _$getProfileAsyncAction = AsyncAction('_UserStore.getProfile');

  @override
  Future<dynamic> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  final _$getActivitiesAsyncAction = AsyncAction('_UserStore.getActivities');

  @override
  Future<dynamic> getActivities() {
    return _$getActivitiesAsyncAction.run(() => super.getActivities());
  }

  final _$getNotificationsAsyncAction =
      AsyncAction('_UserStore.getNotifications');

  @override
  Future<dynamic> getNotifications() {
    return _$getNotificationsAsyncAction.run(() => super.getNotifications());
  }

  @override
  String toString() {
    return '''
updateLoading: ${updateLoading},
success: ${success},
myinfo: ${myinfo},
customer: ${customer},
loginFuture: ${loginFuture},
fetchCustomerFuture: ${fetchCustomerFuture},
notificationList: ${notificationList},
fetchNotificationFuture: ${fetchNotificationFuture},
activityList: ${activityList},
fetchActivityFuture: ${fetchActivityFuture},
isLoading: ${isLoading},
customerLoading: ${customerLoading},
notificationLoading: ${notificationLoading},
activityLoading: ${activityLoading}
    ''';
  }
}
