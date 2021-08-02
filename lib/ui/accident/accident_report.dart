import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/accident/accident_process.dart';
import 'package:boilerplate/ui/motor/motor_detail.dart';
import 'package:boilerplate/ui/motor/motor_list.dart';
import 'package:boilerplate/ui/motor/motor_quote.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/card_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/primary_card_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ReportAccidentScreen extends StatefulWidget {
  @override
  _ReportAccidentScreenState createState() => _ReportAccidentScreenState();
}

class _ReportAccidentScreenState extends State<ReportAccidentScreen> {
  //stores:---------------------------------------------------------------------

  var categories = ["fill_in_form", "receive_multiple_quotes", "pick_and_save"];
  AccidentStore? _accidentStore;

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
        appBar: SecondaryAppBarWidget(text: 'report_accident'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 240,
        firstWidget: Container(),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildReportAccident());
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            AppLocalizations.of(context)!
                .translate("report_accident_description"),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(
            AppLocalizations.of(context)!
                .translate("do_not_accident_description"),
            style: TextStyle(
                color: AppColors.dangerColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Text(AppLocalizations.of(context)!.translate("accident_description_1"),
            style: TextStyle(color: AppColors.dangerColor)),
        SizedBox(height: 15),
        Text(AppLocalizations.of(context)!.translate("accident_description_2"),
            style: TextStyle(color: AppColors.dangerColor)),
        SizedBox(height: 15),
        Text(AppLocalizations.of(context)!.translate("accident_description_3"),
            style: TextStyle(color: AppColors.dangerColor)),
        SizedBox(height: 15),
        Text(AppLocalizations.of(context)!.translate("accident_description_4")),
        SizedBox(height: 15),
        Text(AppLocalizations.of(context)!.translate("accident_description_5")),
      ]),
    );
  }

  Widget _buildReportAccident() {
    return Positioned(
      top: MediaQuery.of(context).size.height - 220,
      left: 20,
      width: MediaQuery.of(context).size.width - 40,
      height: 45,
      child: RoundedButtonWidget(
        buttonColor: AppColors.secondaryColor,
        buttonText: AppLocalizations.of(context)!.translate('start_reporting'),
        textColor: Colors.white,
        onPressed: () {
          _accidentStore!.accidentSceneFiles = [];
          _accidentStore!.vehicleCarPlateFiles = [];
          _accidentStore!.closeRangeDamageFiles = [];
          _accidentStore!.longRangeDamageFiles = [];
          _accidentStore!.otherDrivingLicenseFiles = [];
          _accidentStore!.otherVehicleCarPlateFiles = [];
          _accidentStore!.otherCloseRangeDamageFiles = [];
          _accidentStore!.otherLongRangeDamageFiles = [];
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProcessScreen()));
        },
      ),
    );
  }
}
