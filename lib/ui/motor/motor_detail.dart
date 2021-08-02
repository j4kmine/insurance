import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/motor/motor_buy.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/motor/motor_checkout.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/files_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MotorDetailScreen extends StatefulWidget {
  @override
  _MotorDetailScreenState createState() => _MotorDetailScreenState();
}

class _MotorDetailScreenState extends State<MotorDetailScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;
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
    _motorStore = Provider.of<MotorStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("motor_info")),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _motorStore!.getMotor(_motorStore!.motor!.id!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Observer(
      builder: (context) {
        return BodyWidget(
            height: _motorStore!.motor != null &&
                    _motorStore!.motor!.status == Strings.pendingAcceptance
                ? 220
                : 120,
            firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
            secondWidget: _buildMotor(),
            thirdWidget: _buildBuyMotor());
      },
    );
  }

  Widget _buildMotor() {
    if (_motorStore!.motorLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_motorStore!.motor != null)
          ? _buildMotorDetails()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_motor_found'),
                ),
              ),
            );
    }
  }

  Widget _buildBuyMotor() {
    return Observer(builder: (context) {
      return _motorStore!.motor != null &&
              _motorStore!.motor!.status == Strings.pendingAcceptance
          ? Positioned(
              top: MediaQuery.of(context).size.height - 200,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              height: 45,
              child: RoundedButtonWidget(
                  buttonColor: AppColors.successColor,
                  buttonText:
                      AppLocalizations.of(context)!.translate('check_out'),
                  textColor: Colors.white,
                  onPressed: () {
                    _motorStore!.checkoutSuccess = false;
                    _motorStore!.transferSuccess = false;
                    _motorStore!.status = '';
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MotorCheckOutScreen()));
                  }),
            )
          : Container();
    });
  }

  Widget _buildMotorDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                      _motorStore!.motor!.status == 'pending_admin_review'
                          ? AppLocalizations.of(context)!.translate("purchase")
                          : AppLocalizations.of(context)!
                              .translate("price_enquiry"),
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  StatusWidget(
                      title: AppLocalizations.of(context)!
                          .translate(_motorStore!.motor!.status!),
                      color: AppColors.successColor)
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 1, thickness: 2),
              SizedBox(height: 10),
              DetailWidget(
                  title:
                      AppLocalizations.of(context)!.translate("motor_details"),
                  titles: [
                    AppLocalizations.of(context)!.translate("ci_no"),
                    AppLocalizations.of(context)!.translate("price"),
                    AppLocalizations.of(context)!.translate("usage"),
                    AppLocalizations.of(context)!
                        .translate("insurance_start_date"),
                    AppLocalizations.of(context)!
                        .translate("insurance_expiry_date"),
                    AppLocalizations.of(context)!.translate("submitted_on"),
                  ],
                  values: [
                    _motorStore!.motor!.ciNo ?? "-",
                    _motorStore!.motor!.formatPrice ?? "-",
                    AppLocalizations.of(context)!
                        .translate(_motorStore!.motor!.usage ?? "-"),
                    _motorStore!.motor!.formatStartDate ?? "-",
                    _motorStore!.motor!.formatExpiryDate ?? "-",
                    _motorStore!.motor!.formatSubmittedAt ?? "-",
                  ]),
              Divider(height: 1, thickness: 2),
              SizedBox(height: 10),
              DetailWidget(
                  title: AppLocalizations.of(context)!
                      .translate("vehicle_details"),
                  titles: [
                    AppLocalizations.of(context)!.translate("vehicle_no"),
                    AppLocalizations.of(context)!.translate("car_make"),
                    AppLocalizations.of(context)!.translate("car_model"),
                    AppLocalizations.of(context)!.translate("car_type"),
                    AppLocalizations.of(context)!.translate("body_type"),
                    AppLocalizations.of(context)!.translate("chassis_no"),
                    AppLocalizations.of(context)!.translate("engine_no"),
                    AppLocalizations.of(context)!.translate("engine_capacity"),
                    AppLocalizations.of(context)!.translate("seating_capacity"),
                    AppLocalizations.of(context)!.translate("manufacture_year"),
                  ],
                  values: [
                    _motorStore!.motor!.vehicle!.registrationNo ?? "-",
                    _motorStore!.motor!.vehicle!.make ?? "-",
                    _motorStore!.motor!.vehicle!.model ?? "-",
                    AppLocalizations.of(context)!
                            .translate(_motorStore!.motor!.vehicle!.type) ??
                        "-",
                    AppLocalizations.of(context)!
                            .translate(_motorStore!.motor!.vehicle!.bodyType) ??
                        "-",
                    _motorStore!.motor!.vehicle!.chassisNo ?? "-",
                    _motorStore!.motor!.vehicle!.engineNo ?? "-",
                    _motorStore!.motor!.vehicle!.formatCapacity ?? "-",
                    _motorStore!.motor!.vehicle!.seatingCapacity.toString() ??
                        "-",
                    _motorStore!.motor!.vehicle!.manufactureYear.toString() ??
                        "-",
                  ]),
              _buildDetails(),
              _motorStore!.motor!.documents != null &&
                      _motorStore!.motor!.documents!.length > 0
                  ? _buildFiles()
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDetails() {
    List<Widget> widgets = [];
    for (var i = 0; i < _motorStore!.motor!.drivers!.length; i++) {
      widgets.add(Column(
        children: [
          Divider(height: 1, thickness: 2),
          SizedBox(height: 10),
          DetailWidget(
              title: i == 0
                  ? AppLocalizations.of(context)!.translate("main_driver")
                  : AppLocalizations.of(context)!
                          .translate("additional_driver") +
                      " " +
                      (i + 1).toString(),
              titles: [
                AppLocalizations.of(context)!.translate("name"),
                AppLocalizations.of(context)!.translate("id_type"),
                AppLocalizations.of(context)!.translate("id_number"),
                AppLocalizations.of(context)!.translate("gender"),
                AppLocalizations.of(context)!.translate("nationality"),
                AppLocalizations.of(context)!.translate("residential"),
                AppLocalizations.of(context)!.translate("date_of_birth"),
                AppLocalizations.of(context)!.translate("date_of_license"),
                AppLocalizations.of(context)!.translate("number_of_accident"),
                AppLocalizations.of(context)!.translate("total_claim_amount"),
              ],
              values: [
                _motorStore!.motor!.drivers![i].name ?? "-",
                _motorStore!.motor!.drivers![i].formatIdType ?? "-",
                _motorStore!.motor!.drivers![i].idNumber ?? "-",
                AppLocalizations.of(context)!
                        .translate(_motorStore!.motor!.drivers![i].gender) ??
                    "-",
                _motorStore!.motor!.drivers![i].formatNationality ?? "-",
                _motorStore!.motor!.drivers![i].formatResidential ?? "-",
                _motorStore!.motor!.drivers![i].formatDob ?? "-",
                _motorStore!.motor!.drivers![i].formatDol ?? "-",
                _motorStore!.motor!.drivers![i].noOfAccidents ?? "-",
                _motorStore!.motor!.drivers![i].totalClaimAmount ?? "-",
              ])
        ],
      ));
    }
    return Column(children: widgets);
  }

  Widget _buildFiles() {
    List<String> paths = <String>[];
    List<String> types = <String>[];
    for (var i = 0; i < _motorStore!.motor!.documents!.length; i++) {
      types.add(_motorStore!.motor!.documents![i].type!);
      paths.add(_motorStore!.motor!.documents![i].view!);
    }
    return Column(
      children: [
        Divider(height: 1, thickness: 2),
        SizedBox(height: 10),
        FilesWidget(
            title: AppLocalizations.of(context)!.translate("documents"),
            titles: types,
            values: paths)
      ],
    );
  }
}
