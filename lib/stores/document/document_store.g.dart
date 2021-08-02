// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DocumentStore on _DocumentStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_DocumentStore.loading'))
      .value;

  final _$fetchVehicleDocumentsFutureAtom =
      Atom(name: '_DocumentStore.fetchVehicleDocumentsFuture');

  @override
  ObservableFuture<DocumentList?> get fetchVehicleDocumentsFuture {
    _$fetchVehicleDocumentsFutureAtom.reportRead();
    return super.fetchVehicleDocumentsFuture;
  }

  @override
  set fetchVehicleDocumentsFuture(ObservableFuture<DocumentList?> value) {
    _$fetchVehicleDocumentsFutureAtom
        .reportWrite(value, super.fetchVehicleDocumentsFuture, () {
      super.fetchVehicleDocumentsFuture = value;
    });
  }

  final _$documentListAtom = Atom(name: '_DocumentStore.documentList');

  @override
  DocumentList? get documentList {
    _$documentListAtom.reportRead();
    return super.documentList;
  }

  @override
  set documentList(DocumentList? value) {
    _$documentListAtom.reportWrite(value, super.documentList, () {
      super.documentList = value;
    });
  }

  final _$successAtom = Atom(name: '_DocumentStore.success');

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

  final _$getVehicleInsuranceAsyncAction =
      AsyncAction('_DocumentStore.getVehicleInsurance');

  @override
  Future<dynamic> getVehicleInsurance(int id) {
    return _$getVehicleInsuranceAsyncAction
        .run(() => super.getVehicleInsurance(id));
  }

  final _$getVehicleWarrantyAsyncAction =
      AsyncAction('_DocumentStore.getVehicleWarranty');

  @override
  Future<dynamic> getVehicleWarranty(int id) {
    return _$getVehicleWarrantyAsyncAction
        .run(() => super.getVehicleWarranty(id));
  }

  @override
  String toString() {
    return '''
fetchVehicleDocumentsFuture: ${fetchVehicleDocumentsFuture},
documentList: ${documentList},
success: ${success},
loading: ${loading}
    ''';
  }
}
