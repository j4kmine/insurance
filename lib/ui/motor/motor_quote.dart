import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/driver/driver.dart';
import 'package:boilerplate/models/motor/motor_enquiry.dart';
import 'package:boilerplate/stores/motor/motor_form_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/motor/motor_detail.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/date_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/file_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:boilerplate/widgets/switch_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MotorQuoteScreen extends StatefulWidget {
  @override
  _MotorQuoteScreenState createState() => _MotorQuoteScreenState();
}

class _MotorQuoteScreenState extends State<MotorQuoteScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;
  VehicleStore? _vehicleStore;
  final picker = ImagePicker();

  //stores:---------------------------------------------------------------------
  MotorFormStore _motorFormStore = MotorFormStore();
  TextEditingController _vehicleNoController = TextEditingController();
  TextEditingController _carMakeController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  TextEditingController _bodyTypeController = TextEditingController();
  TextEditingController _engineCapacityController = TextEditingController();
  TextEditingController _chassisNoController = TextEditingController();
  TextEditingController _engineNoController = TextEditingController();
  TextEditingController _seatingCapacityController = TextEditingController();
  TextEditingController _manufactureYearController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _accidentController = TextEditingController();
  TextEditingController _totalClaimController = TextEditingController();

  TextEditingController _driverNRICOneController = TextEditingController();
  TextEditingController _driverNameOneController = TextEditingController();
  TextEditingController _driverDOBOneController = TextEditingController();
  TextEditingController _driverDOLOneController = TextEditingController();
  TextEditingController _driverAccidentOneController = TextEditingController();
  TextEditingController _driverClaimOneController = TextEditingController();

  TextEditingController _driverNRICTwoController = TextEditingController();
  TextEditingController _driverNameTwoController = TextEditingController();
  TextEditingController _driverDOBTwoController = TextEditingController();
  TextEditingController _driverDOLTwoController = TextEditingController();
  TextEditingController _driverAccidentTwoController = TextEditingController();
  TextEditingController _driverClaimTwoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _motorStore = Provider.of<MotorStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);
    if (!_motorStore!.makesLoading && _motorStore!.makeList == null) {
      _motorStore!.getMakes();
    }
    if (!_vehicleStore!.vehiclesLoading && _vehicleStore!.vehicles == null) {
      _vehicleStore!.getVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'get_insurance_quote'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildMotorQuote());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildVehicle();
      },
    );
  }

  Widget _buildVehicle() {
    if (_vehicleStore!.vehiclesLoading || _motorStore!.makesLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            _buildType(),
            _motorFormStore.type != '' ? _buildInfo() : Container()
          ],
        ),
      );
    }
  }

  Widget _buildInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _motorFormStore.type == 'preowned' ? _buildVehicleNo() : Container(),
      _motorFormStore.type == 'preowned' ? SizedBox(height: 10) : Container(),
      _buildCarMake(),
      SizedBox(height: 10),
      _motorStore!.modelsLoading ? Container() : _buildCarModel(),
      _motorStore!.searchCarLoading || _motorStore!.modelsLoading
          ? Container()
          : _buildExtraInfo(),
      _motorStore!.searchCarLoading || _motorStore!.modelsLoading
          ? MiniProgressIndicatorWidget()
          : Container(),
      _motorStore!.enquirySuccess ? _navigate() : Container()
    ]);
  }

  Widget _buildExtraInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _buildBodyType(),
      SizedBox(height: 10),
      _buildEngineCapacity(),
      SizedBox(height: 10),
      _buildChassisNo(),
      SizedBox(height: 10),
      _buildEngineNo(),
      SizedBox(height: 10),
      _buildSeatingCapacity(),
      SizedBox(height: 10),
      _buildManufactureYear(),
      SizedBox(height: 10),
      _buildUsage(),
      SizedBox(height: 10),
      _buildOPC(),
      SizedBox(height: 10),
      _buildModified(),
      SizedBox(height: 10),
      _buildNoOfAccident(),
      SizedBox(height: 10),
      _buildTotalClaim(),
      SizedBox(height: 10),
      _buildDriverNCD(),
      SizedBox(height: 10),
      _buildQuestionOne(),
      SizedBox(height: 10),
      _buildQuestionTwo(),
      SizedBox(height: 10),
      _buildQuestionThree(),
      SizedBox(height: 10),
      _buildQuestionFour(),
      SizedBox(height: 10),
      _buildInsuranceStartDate(),
      SizedBox(height: 10),
      _buildInsuranceExpiryDate(),
      SizedBox(height: 10),
      _buildNamedDriverOne(),
      _motorFormStore.driverOne ? SizedBox(height: 10) : Container(),
      _motorFormStore.driverOne ? _buildNamedDriverTwo() : Container(),
      _motorFormStore.type == 'preowned'
          ? Column(
              children: [
                SizedBox(height: 20),
                FileWidget(
                    files: _motorFormStore.logCards,
                    title: AppLocalizations.of(context)!
                        .translate('upload_log_card'),
                    onRemoved: (index) async {
                      List<String> fp = _motorFormStore.logCards;
                      fp.removeAt(index);
                      _motorFormStore.logCards = fp;
                    },
                    onCamera: () async {
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      List<String> fp = _motorFormStore.logCards;
                      fp.add(pickedFile!.path);
                      _motorFormStore.logCards = fp;
                    },
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);
                      List<String> fp = _motorFormStore.logCards;
                      for (var i = 0; i < result!.paths.length; i++) {
                        fp.add(result.paths[i]!);
                      }
                      _motorFormStore.logCards = fp;
                    }),
              ],
            )
          : Container(),
    ]);
  }

  Widget _buildType() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('preowned_or_new'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.typeOptions,
      value: _motorFormStore.type,
      onChanged: (value) {
        _motorFormStore.type = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.type,
    );
  }

  Widget _buildVehicleNo() {
    List<String> suggestions = [];
    if (_vehicleStore!.vehicles != null) {
      for (int i = 0; i < _vehicleStore!.vehicles!.vehicles!.length; i++) {
        suggestions
            .add(_vehicleStore!.vehicles!.vehicles![i].registrationNo ?? "");
      }
    }
    return TypeFormWidget(
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('vehicle_no'),
        hint: AppLocalizations.of(context)!.translate('enter_vehicle_no'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _vehicleNoController,
        suggestions: suggestions,
        onChanged: (value) {
          _motorFormStore.vehicleNo = value;
        },
        onSubmit: (value) {
          _motorFormStore.vehicleNo = value;
          if (_vehicleStore!.vehicles != null) {
            for (int i = 0;
                i < _vehicleStore!.vehicles!.vehicles!.length;
                i++) {
              if (_vehicleStore!.vehicles!.vehicles![i].registrationNo ==
                  value) {
                _motorFormStore.carMake =
                    _vehicleStore!.vehicles!.vehicles![i].make!;
                _motorFormStore.carModel =
                    _vehicleStore!.vehicles!.vehicles![i].model!;
                _motorFormStore.chassisNo =
                    _vehicleStore!.vehicles!.vehicles![i].chassisNo!;
                _motorFormStore.engineNo =
                    _vehicleStore!.vehicles!.vehicles![i].engineNo;
                _motorFormStore.capacity =
                    _vehicleStore!.vehicles!.vehicles![i].capacity;
                //_motorFormStore =
                //    _vehicleStore!.vehicles.vehicles[i].seatingCapacity;

                _carMakeController.text =
                    _vehicleStore!.vehicles!.vehicles![i].make!;
                _carModelController.text =
                    _vehicleStore!.vehicles!.vehicles![i].model!;
                _chassisNoController.text =
                    _vehicleStore!.vehicles!.vehicles![i].chassisNo!;
                _engineNoController.text =
                    _vehicleStore!.vehicles!.vehicles![i].engineNo;
                _engineCapacityController.text =
                    _vehicleStore!.vehicles!.vehicles![i].capacity;
                _seatingCapacityController.text =
                    _vehicleStore!.vehicles!.vehicles![i].seatingCapacity;
                break;
              }
            }
          }
        },
        errorText: _motorFormStore.motorFormErrorStore.vehicleNo);
  }

  Widget _buildCarMake() {
    List<String> suggestions = [];
    if (_motorStore!.makeList != null) {
      for (int i = 0; i < _motorStore!.makeList!.makes!.length; i++) {
        suggestions.add(_motorStore!.makeList!.makes![i].make!);
      }
    }
    return TypeFormWidget(
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('car_make'),
        hint: AppLocalizations.of(context)!.translate('enter_car_make'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _carMakeController,
        suggestions: suggestions,
        onChanged: (value) {
          _motorFormStore.carMake = value;
        },
        onSubmit: (value) {
          _motorFormStore.carMake = value;
          _motorStore!.getModels(value);
        },
        errorText: _motorFormStore.motorFormErrorStore.carMake);
  }

  Widget _buildCarModel() {
    List<String> suggestions = [];
    if (_motorStore!.modelList != null) {
      for (int i = 0; i < _motorStore!.modelList!.models!.length; i++) {
        suggestions.add(_motorStore!.modelList!.models![i].model!);
      }
    }
    return TypeFormWidget(
        capitalization: TextCapitalization.characters,
        text: AppLocalizations.of(context)!.translate('car_model'),
        hint: AppLocalizations.of(context)!.translate('enter_car_model'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        textController: _carModelController,
        suggestions: suggestions,
        onChanged: (value) {
          _motorFormStore.carModel = value;
        },
        onSubmit: (value) {
          _motorFormStore.carModel = value;
          _motorStore!
              .searchCar(_motorFormStore.carMake, _motorFormStore.carModel);
        },
        errorText: _motorFormStore.motorFormErrorStore.carModel);
  }

  Widget _buildChassisNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('chassis_no'),
      hint: AppLocalizations.of(context)!.translate('enter_chassis_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _chassisNoController,
      onChanged: (value) {
        _motorFormStore.chassisNo = value;
      },
    );
  }

  Widget _buildBodyType() {
    if (_motorStore!.searchCarResult != null) {
      _bodyTypeController.text = _motorStore!.searchCarResult!.bodyType ?? "";
      _motorFormStore.bodyType = _motorStore!.searchCarResult!.bodyType ?? "";
    }
    return SecondaryTextFieldWidget(
      enabled: _motorStore!.searchCarResult == null ||
          _motorStore!.searchCarResult!.bodyType == null ||
          _motorStore!.searchCarResult!.bodyType == '',
      text: AppLocalizations.of(context)!.translate('body_type'),
      hint: AppLocalizations.of(context)!.translate('enter_body_type'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _bodyTypeController,
      onChanged: (value) {
        _motorFormStore.bodyType = value;
      },
    );
  }

  Widget _buildEngineNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('engine_no'),
      hint: AppLocalizations.of(context)!.translate('enter_engine_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _engineNoController,
      onChanged: (value) {
        _motorFormStore.engineNo = value;
      },
    );
  }

  Widget _buildEngineCapacity() {
    if (_motorStore!.searchCarResult != null) {
      _engineCapacityController.text =
          _motorStore!.searchCarResult!.capacity ?? "";
      _motorFormStore.capacity = _motorStore!.searchCarResult!.capacity ?? "";
    }
    return SecondaryTextFieldWidget(
      enabled: _motorStore!.searchCarResult == null ||
          _motorStore!.searchCarResult!.capacity == null ||
          _motorStore!.searchCarResult!.capacity == '',
      text: AppLocalizations.of(context)!.translate('engine_capacity'),
      hint: AppLocalizations.of(context)!.translate('enter_engine_capacity'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _engineCapacityController,
      onChanged: (value) {
        _motorFormStore.capacity = value;
      },
    );
  }

  Widget _buildSeatingCapacity() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('seating_capacity'),
      hint: AppLocalizations.of(context)!.translate('enter_seating_capacity'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _seatingCapacityController,
      onChanged: (value) {
        _motorFormStore.seatingCapacity = value;
      },
    );
  }

  Widget _buildManufactureYear() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('manufacture_year'),
      hint: AppLocalizations.of(context)!.translate('enter_manufacture_year'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _manufactureYearController,
      onChanged: (value) {
        _motorFormStore.manufactureYear = value;
      },
    );
  }

  Widget _buildUsage() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('usage'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.usageOptions,
      value: _motorFormStore.usage,
      onChanged: (value) {
        _motorFormStore.usage = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.usage,
    );
  }

  Widget _buildOPC() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('off_peak_car'),
        onToggle: (value) {
          _motorFormStore.opc = value;
        },
        value: _motorFormStore.opc);
  }

  Widget _buildModified() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('has_car_been_modified'),
        onToggle: (value) {
          _motorFormStore.modified = value;
        },
        value: _motorFormStore.modified);
  }

  Widget _buildInsuranceStartDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('insurance_start_date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _startDateController,
        onChanged: (value) {
          _motorFormStore.startDate = value;
        },
        selectedDate: _motorFormStore.expiryDate == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat).parse(_motorFormStore.startDate));
  }

  Widget _buildInsuranceExpiryDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('insurance_expiry_date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _expiryDateController,
        onChanged: (value) {
          _motorFormStore.expiryDate = value;
        },
        selectedDate: _motorFormStore.expiryDate == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat).parse(_motorFormStore.expiryDate));
  }

  Widget _buildNoOfAccident() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('number_of_accident'),
      hint: AppLocalizations.of(context)!.translate('enter_number_of_accident'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _accidentController,
      onChanged: (value) {
        _motorFormStore.noOfAccidents = value;
      },
    );
  }

  Widget _buildTotalClaim() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('total_claim_amount'),
      hint: AppLocalizations.of(context)!.translate('enter_total_claim_amount'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _totalClaimController,
      onChanged: (value) {
        _motorFormStore.totalClaim = value;
      },
    );
  }

  Widget _buildDriverNCD() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('no_claim_discount'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.ncdOptions,
      value: _motorFormStore.ncd,
      onChanged: (value) {
        _motorFormStore.ncd = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.ncd,
    );
  }

  Widget _buildQuestionOne() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('motor_question_1'),
        onToggle: (value) {
          _motorFormStore.seriousOffence = value;
        },
        value: _motorFormStore.seriousOffence);
  }

  Widget _buildQuestionTwo() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('motor_question_2'),
        onToggle: (value) {
          _motorFormStore.physicalDisable = value;
        },
        value: _motorFormStore.physicalDisable);
  }

  Widget _buildQuestionThree() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('motor_question_3'),
        onToggle: (value) {
          _motorFormStore.refused = value;
        },
        value: _motorFormStore.refused);
  }

  Widget _buildQuestionFour() {
    return SwitchWidget(
        title: AppLocalizations.of(context)!.translate('motor_question_4'),
        onToggle: (value) {
          _motorFormStore.terminated = value;
        },
        value: _motorFormStore.terminated);
  }

  Widget _buildNamedDriverOne() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.primaryColor)),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SwitchWidget(
              border: false,
              title:
                  AppLocalizations.of(context)!.translate("additional_driver") +
                      " 1",
              onToggle: (value) {
                _motorFormStore.driverOne = value;
              },
              value: _motorFormStore.driverOne),
          _motorFormStore.driverOne ? SizedBox(height: 10) : Container(),
          _motorFormStore.driverOne ? _buildDriver(0) : Container(),
        ],
      ),
    );
  }

  Widget _buildNamedDriverTwo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.primaryColor)),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SwitchWidget(
              border: false,
              title:
                  AppLocalizations.of(context)!.translate("additional_driver") +
                      " 2",
              onToggle: (value) {
                _motorFormStore.driverTwo = value;
              },
              value: _motorFormStore.driverTwo),
          _motorFormStore.driverTwo ? SizedBox(height: 10) : Container(),
          _motorFormStore.driverTwo ? _buildDriver(1) : Container(),
        ],
      ),
    );
  }

  Widget _buildDriverIdType(int id) {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('id_type'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.idTypeOptions,
      value: id == 0 ? _motorFormStore.idTypeOne : _motorFormStore.idTypeTwo,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.idTypeOne = value
            : _motorFormStore.idTypeTwo = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.usage,
    );
  }

  Widget _buildDriverNRIC(int id) {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('id_number'),
      hint: AppLocalizations.of(context)!.translate('enter_id_number'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController:
          id == 0 ? _driverNRICOneController : _driverNRICTwoController,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.idNumberOne = value
            : _motorFormStore.idNumberTwo = value;
      },
    );
  }

  Widget _buildDriverName(int id) {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('name'),
      hint: AppLocalizations.of(context)!.translate('enter_name'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController:
          id == 0 ? _driverNameOneController : _driverNameTwoController,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.nameOne = value
            : _motorFormStore.nameTwo = value;
      },
    );
  }

  Widget _buildDriverNationality(int id) {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('nationality'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.nationalityOptions,
      value: id == 0
          ? _motorFormStore.nationalityOne
          : _motorFormStore.nationalityTwo,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.nationalityOne = value
            : _motorFormStore.nationalityTwo = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.usage,
    );
  }

  Widget _buildDriverResidential(int id) {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('residential'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.residentialOptions,
      value: id == 0
          ? _motorFormStore.residentialOne
          : _motorFormStore.residentialTwo,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.residentialOne = value
            : _motorFormStore.residentialTwo = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.usage,
    );
  }

  Widget _buildDriverGender(int id) {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('gender'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.genderOptions,
      value: id == 0 ? _motorFormStore.genderOne : _motorFormStore.genderTwo,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.genderOne = value
            : _motorFormStore.genderTwo = value;
      },
      errorText: _motorFormStore.motorFormErrorStore.usage,
    );
  }

  Widget _buildDriverDOB(int id) {
    DateTime dateTime = DateTime.now();
    if (id == 0 && _motorFormStore.dolOne != '') {
      dateTime = DateFormat(Strings.dateFormat).parse(_motorFormStore.dobOne);
    } else if (id == 1 && _motorFormStore.dolTwo != '') {
      dateTime = DateFormat(Strings.dateFormat).parse(_motorFormStore.dobTwo);
    }
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('date_of_birth'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController:
            id == 0 ? _driverDOBOneController : _driverDOBTwoController,
        onChanged: (value) {
          id == 0
              ? _motorFormStore.dobOne = value
              : _motorFormStore.dobTwo = value;
        },
        selectedDate: dateTime);
  }

  Widget _buildDriverDOL(int id) {
    DateTime dateTime = DateTime.now();
    if (id == 0 && _motorFormStore.dolOne != '') {
      dateTime = DateFormat(Strings.dateFormat).parse(_motorFormStore.dolOne);
    } else if (id == 1 && _motorFormStore.dolTwo != '') {
      dateTime = DateFormat(Strings.dateFormat).parse(_motorFormStore.dolTwo);
    }
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('date_of_license'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController:
            id == 0 ? _driverDOLOneController : _driverDOLTwoController,
        onChanged: (value) {
          id == 0
              ? _motorFormStore.dolOne = value
              : _motorFormStore.dolTwo = value;
        },
        selectedDate: dateTime);
  }

  Widget _buildDriverNoOfAccident(int id) {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('number_of_accident'),
      hint: AppLocalizations.of(context)!.translate('enter_number_of_accident'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController:
          id == 0 ? _driverAccidentOneController : _driverAccidentTwoController,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.noOfAccidentOne = value
            : _motorFormStore.noOfAccidentTwo = value;
      },
    );
  }

  Widget _buildDriverTotalClaim(int id) {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('total_claim_amount'),
      hint: AppLocalizations.of(context)!.translate('enter_total_claim_amount'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController:
          id == 0 ? _driverClaimOneController : _driverClaimTwoController,
      onChanged: (value) {
        id == 0
            ? _motorFormStore.totalClaimOne = value
            : _motorFormStore.totalClaimTwo = value;
      },
    );
  }

  Widget _buildDriver(int i) {
    return Column(
      children: [
        _buildDriverIdType(i),
        SizedBox(height: 10),
        _buildDriverNRIC(i),
        SizedBox(height: 10),
        _buildDriverName(i),
        SizedBox(height: 10),
        _buildDriverNationality(i),
        SizedBox(height: 10),
        _buildDriverResidential(i),
        SizedBox(height: 10),
        _buildDriverGender(i),
        SizedBox(height: 10),
        _buildDriverDOB(i),
        SizedBox(height: 10),
        _buildDriverDOL(i),
        SizedBox(height: 10),
        _buildDriverNoOfAccident(i),
        SizedBox(height: 10),
        _buildDriverTotalClaim(i),
      ],
    );
  }

  Widget _buildMotorQuote() {
    return Observer(builder: (context) {
      return Positioned(
          top: MediaQuery.of(context).size.height - 200,
          left: 20,
          width: MediaQuery.of(context).size.width - 40,
          height: 45,
          child: RoundedButtonWidget(
              loading: _motorStore!.enquiryLoading,
              enabled: !_motorStore!.enquiryLoading,
              buttonColor: AppColors.secondaryColor,
              buttonText: AppLocalizations.of(context)!
                  .translate('get_insurance_quote'),
              textColor: Colors.white,
              onPressed: () {
                // TODO :: Validation
                // if (_motorFormStore.canQuote) {
                DeviceUtils.hideKeyboard(context);
                List<dynamic> drivers = [];
                if (_motorFormStore.driverOne) {
                  drivers.add(Driver(
                          idType: _motorFormStore.idTypeOne,
                          idNumber: _motorFormStore.idNumberOne,
                          name: _motorFormStore.nameOne,
                          nationality: _motorFormStore.nationalityOne,
                          residential: _motorFormStore.residentialOne,
                          gender: _motorFormStore.genderOne,
                          dateOfBirth: _motorFormStore.dobOne,
                          dateOfLicense: _motorFormStore.dolOne,
                          noOfAccidents: _motorFormStore.noOfAccidentOne,
                          totalClaimAmount: _motorFormStore.totalClaimOne)
                      .toJson());
                }
                if (_motorFormStore.driverTwo) {
                  drivers.add(Driver(
                          idType: _motorFormStore.idTypeTwo,
                          idNumber: _motorFormStore.idNumberTwo,
                          name: _motorFormStore.nameTwo,
                          nationality: _motorFormStore.nationalityTwo,
                          residential: _motorFormStore.residentialTwo,
                          gender: _motorFormStore.genderTwo,
                          dateOfBirth: _motorFormStore.dobTwo,
                          dateOfLicense: _motorFormStore.dolTwo,
                          noOfAccidents: _motorFormStore.noOfAccidentTwo,
                          totalClaimAmount: _motorFormStore.totalClaimTwo)
                      .toJson());
                }
                MotorEnquiry motorEnquiry = new MotorEnquiry(
                    usage: _motorFormStore.usage,
                    start_date: _motorFormStore.startDate,
                    expiry_date: _motorFormStore.expiryDate,
                    registration_no: _motorFormStore.vehicleNo,
                    type: _motorFormStore.type,
                    model: _motorFormStore.carModel,
                    make: _motorFormStore.carMake,
                    engine_no: _motorFormStore.engineNo,
                    chassis_no: _motorFormStore.chassisNo,
                    body_type: _motorFormStore.bodyType,
                    off_peak: _motorFormStore.opc,
                    modified: _motorFormStore.modified,
                    manufacture_year: _motorFormStore.manufactureYear,
                    capacity: _motorFormStore.capacity,
                    seating_capacity: _motorFormStore.seatingCapacity,
                    no_of_accidents: _motorFormStore.noOfAccidents,
                    total_claim: _motorFormStore.totalClaim,
                    ncd: _motorFormStore.ncd,
                    serious_offence: _motorFormStore.seriousOffence,
                    physical_disable: _motorFormStore.physicalDisable,
                    refused: _motorFormStore.refused,
                    terminated: _motorFormStore.terminated,
                    additional_drivers: drivers);
                _motorStore!.enquiry(motorEnquiry, _motorFormStore.logCards);
                /* } else {
                _showErrorMessage(AppLocalizations.of(context)
                    .translate('login_error_fill_fields'));
              }*/
              }));
    });
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _motorStore!.getMotor(_motorStore!.motor!.id!);
      _motorStore!.enquirySuccess = false;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MotorDetailScreen()));
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
    _vehicleNoController.dispose();
    _carMakeController.dispose();
    _carModelController.dispose();
    _bodyTypeController.dispose();
    _engineCapacityController.dispose();
    _chassisNoController.dispose();
    _engineNoController.dispose();
    _seatingCapacityController.dispose();
    _manufactureYearController.dispose();
    _startDateController.dispose();
    _expiryDateController.dispose();
    _accidentController.dispose();
    _totalClaimController.dispose();

    _driverNRICOneController.dispose();
    _driverNameOneController.dispose();
    _driverDOBOneController.dispose();
    _driverDOLOneController.dispose();
    _driverAccidentOneController.dispose();
    _driverClaimOneController.dispose();

    _driverNRICTwoController.dispose();
    _driverNameTwoController.dispose();
    _driverDOBTwoController.dispose();
    _driverDOLTwoController.dispose();
    _driverAccidentTwoController.dispose();
    _driverClaimTwoController.dispose();
    super.dispose();
  }
}
