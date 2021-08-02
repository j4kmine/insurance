import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:boilerplate/widgets/tertiary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MotorStatusScreen extends StatefulWidget {
  @override
  _MotorStatusScreenState createState() => _MotorStatusScreenState();
}

class _MotorStatusScreenState extends State<MotorStatusScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;

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
        appBar: TertiaryAppBarWidget(text: 'transaction_details'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 135,
        firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildPriceTile());
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
          Text(AppLocalizations.of(context)!.translate("payment"),
              style: TextStyle(
                  fontSize: 18,
                  color: _motorStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.translate(_motorStore!.status),
              style: TextStyle(
                  fontSize: 18,
                  color: _motorStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Image(
              image: AssetImage(
                  'assets/icons/ic_' + _motorStore!.status + '.png')),
          SizedBox(height: 30),
          Text(
              AppLocalizations.of(context)!
                  .translate(_motorStore!.status + "_description"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: _motorStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPriceTile() {
    return Positioned(
        top: MediaQuery.of(context).size.height - 320,
        width: MediaQuery.of(context).size.width,
        child: SecondaryCardWidget(
            img: Image.network(
                Endpoints.images +
                    "/" +
                    _motorStore!.motor!.insurerCode! +
                    ".png",
                width: 75),
            title: _motorStore!.motor!.formatPrice ?? "-",
            caption: _motorStore!.motor!.vehicle!.make ?? "-",
            heading: AppLocalizations.of(context)!.translate("motor_insurance"),
            firstKey: AppLocalizations.of(context)!.translate("ci_no"),
            secondKey: AppLocalizations.of(context)!.translate("car_type"),
            firstValue: _motorStore!.motor!.ciNo ?? "-",
            secondValue: AppLocalizations.of(context)!
                .translate(_motorStore!.motor!.vehicle!.type ?? "-")));
  }
}
