import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AccidentDetailScreen extends StatefulWidget {
  @override
  _AccidentDetailScreenState createState() => _AccidentDetailScreenState();
}

class _AccidentDetailScreenState extends State<AccidentDetailScreen> {
  //stores:---------------------------------------------------------------------
  AccidentStore? _accidentStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _accidentStore = Provider.of<AccidentStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("report_details")),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () =>
                _accidentStore!.getAccident(_accidentStore!.accident!.id!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return BodyWidget(
          firstWidget: ErrorStoreWidget(errorStore: _accidentStore!.errorStore),
          secondWidget: _buildMainContent());
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildAccident();
      },
    );
  }

  Widget _buildAccident() {
    if (_accidentStore!.accidentLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_accidentStore!.accident != null)
          ? _buildAccidentDetails()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)
                          ?.translate('no_accident_found') ??
                      "",
                ),
              ),
            );
    }
  }

  Widget _buildPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, thickness: 2),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate("accident_photos"),
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          children: List.generate(
            _accidentStore!.accident!.documents!.length,
            (index) => Image.network(
                _accidentStore!.accident!.documents![index].view!),
          ),
        ),
      ],
    );
  }

  Widget _buildAccidentDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            DetailWidget(
                title: AppLocalizations.of(context)!.translate("vehicle_info"),
                titles: [
                  AppLocalizations.of(context)!.translate("vehicle_no"),
                  AppLocalizations.of(context)!.translate("car_make"),
                  AppLocalizations.of(context)!.translate("car_model"),
                  AppLocalizations.of(context)!.translate("insurance_company"),
                  AppLocalizations.of(context)!
                      .translate("policy_certificate_no"),
                  AppLocalizations.of(context)!.translate("insured_nric"),
                  AppLocalizations.of(context)!.translate("insured_name"),
                  AppLocalizations.of(context)!
                      .translate("insured_contact_number")
                ],
                values: [
                  _accidentStore!.accident!.vehicle!.registrationNo ?? "-",
                  _accidentStore!.accident!.vehicle!.make ?? "-",
                  _accidentStore!.accident!.vehicle!.model ?? "-",
                  _accidentStore!.accident!.insuranceCompany ?? "-",
                  _accidentStore!.accident!.certificateNumber ?? "-",
                  _accidentStore!.accident!.insuredNric ?? "-",
                  _accidentStore!.accident!.insuredName ?? "-",
                  _accidentStore!.accident!.insuredContactNumber ?? "-",
                ]),
            Divider(height: 1, thickness: 2),
            SizedBox(height: 10),
            DetailWidget(
                title: AppLocalizations.of(context)!.translate("accident_info"),
                titles: [
                  AppLocalizations.of(context)!.translate("date_of_accident"),
                  AppLocalizations.of(context)!.translate("time_of_accident"),
                  AppLocalizations.of(context)!
                      .translate("location_of_accident"),
                  AppLocalizations.of(context)!
                      .translate("weather_road_surface"),
                  AppLocalizations.of(context)!.translate("reporting_type"),
                  AppLocalizations.of(context)!
                      .translate("number_of_passengers"),
                  AppLocalizations.of(context)!.translate("video_captured"),
                  AppLocalizations.of(context)!
                      .translate("purpose_vehicle_used")
                ],
                values: [
                  _accidentStore!.accident!.formatAccidentDate!,
                  _accidentStore!.accident!.formatAccidentTime!,
                  _accidentStore!.accident!.locationOfAccident!,
                  _accidentStore!.accident!.weatherRoadCondition!,
                  _accidentStore!.accident!.reportingType!,
                  _accidentStore!.accident!.numberOfPassengers.toString(),
                  _accidentStore!.accident!.isVideoCaptured == 1
                      ? AppLocalizations.of(context)!.translate("yes")
                      : AppLocalizations.of(context)!.translate("no"),
                  _accidentStore!.accident!.purposeOfUse!
                ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.translate("details"),
                    style: TextStyle(color: AppColors.greyColor)),
                SizedBox(height: 5),
                Text(
                    _accidentStore!.accident!.details != null
                        ? _accidentStore!.accident!.details!
                        : '-',
                    style: TextStyle(
                        color: AppColors.darkBlueColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20)
              ],
            ),
            Divider(height: 1, thickness: 2),
            SizedBox(height: 10),
            DetailWidget(
                title: AppLocalizations.of(context)!.translate("driver_info"),
                titles: [
                  AppLocalizations.of(context)!
                      .translate("vehicle_driven_by_owner"),
                  AppLocalizations.of(context)!
                      .translate("relationship_of_owner_driver"),
                  AppLocalizations.of(context)!.translate("driver_name"),
                  AppLocalizations.of(context)!.translate("driver_nric_uen"),
                  AppLocalizations.of(context)!.translate("driver_dob"),
                  AppLocalizations.of(context)!.translate("driver_license"),
                  AppLocalizations.of(context)!.translate("driver_address"),
                  AppLocalizations.of(context)!.translate("driver_contact_no"),
                  AppLocalizations.of(context)!
                      .translate("driver_email_address"),
                  AppLocalizations.of(context)!.translate("driver_occupation"),
                  AppLocalizations.of(context)!.translate("another_vehicle"),
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_vehicle_car_plate_no")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_vehicle_make")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_vehicle_model")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_driver_name")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_driver_nric")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_driver_contact_no")
                      : "",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!
                          .translate("other_driver_address")
                      : "",
                ],
                values: [
                  _accidentStore!.accident!.isOwnerDrives == 1
                      ? AppLocalizations.of(context)!.translate("yes")
                      : AppLocalizations.of(context)!.translate("no"),
                  _accidentStore!.accident!.ownerDriverRelationship ?? "-",
                  _accidentStore!.accident!.driverName ?? "-",
                  _accidentStore!.accident!.driverNric ?? "-",
                  _accidentStore!.accident!.formatDob ?? "-",
                  _accidentStore!.accident!.formatLicenseDate ?? "-",
                  _accidentStore!.accident!.driverAddress ?? "-",
                  _accidentStore!.accident!.driverContactNo ?? "-",
                  _accidentStore!.accident!.driverEmail ?? "-",
                  _accidentStore!.accident!.driverOccupation ?? "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? AppLocalizations.of(context)!.translate("yes")
                      : AppLocalizations.of(context)!.translate("no"),
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherVehicleCarPlate
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherVehicleMake
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherVehicleModel
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherDriverName
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherDriverNric
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherDriverContactNo
                      : "-",
                  _accidentStore!.accident!.isOtherVehicle == 1
                      ? _accidentStore!.accident!.otherDriverAddress
                      : "-",
                ]),
            Divider(height: 1, thickness: 2),
            SizedBox(height: 10),
            DetailWidget(
                title: AppLocalizations.of(context)!
                    .translate("inspection_appointment"),
                titles: [
                  AppLocalizations.of(context)!.translate("date"),
                  AppLocalizations.of(context)!.translate("time"),
                  AppLocalizations.of(context)!.translate("workshop"),
                  AppLocalizations.of(context)!.translate("service")
                ],
                values: [
                  _accidentStore!.accident!.formatAppointmentDate!,
                  _accidentStore!.accident!.formatAppointmentTime!,
                  _accidentStore!.accident!.workshop!.name!,
                  AppLocalizations.of(context)!.translate("accident_inspection")
                ]),
            _accidentStore!.accident!.documents != null &&
                    _accidentStore!.accident!.documents!.length > 0
                ? _buildPhotos()
                : Container()
          ]),
        )
      ],
    );
  }
}
