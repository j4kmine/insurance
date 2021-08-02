import 'dart:collection';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/warranty/price_list.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:boilerplate/models/warranty/warranty_enquiry.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_form_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/warranty/warranty_checkout.dart';
import 'package:boilerplate/ui/warranty/warranty_get.dart';
import 'package:boilerplate/ui/warranty/warranty_detail.dart';
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
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WarrantyBuyScreen extends StatefulWidget {
  @override
  _WarrantyBuyScreenState createState() => _WarrantyBuyScreenState();
}

class _WarrantyBuyScreenState extends State<WarrantyBuyScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;

  final picker = ImagePicker();
  //stores:---------------------------------------------------------------------
  WarrantyFormStore _warrantyFormStore = WarrantyFormStore();
  TextEditingController _vehicleNoController = TextEditingController();
  TextEditingController _carMakeController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  TextEditingController _chassisNoController = TextEditingController();
  TextEditingController _engineNoController = TextEditingController();
  TextEditingController _registrationDateController = TextEditingController();
  TextEditingController _manufactureYearController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nricUenController = TextEditingController();
  TextEditingController _salutationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactNoController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _mileageCoverageController = TextEditingController();
  TextEditingController _capacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _warrantyStore = Provider.of<WarrantyStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'buy_warranty'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildBuyWarranty());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildVehicle();
      },
    );
  }

  Widget _buildVehicle() {
    if (_warrantyStore!.buyLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            _buildBuyFields(),
            // _buildDriver()
            _buildCheckoutFields(),
            _warrantyStore!.buySuccess ? _buyNavigate() : Container()
          ],
        ),
      );
    }
  }

  bool _isPreowned() {
    return _warrantyStore!.price != null &&
        _warrantyStore!.price!.type == 'preowned';
  }

  Widget _buildCheckoutFields() {
    return Column(children: [
      // _buildMileageCoverage(),
      // SizedBox(height: 10),
      _buildProposedWarrantyStartDate(),
      SizedBox(height: 20),
      FileWidget(
          files: _warrantyFormStore.logCards,
          title: AppLocalizations.of(context)!.translate('upload_log_card'),
          onRemoved: (index) async {
            List<String> fp = _warrantyFormStore.logCards;
            fp.removeAt(index);
            _warrantyFormStore.logCards = fp;
          },
          onCamera: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            List<String> fp = _warrantyFormStore.logCards;
            fp.add(pickedFile!.path);
            _warrantyFormStore.logCards = fp;
          },
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);
            List<String> fp = _warrantyFormStore.logCards;
            for (var i = 0; i < result!.paths.length; i++) {
              fp.add(result.paths[i]!);
            }
            _warrantyFormStore.logCards = fp;
          }),
      SizedBox(height: 20),
      _isPreowned()
          ? FileWidget(
              files: _warrantyFormStore.assessmentReports,
              title: AppLocalizations.of(context)!
                  .translate('upload_assessment_report'),
              onRemoved: (index) async {
                List<String> fp = _warrantyFormStore.assessmentReports;
                fp.removeAt(index);
                _warrantyFormStore.assessmentReports = fp;
              },
              onCamera: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.camera);
                List<String> fp = _warrantyFormStore.assessmentReports;
                fp.add(pickedFile!.path);
                _warrantyFormStore.assessmentReports = fp;
              },
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);
                List<String> fp = _warrantyFormStore.assessmentReports;
                for (var i = 0; i < result!.paths.length; i++) {
                  fp.add(result.paths[i]!);
                }
                _warrantyFormStore.assessmentReports = fp;
              })
          : Container(),
      _isPreowned() ? SizedBox(height: 20) : Container(),
      Text(AppLocalizations.of(context)!.translate('inspection_description'),
          style: TextStyle(color: AppColors.descriptionColor, fontSize: 12))
    ]);
  }

  Widget _buildBuyFields() {
    _vehicleNoController.text = _warrantyStore!.selectedOption!;
    return Column(children: [
      _buildVehicleNo(),
      SizedBox(height: 10),
      _buildChassisNo(),
      SizedBox(height: 10),
      _buildEngineNo(),
      SizedBox(height: 10),
      _buildRegistrationDate(),
      SizedBox(height: 10),
      _buildManufactureYear(),
      SizedBox(height: 10),
      _isPreowned() ? _buildMileage() : Container(),
      _isPreowned() ? SizedBox(height: 10) : Container(),
    ]);
  }

  Widget _buildMileageCoverage() {
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('mileage_coverage'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _mileageCoverageController,
    );
  }

  Widget _buildDriver() {
    return Column(children: [
      _buildSalutation(),
      SizedBox(height: 10),
      _buildName(),
      SizedBox(height: 10),
      _buildNric(),
      SizedBox(height: 10),
      _buildEmail(),
      SizedBox(height: 10),
      _buildContactNo(),
      SizedBox(height: 10),
      _buildAddress(),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildVehicleNo() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      enabled: false,
      text: AppLocalizations.of(context)!.translate('vehicle_no'),
      hint: AppLocalizations.of(context)!.translate('enter_vehicle_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _vehicleNoController,
      onChanged: (value) {
        _warrantyFormStore.vehicleNo = value;
      },
    );
  }

  Widget _buildCarMake() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('car_make'),
      hint: AppLocalizations.of(context)!.translate('enter_car_make'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _carMakeController,
      onChanged: (value) {
        _warrantyFormStore.carMake = value;
      },
    );
  }

  Widget _buildCarModel() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('car_model'),
      hint: AppLocalizations.of(context)!.translate('enter_car_model'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _carModelController,
      onChanged: (value) {
        _warrantyFormStore.carModel = value;
      },
    );
  }

  Widget _buildType() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('preowned_or_new'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: Strings.typeOptions,
      value: _warrantyFormStore.type,
      onChanged: (value) {
        _warrantyFormStore.type = value;
      },
      errorText: _warrantyFormStore.warrantyFormErrorStore.type,
    );
  }

  Widget _buildHybrid() {
    return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('hybrid_or_non_hybrid'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: Strings.hybridOptions,
        value: _warrantyFormStore.hybrid,
        onChanged: (value) {
          _warrantyFormStore.hybrid = value;
        },
        errorText: _warrantyFormStore.warrantyFormErrorStore.hybrid);
  }

  Widget _buildManufactureYear() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('manufacture_year'),
      hint: AppLocalizations.of(context)!.translate('enter_manufacture_year'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _manufactureYearController,
      onChanged: (value) {
        _warrantyFormStore.manufactureYear = value;
      },
    );
  }

  Widget _buildRegistrationDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('registration_date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _registrationDateController,
        onChanged: (value) {
          _warrantyFormStore.registrationDate = value;
        },
        selectedDate: _warrantyFormStore.registrationDate == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_warrantyFormStore.registrationDate));
  }

  Widget _buildMileage() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('mileage'),
      hint: AppLocalizations.of(context)!.translate('enter_mileage'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _mileageController,
      onChanged: (value) {
        _warrantyFormStore.mileage = value;
      },
    );
  }

  Widget _buildChassisNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('chassis_no'),
      hint: AppLocalizations.of(context)!.translate('enter_chassis_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _chassisNoController,
      onChanged: (value) {
        _warrantyFormStore.chassisNo = value;
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
        _warrantyFormStore.engineNo = value;
      },
    );
  }

  Widget _buildCapacity() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('engine_capacity'),
      hint: AppLocalizations.of(context)!.translate('enter_engine_capacity'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _capacityController,
      onChanged: (value) {
        _warrantyFormStore.capacity = value;
      },
    );
  }

  Widget _buildName() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('name_of_driver'),
      hint: AppLocalizations.of(context)!.translate('enter_name_of_driver'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _nameController,
      onChanged: (value) {
        _warrantyFormStore.driverName = value;
      },
    );
  }

  Widget _buildNric() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('nric_uen_number'),
      hint: AppLocalizations.of(context)!.translate('enter_nric_uen_number'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _nricUenController,
      onChanged: (value) {
        _warrantyFormStore.vehicleNo = value;
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
        _warrantyFormStore.vehicleNo = value;
      },
    );
  }

  Widget _buildEmail() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('email'),
      hint: AppLocalizations.of(context)!.translate('enter_email'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _emailController,
      onChanged: (value) {
        _warrantyFormStore.vehicleNo = value;
      },
    );
  }

  Widget _buildSalutation() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('salutation'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _salutationController,
      options: Strings.salutationOptions,
      value: _warrantyFormStore.driverSalutation,
      onChanged: (value) {
        _warrantyFormStore.driverSalutation = value;
      },
    );
  }

  Widget _buildContactNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('contact_no'),
      hint: AppLocalizations.of(context)!.translate('enter_contact_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _contactNoController,
      onChanged: (value) {
        _warrantyFormStore.driverContactNo = value;
      },
    );
  }

  Widget _buildProposedWarrantyStartDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!
            .translate('proposed_warranty_start_date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _startDateController,
        onChanged: (value) {
          _warrantyFormStore.startDate = value;
        },
        selectedDate: _warrantyFormStore.startDate == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat)
                .parse(_warrantyFormStore.startDate));
  }

  Widget _buildBuyWarranty() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
            buttonColor: AppColors.successColor,
            buttonText: AppLocalizations.of(context)!.translate('check_out'),
            textColor: Colors.white,
            onPressed: () {
              // TODO:: Add validation
              //if (_warrantyFormStore.canQuote) {
              DeviceUtils.hideKeyboard(context);
              WarrantyBuy warrantyBuy = new WarrantyBuy(
                  priceId: _warrantyStore!.price!.id,
                  registrationNo: _warrantyStore!.selectedOption!,
                  mileage: _warrantyFormStore.mileage,
                  manufactureYear: _warrantyFormStore.manufactureYear,
                  registrationDate:
                      _warrantyFormStore.registrationDate.toString(),
                  chassisNo: _warrantyFormStore.chassisNo,
                  engineNo: _warrantyFormStore.engineNo,
                  startDate: _warrantyFormStore.startDate.toString());
              _warrantyStore!.buy(warrantyBuy, _warrantyFormStore.logCards,
                  _warrantyFormStore.assessmentReports);
              /*} else {
              _showErrorMessage(AppLocalizations.of(context)
                  .translate('login_error_fill_fields'));
            }*/
            }),
      );
    });
  }

  Widget _buyNavigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _warrantyStore!.buySuccess = false;
      _warrantyStore!.transferSuccess = false;
      _warrantyStore!.status = '';
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WarrantyCheckOutScreen()));
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
    _vehicleNoController.dispose();
    _carMakeController.dispose();
    _carModelController.dispose();
    _chassisNoController.dispose();
    _engineNoController.dispose();
    _registrationDateController.dispose();
    _manufactureYearController.dispose();
    _mileageController.dispose();
    _nameController.dispose();
    _nricUenController.dispose();
    _salutationController.dispose();
    _emailController.dispose();
    _contactNoController.dispose();
    _addressController.dispose();
    _startDateController.dispose();
    _mileageCoverageController.dispose();
    _capacityController.dispose();
    super.dispose();
  }
}
