import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:boilerplate/widgets/tertiary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ServicingStatusScreen extends StatefulWidget {
  @override
  _ServicingStatusScreenState createState() => _ServicingStatusScreenState();
}

class _ServicingStatusScreenState extends State<ServicingStatusScreen> {
  //stores:---------------------------------------------------------------------
  ServicingStore? _servicingStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _servicingStore = Provider.of<ServicingStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TertiaryAppBarWidget(text: 'servicing_details'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 135,
        firstWidget: ErrorStoreWidget(errorStore: _servicingStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPaymentDetails();
      },
    );
  }

  Widget _buildPaymentDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(AppLocalizations.of(context)!.translate("appointment"),
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.translate("confirmed"),
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Image(image: AssetImage('assets/icons/ic_confirmed.png')),
          SizedBox(height: 30),
          DetailWidget(
              title:
                  AppLocalizations.of(context)!.translate("servicing_details"),
              titles: [
                AppLocalizations.of(context)!.translate("date"),
                AppLocalizations.of(context)!.translate("time"),
                AppLocalizations.of(context)!.translate("workshop"),
                AppLocalizations.of(context)!.translate("service"),
                AppLocalizations.of(context)!.translate("vehicle_no"),
                AppLocalizations.of(context)!.translate("car_make"),
                AppLocalizations.of(context)!.translate("car_model"),
                AppLocalizations.of(context)!.translate("remarks")
              ],
              values: [
                _servicingStore!.service!.formatAppointmentDate ?? "-",
                _servicingStore!.service!.formatAppointmentTime ?? "-",
                _servicingStore!.service!.workshop!.name ?? "-",
                _servicingStore!.service!.serviceType!.name ?? "-",
                _servicingStore!.service!.vehicle!.registrationNo ?? "-",
                _servicingStore!.service!.vehicle!.make ?? "-",
                _servicingStore!.service!.vehicle!.model ?? "-",
                _servicingStore!.service!.remarks ?? "-"
              ])
        ],
      ),
    );
  }
}
