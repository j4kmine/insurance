import 'dart:collection';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/models/servicing/service_request.dart';
import 'package:boilerplate/stores/servicing/servicing_form_store.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/servicing/servicing_detail.dart';
import 'package:boilerplate/ui/servicing/servicing_list.dart';
import 'package:boilerplate/ui/servicing/servicing_status.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/date_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServicingRescheduleScreen extends StatefulWidget {
  @override
  _ServicingRescheduleScreenState createState() =>
      _ServicingRescheduleScreenState();
}

class _ServicingRescheduleScreenState extends State<ServicingRescheduleScreen> {
  //stores:---------------------------------------------------------------------
  ServicingStore? _servicingStore;
  VehicleStore? _vehicleStore;
  ServicingFormStore _servicingFormStore = new ServicingFormStore();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();
  TextEditingController _vehicleNoController = TextEditingController();
  TextEditingController _workshopController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _servicingStore = Provider.of<ServicingStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);

    // check to see if already called api
    if (!_servicingStore!.pendingServicesLoading) {
      _servicingStore!.getPendingServices();
    }

    if (!_servicingStore!.workshopsLoading) {
      _servicingStore!.getWorkshops();
    }

    if (!_vehicleStore!.vehiclesLoading) {
      _vehicleStore!.getVehicles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("reschedule")),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _servicingStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildServicingReschedule());
  }

  Widget _buildMainContent() {
    return Observer(builder: (context) {
      return Column(children: [
        _buildForm(),
        _servicingStore!.scheduleSuccess ? _navigate() : Container()
      ]);
    });
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        SizedBox(height: 20),
        _buildVehicleNo(),
        SizedBox(height: 10),
        _buildWorkshop(),
        SizedBox(height: 10),
        _buildService(),
        SizedBox(height: 10),
        _buildDate(),
        _servicingFormStore.date != '' ? _buildTime() : Container(),
      ]),
    );
  }

  Widget _buildVehicleNo() {
    _vehicleNoController.text =
        _servicingStore!.service!.vehicle!.registrationNo!;
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('vehicle_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _vehicleNoController,
    );
  }

  Widget _buildWorkshop() {
    _workshopController.text = _servicingStore!.service!.workshop!.name!;
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('workshop'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _workshopController,
    );
  }

  Widget _buildService() {
    _serviceController.text = _servicingStore!.service!.serviceType!.name!;
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('service'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _serviceController,
    );
  }

  Widget _buildDate() {
    return DateWidget(
        text: AppLocalizations.of(context)!.translate('date'),
        hint: Strings.dateFormat,
        inputAction: TextInputAction.next,
        textController: _dateController,
        onChanged: (value) {
          _servicingFormStore.date = value;
          _servicingStore!
              .getServiceSlots(_servicingStore!.service!.workshopId!);
        },
        selectedDate: _servicingFormStore.date == ''
            ? DateTime.now()
            : DateFormat(Strings.dateFormat).parse(_servicingFormStore.date));
  }

  Widget _buildTime() {
    if (_servicingStore!.serviceSlotsLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      List<String> options = [''];
      Map<String, String> values = new HashMap();
      for (var i = 0;
          i < _servicingStore!.serviceSlotList!.serviceSlots!.length;
          i++) {
        if (DateFormat(Strings.dateFormat)
                .parse(_servicingFormStore.date)
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
                  value: _servicingFormStore.time,
                  onChanged: (value) {
                    _servicingFormStore.time = value;
                  },
                  errorText: _servicingFormStore.servicingFormErrorStore.type,
                ),
                SizedBox(height: 10),
                _buildRemarks()
              ],
            );
    }
  }

  Widget _buildRemarks() {
    _remarksController.text = _servicingStore!.service!.remarks ?? "";
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('remarks_to_workshop'),
      hint: AppLocalizations.of(context)!.translate('enter_remarks'),
      inputType: TextInputType.multiline,
      inputAction: TextInputAction.next,
      textController: _remarksController,
      onChanged: (value) {
        _servicingFormStore.remarks = value;
      },
    );
  }

  Widget _buildServicingReschedule() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
          loading: _servicingStore!.updateLoading,
          enabled: !_servicingStore!.updateLoading,
          buttonColor: AppColors.secondaryColor,
          buttonText: AppLocalizations.of(context)!.translate('reschedule'),
          textColor: Colors.white,
          onPressed: () {
            ServiceRequest request = new ServiceRequest(
                appointmentTime: _servicingFormStore.time,
                appointmentDate: _servicingFormStore.date,
                remarks: _servicingFormStore.remarks);

            _servicingStore!
                .rescheduleService(request, _servicingStore!.service!.id!);
          },
        ),
      );
    });
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _servicingStore!.scheduleSuccess = false;
      Navigator.of(context).pop();
    });

    return Container();
  }
}
