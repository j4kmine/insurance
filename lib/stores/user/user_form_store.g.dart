// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserFormStore on _UserFormStore, Store {
  final _$customerAtom = Atom(name: '_UserFormStore.customer');

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

  final _$vehiclesAtom = Atom(name: '_UserFormStore.vehicles');

  @override
  ObservableList<Vehicle>? get vehicles {
    _$vehiclesAtom.reportRead();
    return super.vehicles;
  }

  @override
  set vehicles(ObservableList<Vehicle>? value) {
    _$vehiclesAtom.reportWrite(value, super.vehicles, () {
      super.vehicles = value;
    });
  }

  final _$hideListAtom = Atom(name: '_UserFormStore.hideList');

  @override
  ObservableList<bool> get hideList {
    _$hideListAtom.reportRead();
    return super.hideList;
  }

  @override
  set hideList(ObservableList<bool> value) {
    _$hideListAtom.reportWrite(value, super.hideList, () {
      super.hideList = value;
    });
  }

  final _$hideVehicleListAtom = Atom(name: '_UserFormStore.hideVehicleList');

  @override
  ObservableList<bool> get hideVehicleList {
    _$hideVehicleListAtom.reportRead();
    return super.hideVehicleList;
  }

  @override
  set hideVehicleList(ObservableList<bool> value) {
    _$hideVehicleListAtom.reportWrite(value, super.hideVehicleList, () {
      super.hideVehicleList = value;
    });
  }

  @override
  String toString() {
    return '''
customer: ${customer},
vehicles: ${vehicles},
hideList: ${hideList},
hideVehicleList: ${hideVehicleList}
    ''';
  }
}

mixin _$UserFormErrorStore on _UserFormErrorStore, Store {
  @override
  String toString() {
    return '''

    ''';
  }
}
