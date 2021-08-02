import 'dart:collection';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/accident/accident_submit.dart';
import 'package:boilerplate/stores/accident/accident_form_store.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_form_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/accident/accident_files.dart';
import 'package:boilerplate/ui/accident/accident_status.dart';
import 'package:boilerplate/ui/warranty/warranty_buy.dart';
import 'package:boilerplate/ui/warranty/warranty_checkout.dart';
import 'package:boilerplate/ui/warranty/warranty_enquiry.dart';
import 'package:boilerplate/ui/warranty/warranty_prices.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/date_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/photo_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:boilerplate/widgets/step_widget.dart';
import 'package:boilerplate/widgets/time_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  //stores:---------------------------------------------------------------------
  AccidentFormStore _accidentFormStore = AccidentFormStore();
  AccidentStore? _accidentStore;
  ServicingStore? _servicingStore;

  //stores:---------------------------------------------------------------------
  TextEditingController _carMakeController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  TextEditingController _insuranceController = TextEditingController();
  TextEditingController _policyController = TextEditingController();
  TextEditingController _nricController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _contactNoController = TextEditingController();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _numOfPassengerController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

  TextEditingController _driverNameController = TextEditingController();
  TextEditingController _driverNricController = TextEditingController();
  TextEditingController _driverDobController = TextEditingController();
  TextEditingController _driverLicenseController = TextEditingController();
  TextEditingController _driverAddressController = TextEditingController();
  TextEditingController _driverContactNoController = TextEditingController();
  TextEditingController _driverEmailController = TextEditingController();

  TextEditingController _otherVehicleNoController = TextEditingController();
  TextEditingController _otherCarMakeController = TextEditingController();
  TextEditingController _otherCarModelController = TextEditingController();
  TextEditingController _otherDriverNameController = TextEditingController();
  TextEditingController _otherDriverNricController = TextEditingController();
  TextEditingController _otherDriverAddressController = TextEditingController();
  TextEditingController _otherDriverContactNoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _accidentStore = Provider.of<AccidentStore>(context);
    _servicingStore = Provider.of<ServicingStore>(context);

    if (!_accidentStore!.vehicleInfoListLoading) {
      _accidentStore!.getVehicles();
    }

    if (!_servicingStore!.workshopsLoading) {
      _servicingStore!.getWorkshops();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'vehicle_info'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _accidentStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildNextButton());
  }

  Widget _buildMainContent() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Observer(
          builder: (context) {
            return Column(
              children: [
                StepWidget(
                    number: _accidentFormStore.step,
                    accidentFormStore: _accidentFormStore),
                SizedBox(height: 20),
                _buildVehicle(),
              ],
            );
          },
        ));
  }

  Widget _buildVehicle() {
    if (_accidentStore!.vehicleInfoListLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return Column(
        children: [
          _accidentFormStore.step == 1 ? _buildVehicleNo() : Container(),
          _accidentFormStore.step == 1 && _accidentFormStore.vehicleId != ''
              ? _buildVehicleInfo()
              : Container(),
          _accidentFormStore.step == 2 ? _buildAccidentInfo() : Container(),
          _accidentFormStore.step == 3 ? _buildVehicleByOwner() : Container(),
          _accidentFormStore.step == 3 &&
                  _accidentFormStore.vehicleDrivenByOwner == 'no'
              ? _buildDriverInfo()
              : Container(),
          _accidentFormStore.step == 3 ? _buildOtherVehicle() : Container(),
          _accidentFormStore.step == 3 &&
                  _accidentFormStore.otherVehicle == 'yes'
              ? _buildOtherVehicleInfo()
              : Container(),
          _accidentFormStore.step == 4 ? _buildAccidentPhotos() : Container(),
          _accidentFormStore.step == 5 ? _buildWorkshopPage() : Container(),
          _accidentStore!.submitSuccess ? _navigate() : Container()
        ],
      );
    }
  }

  Widget _buildVehicleInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _buildCarMake(),
      SizedBox(height: 10),
      _buildCarModel(),
      SizedBox(height: 10),
      _buildInsurance(),
      SizedBox(height: 10),
      _buildPolicy(),
      SizedBox(height: 10),
      _buildNRIC(),
      SizedBox(height: 10),
      _buildName(),
      SizedBox(height: 10),
      _buildContactNo(),
    ]);
  }

  Widget _buildVehicleNo() {
    List<String> options = [''];
    Map<String, int> values = new HashMap();
    if (_accidentStore!.vehicleInfoList != null) {
      for (var i = 0;
          i < _accidentStore!.vehicleInfoList!.vehicleInfo!.length;
          i++) {
        String option =
            _accidentStore!.vehicleInfoList!.vehicleInfo![i].registrationNo!;
        options.add(option);
        values[option] =
            _accidentStore!.vehicleInfoList!.vehicleInfo![i].vehicleId!;
      }
    }
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('vehicle_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: options,
      values: values,
      value: _accidentFormStore.vehicleId,
      onChanged: (value) {
        _accidentFormStore.vehicleId = value;
        if (value != null && value != '') {
          if (_accidentStore!.vehicleInfoList != null) {
            for (int i = 0;
                i < _accidentStore!.vehicleInfoList!.vehicleInfo!.length;
                i++) {
              if (_accidentStore!.vehicleInfoList!.vehicleInfo![i].vehicleId
                      .toString() ==
                  value) {
                _accidentFormStore.carModel = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].vehicleModel ??
                    "";
                _accidentFormStore.carMake = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].vehicleMake ??
                    "";
                _accidentFormStore.insuranceCompany = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuranceCompany ??
                    "";
                _accidentFormStore.certificateNumber = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].certificateNumber ??
                    "";
                _accidentFormStore.insuredNric = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuredNric ??
                    "";
                _accidentFormStore.insuredName = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuredName ??
                    "";
                _accidentFormStore.insuredContactNumber = _accidentStore!
                        .vehicleInfoList!
                        .vehicleInfo![i]
                        .insuredContactNumber ??
                    "";

                _carModelController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].vehicleModel ??
                    "";
                _carMakeController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].vehicleMake ??
                    "";
                _insuranceController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuranceCompany ??
                    "";
                _policyController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].certificateNumber ??
                    "";
                _nricController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuredNric ??
                    "";
                _nameController.text = _accidentStore!
                        .vehicleInfoList!.vehicleInfo![i].insuredName ??
                    "";
                _contactNoController.text = _accidentStore!.vehicleInfoList!
                        .vehicleInfo![i].insuredContactNumber ??
                    "";

                break;
              }
            }
          }
        } else {
          _accidentFormStore.carModel = "";
          _accidentFormStore.carMake = "";
          _carModelController.text = "";
          _carMakeController.text = "";
          _insuranceController.text = "";
          _policyController.text = "";
          _nricController.text = "";
          _nameController.text = "";
          _contactNoController.text = "";
        }
      },
    );
  }

  Widget _buildCarMake() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('car_make'),
        hint: AppLocalizations.of(context)!.translate('enter_car_make'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _carMakeController);
  }

  Widget _buildCarModel() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('car_model'),
        hint: AppLocalizations.of(context)!.translate('enter_car_model'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _carModelController);
  }

  Widget _buildInsurance() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('insurance_company'),
        hint: AppLocalizations.of(context)!.translate('insurance_company'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _insuranceController);
  }

  Widget _buildPolicy() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('policy_certificate_no'),
        hint: AppLocalizations.of(context)!.translate('policy_certificate_no'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _policyController);
  }

  Widget _buildNRIC() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('insured_nric'),
        hint: AppLocalizations.of(context)!.translate('insured_nric'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _nricController);
  }

  Widget _buildName() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('insured_name'),
        hint: AppLocalizations.of(context)!.translate('insured_name'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _nameController);
  }

  Widget _buildContactNo() {
    return SecondaryTextFieldWidget(
        enabled: false,
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('insured_contact_number'),
        hint: AppLocalizations.of(context)!.translate('insured_contact_number'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _contactNoController);
  }

  Widget _buildAccidentInfo() {
    return Column(children: [
      _buildDateOfAccident(),
      SizedBox(height: 10),
      _buildTimeOfAccident(),
      SizedBox(height: 10),
      _buildLocationOfAccident(),
      SizedBox(height: 10),
      _buildWeather(),
      SizedBox(height: 10),
      _buildReportingType(),
      SizedBox(height: 10),
      _buildNoOfPassengers(),
      SizedBox(height: 10),
      _buildCarCamera(),
      SizedBox(height: 10),
      _buildPurpose(),
      SizedBox(height: 10),
      _buildDetails()
    ]);
  }

  Widget _buildDriverInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _buildRelationship(),
      SizedBox(height: 10),
      _buildDriverName(),
      SizedBox(height: 10),
      _buildDriverNric(),
      SizedBox(height: 10),
      _buildDriverDob(),
      SizedBox(height: 10),
      _buildDriverLicense(),
      SizedBox(height: 10),
      _buildDriverAddress(),
      SizedBox(height: 10),
      _buildDriverContactNo(),
      SizedBox(height: 10),
      _buildDriverEmail(),
      SizedBox(height: 10),
      _buildDriverOccupation(),
    ]);
  }

  Widget _buildDateOfAccident() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('date_of_accident'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _dateController,
        onChanged: (value) {
          _accidentFormStore.date = value;
        },
        selectedDate: _accidentFormStore.date == ''
            ? null
            : DateFormat(Strings.dateFormat).parse(_accidentFormStore.date));
  }

  Widget _buildTimeOfAccident() {
    return TimeWidget(
        text: AppLocalizations.of(context)!.translate('time_of_accident'),
        hint: Strings.timeFormat,
        inputAction: TextInputAction.next,
        textController: _timeController,
        onChanged: (value) {
          print(value);
          _accidentFormStore.time = value;
        },
        selectedTime: _accidentFormStore.time == ''
            ? TimeOfDay.now()
            : TimeOfDay(
                hour: int.parse(_accidentFormStore.time.split(":")[0]),
                minute: int.parse(_accidentFormStore.time.split(":")[1])));
  }

  Widget _buildLocationOfAccident() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('location_of_accident'),
      hint:
          AppLocalizations.of(context)!.translate('enter_location_of_accident'),
      inputType: TextInputType.multiline,
      inputAction: TextInputAction.next,
      textController: _locationController,
      onChanged: (value) {
        _accidentFormStore.location = value;
      },
    );
  }

  Widget _buildWeather() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('weather_road_surface'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.weatherOptions,
        value: _accidentFormStore.weather,
        onChanged: (value) {
          _accidentFormStore.weather = value;
        });
  }

  Widget _buildReportingType() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('reporting_type'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.reportingOptions,
        value: _accidentFormStore.reporting,
        onChanged: (value) {
          _accidentFormStore.reporting = value;
        });
  }

  Widget _buildNoOfPassengers() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('number_of_passengers'),
      hint:
          AppLocalizations.of(context)!.translate('enter_number_of_passengers'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _numOfPassengerController,
      onChanged: (value) {
        _accidentFormStore.numOfPassenger = value;
      },
    );
  }

  Widget _buildCarCamera() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('video_captured'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.yesNoOptions,
        value: _accidentFormStore.videoByCamera,
        onChanged: (value) {
          _accidentFormStore.videoByCamera = value;
        });
  }

  Widget _buildPurpose() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('purpose_vehicle_used'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.purposeOptions,
        value: _accidentFormStore.purpose,
        onChanged: (value) {
          _accidentFormStore.purpose = value;
        });
  }

  Widget _buildDetails() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('details'),
      hint: AppLocalizations.of(context)!.translate('enter_details'),
      inputType: TextInputType.multiline,
      inputAction: TextInputAction.next,
      textController: _detailsController,
      onChanged: (value) {
        _accidentFormStore.details = value;
      },
    );
  }

  Widget _buildVehicleByOwner() {
    return SecondaryDropDownWidget(
        text:
            AppLocalizations.of(context)!.translate('vehicle_driven_by_owner'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.yesNoOptions,
        value: _accidentFormStore.vehicleDrivenByOwner,
        onChanged: (value) {
          print(value);
          _accidentFormStore.vehicleDrivenByOwner = value;
        });
  }

  Widget _buildRelationship() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!
            .translate('relationship_of_owner_driver'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.relationshipOptions,
        value: _accidentFormStore.relationship,
        onChanged: (value) {
          _accidentFormStore.relationship = value;
        });
  }

  Widget _buildDriverName() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('driver_name'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('driver_name'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _driverNameController,
      onChanged: (value) {
        _accidentFormStore.driverName = value;
      },
    );
  }

  Widget _buildDriverNric() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      text: AppLocalizations.of(context)!.translate('driver_nric_uen'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('driver_nric_uen'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _driverNricController,
      onChanged: (value) {
        _accidentFormStore.driverNric = value;
      },
    );
  }

  Widget _buildDriverDob() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('driver_dob'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _driverDobController,
        onChanged: (value) {
          _accidentFormStore.driverDob = value;
        },
        selectedDate: _accidentFormStore.driverDob == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_accidentFormStore.driverDob));
  }

  Widget _buildDriverLicense() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('driver_license'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _driverLicenseController,
        onChanged: (value) {
          _accidentFormStore.driverLicense = value;
        },
        selectedDate: _accidentFormStore.driverLicense == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_accidentFormStore.driverDob));
  }

  Widget _buildDriverAddress() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('driver_address'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('driver_address'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _driverAddressController,
      onChanged: (value) {
        _accidentFormStore.driverAddress = value;
      },
    );
  }

  Widget _buildDriverContactNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('driver_contact_no') +
          " (+65)",
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('driver_contact_no'),
      inputType: TextInputType.phone,
      inputAction: TextInputAction.next,
      textController: _driverContactNoController,
      onChanged: (value) {
        _accidentFormStore.driverContactNo = value;
      },
    );
  }

  Widget _buildDriverEmail() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('driver_email_address'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('driver_email_address'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _driverEmailController,
      onChanged: (value) {
        _accidentFormStore.driverEmail = value;
      },
    );
  }

  Widget _buildDriverOccupation() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('driver_occupation'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.occupationTypeOptions,
        value: _accidentFormStore.driverOccupation,
        onChanged: (value) {
          _accidentFormStore.driverOccupation = value;
        });
  }

  Widget _buildOtherVehicle() {
    return Column(
      children: [
        SizedBox(height: 10),
        SecondaryDropDownWidget(
            text: AppLocalizations.of(context)!.translate('another_vehicle'),
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            options: Strings.yesNoOptions,
            value: _accidentFormStore.otherVehicle,
            onChanged: (value) {
              _accidentFormStore.otherVehicle = value;
            }),
      ],
    );
  }

  Widget _buildOtherVehicleInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _buildOtherVehicleCarPlate(),
      SizedBox(height: 10),
      _buildOtherVehicleMake(),
      SizedBox(height: 10),
      _buildOtherVehicleModel(),
      SizedBox(height: 10),
      _buildOtherDriverName(),
      SizedBox(height: 10),
      _buildOtherDriverNric(),
      SizedBox(height: 10),
      _buildOtherDriverContactNo(),
      SizedBox(height: 10),
      _buildOtherDriverAddress(),
    ]);
  }

  Widget _buildOtherVehicleCarPlate() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      text:
          AppLocalizations.of(context)!.translate('other_vehicle_car_plate_no'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_vehicle_car_plate_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherVehicleNoController,
      onChanged: (value) {
        _accidentFormStore.otherVehicleCarPlate = value;
      },
    );
  }

  Widget _buildOtherVehicleMake() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      text: AppLocalizations.of(context)!.translate('other_vehicle_make'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_vehicle_make'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherCarMakeController,
      onChanged: (value) {
        _accidentFormStore.otherVehicleMake = value;
      },
    );
  }

  Widget _buildOtherVehicleModel() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('other_vehicle_model'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_vehicle_model'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherCarModelController,
      onChanged: (value) {
        _accidentFormStore.otherVehicleModel = value;
      },
    );
  }

  Widget _buildOtherDriverName() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('other_driver_name'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_driver_name'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherDriverNameController,
      onChanged: (value) {
        _accidentFormStore.otherDriverName = value;
      },
    );
  }

  Widget _buildOtherDriverNric() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      text: AppLocalizations.of(context)!.translate('other_driver_nric'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_driver_nric'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherDriverNricController,
      onChanged: (value) {
        _accidentFormStore.otherDriverNRIC = value;
      },
    );
  }

  Widget _buildOtherDriverContactNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('other_driver_contact_no') +
          " (+65)",
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_driver_contact_no'),
      inputType: TextInputType.phone,
      inputAction: TextInputAction.next,
      textController: _otherDriverContactNoController,
      onChanged: (value) {
        _accidentFormStore.otherDriverContactNo = value;
      },
    );
  }

  Widget _buildOtherDriverAddress() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('other_driver_address'),
      hint: AppLocalizations.of(context)!.translate('enter') +
          " " +
          AppLocalizations.of(context)!.translate('other_driver_address'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _otherDriverAddressController,
      onChanged: (value) {
        _accidentFormStore.otherDriverAddress = value;
      },
    );
  }

  Widget _buildAccidentPhotos() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildPhotoWidget(
          "accident_scene", 0, _accidentStore!.accidentSceneFiles.length),
      SizedBox(height: 20),
      Text(AppLocalizations.of(context)!.translate("own_vehicle"),
          style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      _buildPhotoWidget(
          "vehicle_car_plate", 1, _accidentStore!.vehicleCarPlateFiles.length),
      SizedBox(height: 10),
      _buildPhotoWidget("close_range_damage", 2,
          _accidentStore!.closeRangeDamageFiles.length),
      SizedBox(height: 10),
      _buildPhotoWidget(
          "long_range_damage", 3, _accidentStore!.longRangeDamageFiles.length),
      SizedBox(height: 20),
      Text(AppLocalizations.of(context)!.translate("the_other_vehicle"),
          style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      _buildPhotoWidget("driving_license", 4,
          _accidentStore!.otherDrivingLicenseFiles.length),
      SizedBox(height: 10),
      _buildPhotoWidget("vehicle_car_plate", 5,
          _accidentStore!.otherVehicleCarPlateFiles.length),
      SizedBox(height: 10),
      _buildPhotoWidget("close_range_damage", 6,
          _accidentStore!.otherCloseRangeDamageFiles.length),
      SizedBox(height: 10),
      _buildPhotoWidget("long_range_damage", 7,
          _accidentStore!.otherLongRangeDamageFiles.length)
    ]);
  }

  Widget _buildPhotoWidget(String title, int index, int length) {
    return InkWell(
      onTap: () {
        _accidentStore!.fileIndex = index;
        _accidentStore!.photoTitle = title;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AccidentFilesScreen()));
      },
      child: PhotoWidget(
          title: AppLocalizations.of(context)!.translate(title),
          count: length.toString()),
    );
  }

  Widget _buildWorkshopPage() {
    return Column(
      children: [
        _buildWorkshop(),
        _accidentFormStore.workshopId != ''
            ? _buildDateOfAppointment()
            : Container(),
        _accidentFormStore.appointmentDate != ''
            ? _buildTimeOfAppointment()
            : Container(),
      ],
    );
  }

  Widget _buildWorkshop() {
    if (!_servicingStore!.workshopsLoading) {
      List<String> options = [''];
      Map<String, int> values = new HashMap();
      if (_servicingStore!.workshopList != null) {
        for (var i = 0;
            i < _servicingStore!.workshopList!.workshops!.length;
            i++) {
          String option = _servicingStore!.workshopList!.workshops![i].name!;
          options.add(option);
          values[option] = _servicingStore!.workshopList!.workshops![i].id!;
        }
      }
      return SecondaryDropDownWidget(
          text: AppLocalizations.of(context)!.translate('workshop'),
          inputType: TextInputType.text,
          inputAction: TextInputAction.next,
          options: options,
          values: values,
          value: _accidentFormStore.workshopId,
          onChanged: (value) {
            _accidentFormStore.workshopId = value;
            _accidentFormStore.appointmentDate = '';
          });
    } else {
      return Container();
    }
  }

  Widget _buildDateOfAppointment() {
    return Column(
      children: [
        SizedBox(height: 10),
        DateWidget(
            text: AppLocalizations.of(context)!.translate('date'),
            hint: Strings.dateFormat,
            inputAction: TextInputAction.next,
            textController: _dateController,
            onChanged: (value) {
              _accidentFormStore.appointmentDate = value;
              _accidentFormStore.appointmentTime = '';
              _servicingStore!
                  .getServiceSlots(int.parse(_accidentFormStore.workshopId));
            },
            selectedDate: _accidentFormStore.appointmentDate == ''
                ? null
                : DateFormat(Strings.dateFormat)
                    .parse(_accidentFormStore.appointmentDate)),
      ],
    );
  }

  Widget _buildTimeOfAppointment() {
    if (_servicingStore!.serviceSlotsLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      List<String> options = [''];
      Map<String, String> values = new HashMap();
      for (var i = 0;
          i < _servicingStore!.serviceSlotList!.serviceSlots!.length;
          i++) {
        if (DateFormat(Strings.dateFormat)
                .parse(_accidentFormStore.appointmentDate)
                .weekday ==
            Strings.dayOptions[
                _servicingStore!.serviceSlotList!.serviceSlots![i].day]) {
          DateTime option = DateTime.parse("2000-01-01T" +
              _servicingStore!.serviceSlotList!.serviceSlots![i].timeStart! +
              ":00");
          options.add(DateFormat("hh:mm a").format(option));
          values[DateFormat("hh:mm a").format(option)] =
              DateFormat("HH:mm").format(option);
        }
      }

      return values.length == 0
          ? Column(
              children: [
                SizedBox(height: 20),
                Text(AppLocalizations.of(context)!.translate("no_time_slot")),
                SizedBox(height: 10)
              ],
            )
          : Column(
              children: [
                SizedBox(height: 10),
                SecondaryDropDownWidget(
                    text: AppLocalizations.of(context)!.translate('time'),
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    options: options,
                    values: values,
                    value: _accidentFormStore.appointmentTime,
                    onChanged: (value) {
                      _accidentFormStore.appointmentTime = value;
                    }),
              ],
            );
    }
  }

  Widget _buildNextButton() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 45,
              child: RoundedButtonWidget(
                  loading: _accidentStore!.submitLoading,
                  buttonColor: _accidentFormStore.step == 5
                      ? AppColors.successColor
                      : AppColors.secondaryColor,
                  buttonText: _accidentFormStore.step == 5
                      ? AppLocalizations.of(context)!.translate('submit')
                      : AppLocalizations.of(context)!.translate('next'),
                  enabled: !(_accidentFormStore.step == 5 &&
                          _accidentFormStore.appointmentTime == '') ||
                      !(_accidentStore!.submitLoading),
                  textColor: Colors.white,
                  onPressed: () {
                    if (_accidentFormStore.step == 5) {
                      DeviceUtils.hideKeyboard(context);
                      AccidentSubmit accidentSubmit = AccidentSubmit(
                          vehicleId: _accidentFormStore.vehicleId,
                          vehicleMake: _accidentFormStore.carMake,
                          vehicleModel: _accidentFormStore.carModel,
                          insuranceCompany: _accidentFormStore.insuranceCompany,
                          certificateNumber:
                              _accidentFormStore.certificateNumber,
                          insuredNric: _accidentFormStore.insuredNric,
                          insuredName: _accidentFormStore.insuredName,
                          insuredContactNumber:
                              _accidentFormStore.insuredContactNumber,
                          dateOfAccident: _accidentFormStore.date,
                          timeOfAccident: _accidentFormStore.time,
                          locationOfAccident: _accidentFormStore.location,
                          weatherRoadCondition: _accidentFormStore.weather,
                          reportingType: _accidentFormStore.reporting,
                          numberOfPassengers: _accidentFormStore.numOfPassenger,
                          isVideoCaptured: _accidentFormStore.videoByCamera,
                          purposeOfUse: _accidentFormStore.purpose,
                          isOwnerDrives:
                              _accidentFormStore.vehicleDrivenByOwner,
                          ownerDriverRelationship:
                              _accidentFormStore.relationship,
                          driverName: _accidentFormStore.driverName,
                          driverNric: _accidentFormStore.driverNric,
                          driverDob: _accidentFormStore.driverDob,
                          driverLicense: _accidentFormStore.driverLicense,
                          driverAddress: _accidentFormStore.driverAddress,
                          driverContactNo: _accidentFormStore.driverContactNo,
                          driverEmail: _accidentFormStore.driverEmail,
                          driverOccupation: _accidentFormStore.driverOccupation,
                          otherVehicle: _accidentFormStore.otherVehicle,
                          otherVehicleCarPlate:
                              _accidentFormStore.otherVehicleCarPlate,
                          otherVehicleMake: _accidentFormStore.otherVehicleMake,
                          otherVehicleModel:
                              _accidentFormStore.otherVehicleModel,
                          otherDriverName: _accidentFormStore.otherDriverName,
                          otherDriverNric: _accidentFormStore.otherDriverNRIC,
                          otherDriverContactNo:
                              _accidentFormStore.otherDriverContactNo,
                          otherDriverAddress:
                              _accidentFormStore.otherDriverAddress,
                          isVisitingWorkshop: '',
                          workshopId: _accidentFormStore.workshopId,
                          workshopVisitDate: _accidentFormStore.appointmentDate,
                          workshopVisitTime: _accidentFormStore.appointmentTime,
                          details: _accidentFormStore.details);
                      _accidentStore!.submit(accidentSubmit);
                    } else {
                      _accidentFormStore.step += 1;
                    }
                  }),
            ),
          ],
        ),
      );
    });
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _accidentStore!.submitSuccess = false;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AccidentStatusScreen()));
    });

    return Container();
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context)!.translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _carMakeController.dispose();
    _carModelController.dispose();
    _insuranceController.dispose();
    _policyController.dispose();
    _nricController.dispose();
    _nameController.dispose();
    _contactNoController.dispose();
    super.dispose();
  }
}
