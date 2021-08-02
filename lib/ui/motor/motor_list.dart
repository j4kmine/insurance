import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/motor/motor_detail.dart';
import 'package:boilerplate/ui/motor/motor_quote.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/card_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MotorListScreen extends StatefulWidget {
  @override
  _MotorListScreenState createState() => _MotorListScreenState();
}

class _MotorListScreenState extends State<MotorListScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

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
    _motorStore = Provider.of<MotorStore>(context);

    // check to see if already called api
    if (!_motorStore!.motorsLoading) {
      _motorStore!.getMotors();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'all_motors'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _motorStore!.getMotors(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Column(children: [
      Observer(
        builder: (context) {
          return _buildMotors();
        },
      ),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildMotors() {
    if (_motorStore!.motorsLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_motorStore!.motorList != null &&
              _motorStore!.motorList!.motors!.length > 0)
          ? ListWidget(
              count: _motorStore!.motorList!.motors!.length,
              itemBuilder: (context, position) {
                return _buildMotorTile(
                    _motorStore!.motorList!.motors![position]);
              })
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

  Widget _buildMotorTile(Motor motor) {
    String topLeft = AppLocalizations.of(context)!.translate("price_enquiry");
    String topRight = AppLocalizations.of(context)!.translate(motor.status!);
    String bottomLeft = AppLocalizations.of(context)!.translate("valid_till") +
        " " +
        motor.formatValidTill!;
    String bottomRight = motor.formatPrice!;
    if (motor.status == 'pending_admin_review') {
      topLeft = AppLocalizations.of(context)!.translate("purchase");
      bottomLeft = AppLocalizations.of(context)!.translate("submitted_on") +
          " " +
          motor.formatSubmittedAt!;
    }

    if (motor.vehicle != null && motor.vehicle!.registrationNo != null) {
      topLeft += ": " + motor.vehicle!.registrationNo!;
    }
    return ListTileWidget(
        onTap: () {
          _motorStore!.getMotor(motor.id!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MotorDetailScreen()));
        },
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight);
  }
}
