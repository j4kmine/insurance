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

class AccessControlCreateScreen extends StatefulWidget {
  @override
  _AccessControlCreateScreenState createState() =>
      _AccessControlCreateScreenState();
}

class _AccessControlCreateScreenState extends State<AccessControlCreateScreen> {
  //stores:---------------------------------------------------------------------
  VehicleStore? _vehicleStore;

  //stores:---------------------------------------------------------------------
  TextEditingController _nricController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _vehicleStore = Provider.of<VehicleStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'add_user'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _vehicleStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildAddUser());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildCustomer();
      },
    );
  }

  Widget _buildCustomer() {
    if (_vehicleStore!.createLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            _buildNric(),
            _vehicleStore!.createSuccess ? _createNavigate() : Container()
          ],
        ),
      );
    }
  }

  Widget _buildNric() {
    return SecondaryTextFieldWidget(
      capitalization: TextCapitalization.characters,
      text: AppLocalizations.of(context)!.translate('nric_uen_number'),
      hint: AppLocalizations.of(context)!.translate('enter_nric_uen_number'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _nricController,
      onChanged: (value) {},
    );
  }

  Widget _buildAddUser() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
            buttonColor: AppColors.secondaryColor,
            buttonText: AppLocalizations.of(context)!.translate('add_user'),
            textColor: Colors.white,
            onPressed: () {
              _vehicleStore!.createAccess(
                  _nricController.text, _vehicleStore!.vehicleId!);
            }),
      );
    });
  }

  Widget _createNavigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _vehicleStore!.createSuccess = false;
      Navigator.of(context).pop();
      FlushbarHelper.createSuccess(
        message: _vehicleStore!.successStore.successMessage,
        title: AppLocalizations.of(context)!.translate('home_tv_success'),
        duration: Duration(seconds: 3),
      )..show(context);
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
    _nricController.dispose();
    super.dispose();
  }
}
