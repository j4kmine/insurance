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
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/date_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:boilerplate/widgets/secondary_dropdown_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServicingBookScreen extends StatefulWidget {
  @override
  _ServicingBookScreenState createState() => _ServicingBookScreenState();
}

class _ServicingBookScreenState extends State<ServicingBookScreen> {
  //stores:---------------------------------------------------------------------
  ServicingStore? _servicingStore;
  VehicleStore? _vehicleStore;
  ServicingFormStore _servicingFormStore = new ServicingFormStore();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();

  var categories = [
    'goodbye_to_hefty_repair_bills',
    'zero_out_of_pocket_expenses',
    'repair_workshops_over_the_island',
    'high_quality_repairs',
    '100_assurance_on_claims',
    'service_your_car_anywhere'
  ];

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
        appBar: SecondaryAppBarWidget(text: 'book_servicing'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _servicingStore!.getPendingServices(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 240,
        firstWidget: ErrorStoreWidget(errorStore: _servicingStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildServicingBook());
  }

  Widget _buildMainContent() {
    return Observer(builder: (context) {
      return Column(children: [
        _buildPendingHeader(),
        _buildServicing(),
        SizedBox(height: 10),
        _buildForm(),
        _servicingStore!.bookSuccess ? _navigate() : Container()
      ]);
    });
  }

  Widget _buildPendingHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  AppLocalizations.of(context)!
                      .translate("upcoming_appointments"),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              InkWell(
                onTap: () {
                  _servicingStore!.getServices();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServicingListScreen()));
                },
                child: Text(AppLocalizations.of(context)!.translate("view_all"),
                    style: TextStyle(
                        color: AppColors.darkBlueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              )
            ],
          ),
          SizedBox(height: 15),
          Divider(height: 1, thickness: 2)
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        SizedBox(height: 10),
        _buildVehicleNo(),
        SizedBox(height: 10),
        _buildWorkshop(),
        SizedBox(height: 10),
        !_servicingStore!.workshopsLoading &&
                _servicingFormStore.workshopOption != ''
            ? _buildWorkshopDetails()
            : Container()
      ]),
    );
  }

  Widget _buildWorkshopDetails() {
    return Column(children: [
      _buildService(),
      _servicingFormStore.serviceOption != '' ? _buildDate() : Container(),
      _servicingFormStore.date != '' ? _buildTime() : Container(),
    ]);
  }

  Widget _buildVehicleNo() {
    if (_servicingStore!.workshopsLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      List<String> options = [''];
      Map<String, int> values = new HashMap();
      if (_vehicleStore!.vehicles != null) {
        for (var i = 0; i < _vehicleStore!.vehicles!.vehicles!.length; i++) {
          if (_vehicleStore!.vehicles!.vehicles![i].registrationNo != null) {
            String option =
                _vehicleStore!.vehicles!.vehicles![i].registrationNo!;
            options.add(option);
            values[option] = _vehicleStore!.vehicles!.vehicles![i].id!;
          }
        }
      }
      return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('vehicle_no'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: options,
        values: values,
        value: _servicingFormStore.vehicleNo,
        onChanged: (value) {
          _servicingFormStore.vehicleNo = value;
        },
        errorText: _servicingFormStore.servicingFormErrorStore.vehicleNo,
      );
    }
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
        value: _servicingFormStore.workshopOption,
        onChanged: (value) {
          _servicingFormStore.workshopOption = value;
          _servicingStore!.getServiceTypes(int.parse(value));
        },
        errorText: _servicingFormStore.servicingFormErrorStore.type,
      );
    } else {
      return Container();
    }
  }

  Widget _buildService() {
    if (_servicingStore!.serviceLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      List<String> options = [''];
      Map<String, int> values = new HashMap();
      if (_servicingStore!.serviceTypeList != null) {
        for (var i = 0;
            i < _servicingStore!.serviceTypeList!.serviceTypes!.length;
            i++) {
          String option =
              _servicingStore!.serviceTypeList!.serviceTypes![i].name!;
          options.add(option);
          values[option] =
              _servicingStore!.serviceTypeList!.serviceTypes![i].id!;
        }
      }
      return SecondaryDropDownWidget(
        text: AppLocalizations.of(context)!.translate('service'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        options: options,
        values: values,
        value: _servicingFormStore.serviceOption,
        onChanged: (value) {
          _servicingFormStore.serviceOption = value;
        },
        errorText: _servicingFormStore.servicingFormErrorStore.type,
      );
    }
  }

  Widget _buildDate() {
    return Column(
      children: [
        SizedBox(height: 10),
        DateWidget(
            text: AppLocalizations.of(context)!.translate('date'),
            hint: Strings.dateFormat,
            inputAction: TextInputAction.next,
            textController: _dateController,
            onChanged: (value) {
              _servicingFormStore.date = value;
              _servicingStore!.getServiceSlots(
                  int.parse(_servicingFormStore.workshopOption));
            },
            selectedDate: _servicingFormStore.date == ''
                ? DateTime.now()
                : DateFormat(Strings.dateFormat)
                    .parse(_servicingFormStore.date)),
      ],
    );
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

  Widget _buildServicing() {
    if (_servicingStore!.pendingServicesLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return (_servicingStore!.pendingServiceList != null &&
              _servicingStore!.pendingServiceList!.services!.length > 0)
          ? ListWidget(
              count: _servicingStore!.pendingServiceList!.services!.length,
              itemBuilder: (context, position) {
                return _buildServicingTile(
                    _servicingStore!.pendingServiceList!.services![position]);
              })
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_servicing_found'),
                ),
              ),
            );
    }
  }

  Widget _buildServicingTile(Service servicing) {
    String topLeft = AppLocalizations.of(context)!.translate("car_servicing");
    String topRight =
        AppLocalizations.of(context)!.translate(servicing.status!);
    String bottomLeft = servicing.workshop!.name!;
    String bottomRight = servicing.formatAppointmentDate!;

    if (servicing.vehicle != null) {
      topLeft += ": " + servicing.vehicle!.registrationNo!;
    }
    return ListTileWidget(
        onTap: () {
          _servicingStore!.getService(servicing!.id!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServicingDetailScreen()));
        },
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight);
  }

  Widget _buildServicingBook() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 220,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
          loading: _servicingStore!.bookLoading,
          enabled: !_servicingStore!.bookLoading,
          buttonColor: AppColors.successColor,
          buttonText:
              AppLocalizations.of(context)!.translate('book_new_appointment'),
          textColor: Colors.white,
          onPressed: () {
            ServiceRequest request = new ServiceRequest(
                vehicleId: _servicingFormStore.vehicleNo,
                workshopId: _servicingFormStore.workshopOption,
                serviceTypeId: _servicingFormStore.serviceOption,
                appointmentTime: _servicingFormStore.time,
                appointmentDate: _servicingFormStore.date,
                remarks: _servicingFormStore.remarks);
            _servicingStore!.submitService(request);
          },
        ),
      );
    });
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _servicingStore!.bookSuccess = false;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ServicingStatusScreen()));
    });

    return Container();
  }
}
