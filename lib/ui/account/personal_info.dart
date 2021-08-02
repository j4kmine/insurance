import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/motor/motor_buy.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/user/user_form_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/browser.dart';
import 'package:boilerplate/ui/motor/motor_checkout.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/date_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:boilerplate/widgets/status_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  //stores:---------------------------------------------------------------------
  UserFormStore _userFormStore = UserFormStore();
  UserStore? _userStore;
  VehicleStore? _vehicleStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nricController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _drivingPassController = TextEditingController();
  TextEditingController _drivingClassController = TextEditingController();

  List<TextEditingController> _vehicleNoControllers = <TextEditingController>[];

  List<TextEditingController> _vehicleTypeControllers =
      <TextEditingController>[];

  List<TextEditingController> _vehicleMakeControllers =
      <TextEditingController>[];

  List<TextEditingController> _vehicleModelControllers =
      <TextEditingController>[];

  List<TextEditingController> _chassisNoControllers = <TextEditingController>[];

  List<TextEditingController> _engineNoControllers = <TextEditingController>[];

  List<TextEditingController> _yearOfManufactureControllers =
      <TextEditingController>[];

  List<TextEditingController> _registrationDateControllers =
      <TextEditingController>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _userStore = Provider.of<UserStore>(context);

    if (!_userStore!.customerLoading) {
      _userFormStore.customer = null;
      _userStore!.getProfile();
    }

    _vehicleStore = Provider.of<VehicleStore>(context);

    if (!_vehicleStore!.vehiclesLoading) {
      _userFormStore.vehicles = null;
      _vehicleStore!.getVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("personal_info")),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              _userFormStore.customer = null;
              _userStore!.getProfile();

              _userFormStore.vehicles = null;
              _vehicleStore!.getVehicles();
            },
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Observer(
      builder: (context) {
        return BodyWidget(
            height: 220,
            firstWidget: ErrorStoreWidget(errorStore: _userStore!.errorStore),
            secondWidget: _buildCustomer(),
            thirdWidget: _buildSave());
      },
    );
  }

  Widget _buildCustomer() {
    if (_userStore!.customerLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_userStore!.customer != null)
          ? _buildProfile()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .translate('no_personal_info_found'),
                ),
              ),
            );
    }
  }

  _setControllers() {
    _nricController.text = (_userFormStore.customer!.nricUen == null
        ? ''
        : _userFormStore.customer!.nricUen)!;
    _nameController.text = (_userFormStore.customer!.name! == null
        ? ''
        : _userFormStore.customer!.name)!;
    _dobController.text = (_userFormStore.customer!.formatDob == null
        ? ''
        : _userFormStore.customer!.formatDob)!;

    _emailController.text = (_userFormStore.customer!.email == null
        ? ''
        : _userFormStore.customer!.email)!;

    _phoneController.text = _userFormStore.customer!.phone == null
        ? ''
        : _userFormStore.customer!.phone!.replaceAll("+65 ", "");

    _addressController.text = _userFormStore.customer!.address == null
        ? ''
        : _userFormStore.customer!.address;

    _drivingPassController.text =
        (_userFormStore.customer!.formatDrivingLicenseValidity == null
            ? ''
            : _userFormStore.customer!.formatDrivingLicenseValidity)!;

    _drivingClassController.text =
        _userFormStore.customer!.drivingLicenseClass == null
            ? ''
            : _userFormStore.customer!.drivingLicenseClass;
  }

  Widget _buildProfile() {
    if (_userFormStore.customer == null) {
      _userFormStore.customer = _userStore!.customer;
    }
    _setControllers();

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          _buildMyInfo(),
          SizedBox(height: 20),
          _buildAccordion('personal_info', 0),
          SizedBox(height: 10),
          !_userFormStore.hideList[0] ? _buildPersonalInfos() : Container(),
          SizedBox(height: 10),
          _buildAccordion('contact_info', 1),
          SizedBox(height: 10),
          !_userFormStore.hideList[1] ? _buildContactInfos() : Container(),
          SizedBox(height: 10),
          _buildAccordion('driving_license_info', 2),
          SizedBox(height: 10),
          !_userFormStore.hideList[2] ? _buildDrivingLicense() : Container(),
          SizedBox(height: 10),
          _buildVehicles(),
        ],
      ),
    );
  }

  Widget _buildAccordion(String title, int index) {
    return InkWell(
      onTap: () {
        _userFormStore.hideList[index] = !_userFormStore.hideList[index];
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(AppLocalizations.of(context)!.translate(title),
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        Icon(
            _userFormStore.hideList[index]
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_down,
            color: AppColors.primaryColor),
      ]),
    );
  }

  Widget _buildVehicleAccordion(int index) {
    return Row(children: [
      InkWell(
          onTap: () {
            _userFormStore.vehicles!.removeAt(index);
            _userFormStore.hideVehicleList.removeAt(index);
          },
          child: SvgPicture.asset('assets/icons/ic_remove.svg')),
      SizedBox(width: 10),
      Text(
          AppLocalizations.of(context)!.translate("vehicle_info") +
              " " +
              (index + 1).toString(),
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
      Spacer(),
      InkWell(
        onTap: () {
          _userFormStore.hideVehicleList[index] =
              !_userFormStore.hideVehicleList[index];
        },
        child: Icon(
            _userFormStore.hideVehicleList[index]
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_down,
            color: AppColors.primaryColor),
      ),
    ]);
  }

  Widget _buildPersonalInfos() {
    return Column(
      children: [
        _buildNric(),
        SizedBox(height: 10),
        _buildName(),
        SizedBox(height: 10),
        _buildGender(),
        SizedBox(height: 10),
        _buildDob(),
        SizedBox(height: 10),
        _buildNationality(),
        SizedBox(height: 10),
        _buildResidential(), // Country of birth
        SizedBox(height: 10),
        _buildOccupation(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildContactInfos() {
    return Column(
      children: [
        _buildMobile(),
        SizedBox(height: 10),
        _buildEmail(),
        SizedBox(height: 10),
        _buildAddress(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDrivingLicense() {
    return Column(
      children: [
        _buildDrivingPassDate(),
        SizedBox(height: 10),
        _buildDrivingClasses(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDrivingPassDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('driver_license'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _drivingPassController,
        onChanged: (value) {
          _userFormStore.customer!.formatDrivingLicenseValidity = value;
        },
        selectedDate: _userFormStore.customer!.formatDrivingLicenseValidity ==
                    null ||
                _userFormStore.customer!.formatDrivingLicenseValidity == '-'
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_userFormStore.customer!.formatDrivingLicenseValidity!));
  }

  Widget _buildDrivingClasses() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('driving_license_class'),
      hint: AppLocalizations.of(context)!
          .translate('enter_driving_license_class'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      capitalization: TextCapitalization.characters,
      textController: _drivingClassController,
    );
  }

  Widget _buildVehicles() {
    return Observer(builder: (context) {
      List<Widget> list = [];
      if (_vehicleStore!.vehicles != null) {
        if (_userFormStore.vehicles == null) {
          _userFormStore.vehicles =
              ObservableList<Vehicle>.of(_vehicleStore!.vehicles!.vehicles!);
        }
        for (var i = 0; i < _userFormStore.vehicles!.length; i++) {
          _vehicleNoControllers.add(TextEditingController());
          _vehicleTypeControllers.add(TextEditingController());
          _vehicleMakeControllers.add(TextEditingController());
          _vehicleModelControllers.add(TextEditingController());
          _chassisNoControllers.add(TextEditingController());
          _engineNoControllers.add(TextEditingController());
          _yearOfManufactureControllers.add(TextEditingController());
          _registrationDateControllers.add(TextEditingController());
          if (_userFormStore.hideVehicleList.length <= i) {
            if (i != 0) {
              _userFormStore.hideVehicleList.add(true);
            } else {
              _userFormStore.hideVehicleList.add(false);
            }
          }
        }
        for (var i = 0; i < _userFormStore.vehicles!.length; i++) {
          list.add(_buildVehicleAccordion(i));
          list.add(SizedBox(height: 10));
          if (!_userFormStore.hideVehicleList[i]) {
            list.add(_buildVehicleNo(i));
            list.add(SizedBox(height: 10));
            list.add(_buildVehicleType(i));
            list.add(SizedBox(height: 10));
            list.add(_buildVehicleMake(i));
            list.add(SizedBox(height: 10));
            list.add(_buildVehicleModel(i));
            list.add(SizedBox(height: 10));
            list.add(_buildChassisNo(i));
            list.add(SizedBox(height: 10));
            list.add(_buildEngineNo(i));
            list.add(SizedBox(height: 10));
            list.add(_buildYearOfManufacture(i));
            list.add(SizedBox(height: 10));
            list.add(_buildRegistrationDate(i));
          }
          list.add(SizedBox(height: 20));
        }
      }
      list.add(SizedBox(height: 10));
      list.add(_buildAddVehicle());
      list.add(SizedBox(height: 20));
      if (_userStore!.successStore.successMessage != '') {
        _showSuccessMessage(_userStore!.successStore.successMessage);
      }
      return Column(children: list);
    });
  }

  Widget _buildAddVehicle() {
    return InkWell(
      onTap: () {
        _userFormStore.vehicles!.add(Vehicle());
        _userFormStore.hideVehicleList.add(true);
      },
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/ic_add.svg'),
          SizedBox(width: 10),
          Text(AppLocalizations.of(context)!.translate("add_vehicle"),
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildMyInfo() {
    return InkWell(
      onTap: () async {
        _userStore!.myinfo = true;
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => Browser(userFormStore: _userFormStore)));
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(image: AssetImage('assets/images/img_myinfo.png'))]),
    );
  }

  Widget _buildNric() {
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('nric'),
      hint: AppLocalizations.of(context)!.translate('enter_nric'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _nricController,
    );
  }

  Widget _buildName() {
    _nameController.text = _userFormStore.customer!.name!;
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('name'),
      hint: AppLocalizations.of(context)!.translate('enter_name'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _nameController,
      onChanged: (value) {
        _userFormStore.customer!.name = value;
      },
    );
  }

  Widget _buildGender() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('gender'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.genderOptions,
        value: _userFormStore.customer!.gender,
        onChanged: (value) {
          _userFormStore.customer!.gender = value;
          _userFormStore.customer = _userFormStore.customer;
        });
  }

  Widget _buildDob() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('date_of_birth'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _dobController,
        onChanged: (value) {
          _userFormStore.customer!.formatDob = value;
        },
        selectedDate: _userFormStore.customer!.formatDob == null ||
                _userFormStore.customer!.formatDob == '-'
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_userFormStore.customer!.formatDob!));
  }

  Widget _buildNationality() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('nationality'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.nationalityOptions,
        value: _userFormStore.customer!.formatNationality == '-'
            ? ''
            : _userFormStore.customer!.formatNationality!,
        onChanged: (value) {
          _userFormStore.customer!.formatNationality = value;
          _userFormStore.customer = _userFormStore.customer;
        });
  }

  Widget _buildResidential() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('residential'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.residentialOptions,
        value: _userFormStore.customer!.formatResidential == '-'
            ? ''
            : _userFormStore.customer!.formatResidential!,
        onChanged: (value) {
          _userFormStore.customer!.formatResidential = value;
          _userFormStore.customer = _userFormStore.customer;
        });
  }

  Widget _buildOccupation() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('occupation'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.occupationOptions,
        value: _userFormStore.customer!.formatOccupation == '-'
            ? ''
            : _userFormStore.customer!.formatOccupation!,
        onChanged: (value) {
          _userFormStore.customer!.formatOccupation = value;
          _userFormStore.customer = _userFormStore.customer;
        });
  }

  Widget _buildEmail() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('email'),
      hint: AppLocalizations.of(context)!.translate('enter_email'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _emailController,
      onChanged: (value) {
        _userFormStore.customer!.email = value;
      },
    );
  }

  Widget _buildMobile() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('phone') + " (+65)",
      hint: AppLocalizations.of(context)!.translate('enter_phone'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _phoneController,
      onChanged: (value) {
        _userFormStore.customer!.phone = value;
      },
    );
  }

  Widget _buildAddress() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('address'),
      hint: AppLocalizations.of(context)!.translate('enter_address'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _addressController,
      onChanged: (value) {
        _userFormStore.customer!.address = value;
      },
    );
  }

  Widget _buildVehicleNo(int index) {
    _vehicleNoControllers[index].text =
        _userFormStore.vehicles![index].registrationNo != null
            ? _userFormStore.vehicles![index].registrationNo!
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('vehicle_no'),
      hint: AppLocalizations.of(context)!.translate('enter_vehicle_no'),
      inputType: TextInputType.text,
      capitalization: TextCapitalization.characters,
      inputAction: TextInputAction.next,
      textController: _vehicleNoControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].registrationNo = value;
      },
    );
  }

  Widget _buildVehicleType(int index) {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('preowned_or_new'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.typeOptions,
      value: _userFormStore.vehicles![index].type,
      onChanged: (value) {
        _userFormStore.vehicles![index].type = value;
        _userFormStore.vehicles![index] = _userFormStore.vehicles![index];
      },
    );
  }

  Widget _buildVehicleMake(index) {
    _vehicleMakeControllers[index].text =
        _userFormStore.vehicles![index].make != null
            ? _userFormStore.vehicles![index].make!
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('vehicle_make'),
      hint: AppLocalizations.of(context)!.translate('enter_vehicle_make'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _vehicleMakeControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].make = value;
      },
    );
  }

  Widget _buildVehicleModel(index) {
    _vehicleModelControllers[index].text =
        _userFormStore.vehicles![index].model != null
            ? _userFormStore.vehicles![index].model!
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('vehicle_model'),
      hint: AppLocalizations.of(context)!.translate('enter_vehicle_model'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _vehicleModelControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].model = value;
      },
    );
  }

  Widget _buildChassisNo(index) {
    _chassisNoControllers[index].text =
        _userFormStore.vehicles![index].chassisNo != null
            ? _userFormStore.vehicles![index].chassisNo!
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('chassis_no'),
      hint: AppLocalizations.of(context)!.translate('enter_chassis_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _chassisNoControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].chassisNo = value;
      },
    );
  }

  Widget _buildEngineNo(index) {
    _engineNoControllers[index].text =
        _userFormStore.vehicles![index].engineNo != null
            ? _userFormStore.vehicles![index].engineNo
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('engine_no'),
      hint: AppLocalizations.of(context)!.translate('enter_engine_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _engineNoControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].engineNo = value;
      },
    );
  }

  Widget _buildYearOfManufacture(index) {
    _yearOfManufactureControllers[index].text =
        _userFormStore.vehicles![index].manufactureYear != null
            ? _userFormStore.vehicles![index].manufactureYear.toString()
            : '-';
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('manufacture_year'),
      hint: AppLocalizations.of(context)!.translate('enter_manufacture_year'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _yearOfManufactureControllers[index],
      onChanged: (value) {
        _userFormStore.vehicles![index].manufactureYear = value;
      },
    );
  }

  Widget _buildRegistrationDate(index) {
    _registrationDateControllers[index].text =
        _userFormStore.vehicles![index].formatRegistrationDate != null
            ? _userFormStore.vehicles![index].formatRegistrationDate!
            : '-';
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('registration_date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _registrationDateControllers[index],
        onChanged: (value) {
          _userFormStore.vehicles![index].formatRegistrationDate = value;
        },
        selectedDate: _userFormStore.vehicles![index].formatRegistrationDate ==
                    null ||
                _userFormStore.vehicles![index].formatRegistrationDate == '-'
            ? DateTime.now()
            : DateFormat(Strings.dateFormat).parse(
                _userFormStore.vehicles![index].formatRegistrationDate!));
  }

  Widget _buildSave() {
    return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
          loading: _userStore!.updateLoading,
          enabled: !_userStore!.updateLoading,
          buttonText: AppLocalizations.of(context)!.translate('save'),
          buttonColor: AppColors.secondaryColor,
          textColor: Colors.white,
          onPressed: () async {
            _userStore!.updateProfile(
                _userFormStore.customer!, _userFormStore.vehicles!);
          },
        ));
  }

  _showSuccessMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context)!.translate('home_tv_success'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
  }
}
