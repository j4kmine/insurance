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

class AccidentStatusScreen extends StatefulWidget {
  @override
  _AccidentStatusScreenState createState() => _AccidentStatusScreenState();
}

class _AccidentStatusScreenState extends State<AccidentStatusScreen> {
  //stores:---------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TertiaryAppBarWidget(text: 'submitted'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 135,
        firstWidget: Container(),
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
          Text(AppLocalizations.of(context)!.translate("accident_success_1"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Image(image: AssetImage('assets/icons/ic_confirmed.png')),
          SizedBox(height: 30),
          Text(AppLocalizations.of(context)!.translate("accident_success_2"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
