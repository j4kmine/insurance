import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/document/document_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'document_store.g.dart';

class DocumentStore = _DocumentStore with _$DocumentStore;

abstract class _DocumentStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _DocumentStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<DocumentList?> emptyVehicleDocumentsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<DocumentList?> fetchVehicleDocumentsFuture =
      ObservableFuture<DocumentList?>(emptyVehicleDocumentsResponse);

  @observable
  DocumentList? documentList;

  @observable
  bool success = false;

  @computed
  bool get loading =>
      fetchVehicleDocumentsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getVehicleInsurance(int id) async {
    final future = _repository.getVehicleInsurances(id);
    fetchVehicleDocumentsFuture = ObservableFuture(future);

    future.then((details) {
      this.documentList = details;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getVehicleWarranty(int id) async {
    final future = _repository.getVehicleWarranties(id);
    fetchVehicleDocumentsFuture = ObservableFuture(future);

    future.then((details) {
      this.documentList = details;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
