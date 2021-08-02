import 'dart:async';

import 'package:boilerplate/data/network/apis/accidents/accident_api.dart';
import 'package:boilerplate/data/network/apis/services/service_api.dart';
import 'package:boilerplate/data/network/apis/warranties/warranty_api.dart';
import 'package:boilerplate/data/network/apis/motors/motor_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/accident/accident.dart';
import 'package:boilerplate/models/accident/accident_list.dart';
import 'package:boilerplate/models/accident/accident_submit.dart';
import 'package:boilerplate/models/accident/vehicle_info.dart';
import 'package:boilerplate/models/accident/vehicle_info_list.dart';
import 'package:boilerplate/models/customer/activity_list.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/document/document.dart';
import 'package:boilerplate/models/document/document_list.dart';
import 'package:boilerplate/models/message/message.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/models/motor/motor_enquiry.dart';
import 'package:boilerplate/models/motor/motor_list.dart';
import 'package:boilerplate/models/motor/motor_make_list.dart';
import 'package:boilerplate/models/motor/motor_model_list.dart';
import 'package:boilerplate/models/motor/motor_search_car.dart';
import 'package:boilerplate/models/paynow/paynow.dart';
import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/models/servicing/service_list.dart';
import 'package:boilerplate/models/servicing/service_request.dart';
import 'package:boilerplate/models/servicing/service_slot_list.dart';
import 'package:boilerplate/models/servicing/service_type_list.dart';
import 'package:boilerplate/models/vehicle/access.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/vehicle/vehicle_summary.dart';
import 'package:boilerplate/models/warranty/warranty_make_list.dart';
import 'package:boilerplate/models/warranty/warranty_model_list.dart';
import 'package:boilerplate/models/warranty/package_list.dart';
import 'package:boilerplate/models/warranty/price.dart';
import 'package:boilerplate/models/warranty/price_list.dart';
import 'package:boilerplate/models/vehicle/vehicle_list.dart';
import 'package:boilerplate/models/warranty/warranty.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:boilerplate/models/warranty/warranty_enquiry.dart';
import 'package:boilerplate/models/warranty/warranty_list.dart';
import 'package:boilerplate/models/workshop/workshop_list.dart';
import 'package:file_picker/file_picker.dart';
import 'network/apis/customers/customer_api.dart';
import 'network/apis/vehicles/vehicle_api.dart';

class Repository {
  final CustomerApi _customerApi;

  // api objects
  final VehicleApi _vehicleApi;
  final WarrantyApi _warrantyApi;
  final MotorApi _motorApi;
  final ServiceApi _serviceApi;
  final AccidentApi _accidentApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(
      this._customerApi,
      this._vehicleApi,
      this._warrantyApi,
      this._motorApi,
      this._serviceApi,
      this._accidentApi,
      this._sharedPrefsHelper);

  Future<Customer> getCustomer() async {
    return await _customerApi.getCustomer();
  }

  Future<VehicleSummary> getVehicleSummary() async {
    return await _vehicleApi.getVehicleSummary();
  }

  Future<VehicleList> getVehicles() async {
    return await _vehicleApi.getVehicles();
  }

  Future<Vehicle> getVehicle(int id) async {
    return await _vehicleApi.getVehicle(id);
  }

  Future<Access> getAccess(int id) async {
    return await _vehicleApi.getAccess(id);
  }

  Future<Message> deleteAccess(String nric, int id) async {
    return await _vehicleApi.deleteAccess(nric, id);
  }

  Future<Message> createAccess(String nric, int id) async {
    return await _vehicleApi.createAccess(nric, id);
  }

  Future<DocumentList> getVehicleWarranties(int id) async {
    return await _vehicleApi.getVehicleWarranties(id);
  }

  Future<DocumentList> getVehicleInsurances(int id) async {
    return await _vehicleApi.getVehicleInsurances(id);
  }

  Future<WarrantyMakeList> getWarrantyMakes() async {
    return await _warrantyApi.getMakes();
  }

  Future<WarrantyModelList> getWarrantyModels(String make) async {
    return await _warrantyApi.getModels(make);
  }

  Future<WarrantyPriceList> getWarrantyPrices(
      String make, String model, String type, String fuel) async {
    return await _warrantyApi.getPrices(make, model, type, fuel);
  }

  Future<WarrantyPrice> getWarrantyPrice(int id) async {
    return await _warrantyApi.getPrice(id);
  }

  Future<WarrantyList> getWarranties() async {
    return await _warrantyApi.getWarranties();
  }

  Future<WarrantyList> getPendingWarranties() async {
    return await _warrantyApi.getPendingWarranties();
  }

  Future<Warranty> getWarranty(int id) async {
    return await _warrantyApi.getWarranty(id);
  }

  Future<WarrantyPackageList> getWarrantyPackages() async {
    return await _warrantyApi.getPackages();
  }

  Future<Warranty> submitWarrantyEnquiry(WarrantyEnquiry warrantyEnquiry,
      List<String> logs, List<String> assessments) async {
    return await _warrantyApi.enquiry(warrantyEnquiry, logs, assessments);
  }

