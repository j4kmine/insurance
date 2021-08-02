import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_form_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/warranty/warranty_buy.dart';
import 'package:boilerplate/ui/warranty/warranty_checkout.dart';
import 'package:boilerplate/ui/warranty/warranty_enquiry.dart';
import 'package:boilerplate/ui/warranty/warranty_prices.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:boilerplate/widgets/type_form_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WarrantyQuoteScreen extends StatefulWidget {
  @override
  _WarrantyQuoteScreenState createState() => _WarrantyQuoteScreenState();
}

class _WarrantyQuoteScreenState extends State<WarrantyQuoteScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;
  VehicleStore? _vehicleStore;

  //stores:---------------------------------------------------------------------
  WarrantyFormStore _warrantyFormStore = WarrantyFormStore();
  TextEditingController _carMakeController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _warrantyStore = Provider.of<WarrantyStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);
    if (!_warrantyStore!.makesLoading && !_warrantyStore!.pricesLoading) {
      _warrantyStore!.getMakes();
    }
    if (!_vehicleStore!.vehiclesLoading && _vehicleStore!.vehicles == null) {
      _vehicleStore!.getVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'get_warranty_quote'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 240,
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildWarrantyQuote());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildVehicle();
      },
    );
  }

  Widget _buildVehicle() {
    if (_vehicleStore!.vehiclesLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            _buildVehicleNo(),
            _warrantyStore!.pricesLoaded ? _navigate() : Container(),
            _warrantyFormStore.vehicleNo != '' ? _buildExtraInfo() : Container()
          ],
        ),
      );
    }
  }

  Widget _buildExtraInfo() {
    return Column(children: [
      SizedBox(height: 10),
      _buildCarMake(),
      SizedBox(height: 10),
      _buildCarModel(),
      SizedBox(height: 10),
      _buildType(),
      SizedBox(height: 10),
      _buildHybrid()
    ]);
  }

  Widget _buildVehicleNo() {
    return SecondaryDropDownWidget(
      text: AppLocalizations.of(context)!.translate('vehicle_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      options: _vehicleStore!.vehicleOptions,
      value: _warrantyFormStore.vehicleNo,
      onChanged: (value) {
        _warrantyFormStore.vehicleNo = value;
        _warrantyStore!.selectedOption = value;
        if (value != null && value != '' && value != Strings.quote) {
          if (_vehicleStore!.vehicles != null) {
            for (int i = 0;
                i < _vehicleStore!.vehicles!.vehicles!.length;
                i++) {
              if (_vehicleStore!.vehicles!.vehicles![i].registrationNo ==
                  value) {
                _warrantyFormStore.carModel =
                    _vehicleStore!.vehicles!.vehicles![i]!.model!;
                _warrantyFormStore.carMake =
                    _vehicleStore!.vehicles!.vehicles![i]!.make!;
                _warrantyFormStore.type =
                    _vehicleStore!.vehicles!.vehicles![i].type;
                _warrantyFormStore.hybrid =
                    _vehicleStore!.vehicles!.vehicles![i].fuel == null
                        ? ''
                        : _vehicleStore!.vehicles!.vehicles![i].fuel;
                _carModelController.text =
                    _vehicleStore!.vehicles!.vehicles![i]!.model!;
                _carMakeController.text =
                    _vehicleStore!.vehicles!.vehicles![i]!.make!;
                break;
              }
            }
          }
        } else {
          _warrantyFormStore.carModel = "";
          _warrantyFormStore.carMake = "";
          _warrantyFormStore.type = "";
          _warrantyFormStore.hybrid = "";
          _carModelController.text = "";
          _carMakeController.text = "";
        }
      },
    );
  }

  Widget _buildCarMake() {
    List<String> suggestions = [];
    if (_warrantyStore!.makeList != null) {
      for (int i = 0; i < _warrantyStore!.makeList!.makes!.length; i++) {
        suggestions.add(_warrantyStore!.makeList!.makes![i].make!);
        print(_warrantyStore!.makeList!.makes![i].make!);
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
          _warrantyFormStore.carMake = value;
        },
        onSubmit: (value) {
          _warrantyFormStore.carMake = value;
          _warrantyStore!.getModels(value);
        },
        errorText: _warrantyFormStore.warrantyFormErrorStore.carMake);
  }

  Widget _buildCarModel() {
    List<String> suggestions = [];
    if (_warrantyStore!.modelList != null) {
      for (int i = 0; i < _warrantyStore!.modelList!.models!.length; i++) {
        suggestions.add(_warrantyStore!.modelList!.models![i].model!);
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
          _warrantyFormStore.carModel = value;
        },
        onSubmit: (value) {
          _warrantyFormStore.carModel = value;
        },
        errorText: _warrantyFormStore.warrantyFormErrorStore.carModel);
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

  Widget _buildWarrantyQuote() {
    return Positioned(
      top: MediaQuery.of(context).size.height - 220,
      left: 20,
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 45,
            child: RoundedButtonWidget(
                buttonColor: AppColors.secondaryColor,
                buttonText: AppLocalizations.of(context)!
                    .translate('get_warranty_quote'),
                textColor: Colors.white,
                onPressed: () {
                  if (_warrantyFormStore.canQuote) {
                    DeviceUtils.hideKeyboard(context);
                    _warrantyStore!.getPrices(
                        _warrantyFormStore.carMake,
                        _warrantyFormStore.carModel,
                        _warrantyFormStore.type,
                        _warrantyFormStore.hybrid);
                  } else {
                    _showErrorMessage(AppLocalizations.of(context)!
                        .translate('login_error_fill_fields'));
                  }
                }),
          ),
          SizedBox(height: 10),
          Center(
              child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WarrantyEnquiryScreen()));
            },
            child: Text(
                AppLocalizations.of(context)!.translate('cant_find_car'),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold)),
          )),
        ],
      ),
    );
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _warrantyStore!.pricesLoaded = false;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WarrantyPricesScreen()));
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
    super.dispose();
  }
}
