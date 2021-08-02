import 'package:boilerplate/stores/error/error_store.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';

part 'accident_form_store.g.dart';

class AccidentFormStore = _AccidentFormStore with _$AccidentFormStore;

abstract class _AccidentFormStore with Store {
  // store for handling accident errors
  final AccidentFormErrorStore accidentFormErrorStore =
      AccidentFormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _AccidentFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupValidations() {
    _disposers = [
      // reaction((_) => vehicleNo, validateVehicleNo)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  int step = 1;

  @observable
  String vehicleId = "";

  @observable
  String carMake = "";

  @observable
  String carModel = "";

  @observable
  String insuranceCompany = "";

  @observable
  String certificateNumber = "";

  @observable
  String insuredNric = "";

  @observable
  String insuredName = "";

  @observable
  String insuredContactNumber = "";

  @observable
  String date = "";

  @observable
  String time = "";

  @observable
  String location = "";

  @observable
  String weather = "";

  @observable
  String reporting = "";

  @observable
  String numOfPassenger = "";

  @observable
  String videoByCamera = "";

  @observable
  String relationship = "";

  @observable
  String purpose = "";

  @observable
  String details = "";

  @observable
  String vehicleDrivenByOwner = "";

  @observable
  String driverName = "";

  @observable
  String driverNric = "";

  @observable
  String driverDob = "";

  @observable
  String driverLicense = "";

  @observable
  String driverAddress = "";

  @observable
  String driverContactNo = "";

  @observable
  String driverEmail = "";

  @observable
  String driverOccupation = "";

  @observable
  String otherVehicle = "";

  @observable
  String otherVehicleCarPlate = "";

  @observable
  String otherVehicleMake = "";

  @observable
  String otherVehicleModel = "";

  @observable
  String otherDriverName = "";

  @observable
  String otherDriverNRIC = "";

  @observable
  String otherDriverContactNo = "";

  @observable
  String otherDriverAddress = "";

  @observable
  String workshopId = "";

  @observable
  String appointmentDate = "";

  @observable
  String appointmentTime = "";

  void dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}

class AccidentFormErrorStore = _AccidentFormErrorStore
    with _$AccidentFormErrorStore;

abstract class _AccidentFormErrorStore with Store {}