  Future<Warranty> buyWarranty(WarrantyBuy warrantyBuy, List<String> logs,
      List<String> assessments) async {
    return await _warrantyApi.buy(warrantyBuy, logs, assessments);
  }

  Future<Message> transferWarranty(int id) async {
    return await _warrantyApi.transfer(id);
  }

  Future<Message> checkoutWarranty(int id, String paymentId) async {
    return await _warrantyApi.checkout(id, paymentId);
  }

  Future<PayNow> getWarrantyPayNow(int id) async {
    return await _warrantyApi.getPayNow(id);
  }

  Future<PayNow> getMotorPayNow(int id) async {
    return await _motorApi.getPayNow(id);
  }

  Future<MotorMakeList> getMotorMakes() async {
    return await _motorApi.getMakes();
  }

  Future<MotorModelList> getMotorModels(String make) async {
    return await _motorApi.getModels(make);
  }

  Future<MotorSearchCar> motorSearchCar(String make, String model) async {
    return await _motorApi.searchCar(make, model);
  }

  Future<MotorList> getMotors() async {
    return await _motorApi.getMotors();
  }

  Future<MotorList> getPendingMotors() async {
    return await _motorApi.getPendingMotors();
  }

  Future<Motor> getMotor(int id) async {
    return await _motorApi.getMotor(id);
  }

  Future<Motor> submitMotorEnquiry(
      MotorEnquiry motorEnquiry, List<String> logs) async {
    return await _motorApi.enquiry(motorEnquiry, logs);
  }

  Future<Message> checkoutMotor(int id, String paymentId) async {
    return await _motorApi.checkout(id, paymentId);
  }

  Future<Message> transferMotor(int id) async {
    return await _motorApi.transfer(id);
  }

  Future<WorkshopList> getWorkshops() async {
    return await _serviceApi.getWorkshops();
  }

  Future<ServiceTypeList> getServiceTypes(int id) async {
    return await _serviceApi.getServiceTypes(id);
  }

  Future<Service> getService(id) async {
    return await _serviceApi.getService(id);
  }

  Future<ServiceSlotList> getServiceSlots(id) async {
    return await _serviceApi.getServiceSlots(id);
  }

  Future<ServiceList> getServices() async {
    return await _serviceApi.getServices();
  }

  Future<ServiceList> getPendingServices() async {
    return await _serviceApi.getPendingServices();
  }

  Future<ServiceList> getVehicleServices(String registration) async {
    return await _serviceApi.getVehicleServices(registration);
  }

  Future<AccidentList> getVehicleAccidents(String registration) async {
    return await _accidentApi.getVehicleAccidents(registration);
  }

  Future<Accident> getAccident(int id) async {
    return await _accidentApi.getAccident(id);
  }

  Future<Service> submitService(ServiceRequest serviceRequest) async {
    return await _serviceApi.submitService(serviceRequest);
  }

  Future<Service> rescheduleService(
      ServiceRequest serviceRequest, int id) async {
    return await _serviceApi.rescheduleService(serviceRequest, id);
  }

  Future<Service> cancelService(id) async {
    return await _serviceApi.cancelService(id);
  }

  Future<VehicleInfoList> getAccidentVehicleInfo() async {
    return await _accidentApi.getVehicleInfo();
  }

  Future<Message> submitAccident(
      AccidentSubmit accidentSubmit,
      List<String> accidentSceneFiles,
      List<String> vehicleCarPlateFiles,
      List<String> closeRangeDamageFiles,
      List<String> longRangeDamageFiles,
      List<String> otherDrivingLicenseFiles,
      List<String> otherVehicleCarPlateFiles,
      List<String> otherCloseRangeDamageFiles,
      List<String> otherLongRangeDamageFiles) async {
    return await _accidentApi.submit(
        accidentSubmit,
        accidentSceneFiles,
        vehicleCarPlateFiles,
        closeRangeDamageFiles,
        longRangeDamageFiles,
        otherDrivingLicenseFiles,
        otherVehicleCarPlateFiles,
        otherCloseRangeDamageFiles,
        otherLongRangeDamageFiles);
  }

  // Login:---------------------------------------------------------------------
  Future<void> login(String idToken, String nric, String phone) async {
    return await _customerApi.login(idToken, nric, phone).then((token) {
      _sharedPrefsHelper.saveAuthToken(token.accessToken!);
    });
  }

  Future<Message> check(String nric, String phone) =>
      _customerApi.check(nric, phone);

  Future<Message> register(String userName, String userNRIC, String userDOB,
          String userPhone, String userEmail, isCompany) =>
      _customerApi.register(
          userName, userNRIC, userDOB, userPhone, userEmail, isCompany);

  Future<Customer> updateProfile(Customer customer, List<Vehicle> vehicles) =>
      _customerApi.updateProfile(customer, vehicles);

  Future<ActivityList> getActivities() async {
    return await _customerApi.getActivities();
  }

  Future<ActivityList> getNotifications() async {
    return await _customerApi.getNotifications();
  }

  Future<void> saveToken(token) => _sharedPrefsHelper.saveAuthToken(token);

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String get currentLanguage => _sharedPrefsHelper.currentLanguage ?? "en";
}
