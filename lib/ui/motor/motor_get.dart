import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/motor/motor_search_car.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/motor/motor.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MotorGetScreen extends StatefulWidget {
  @override
  _MotorGetScreenState createState() => _MotorGetScreenState();
}

class _MotorGetScreenState extends State<MotorGetScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var categories = ["fill_in_form", "receive_multiple_quotes", "pick_and_save"];

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
    if (!_motorStore!.pendingMotorsLoading) {
      _motorStore!.getPendingMotors();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SecondaryAppBarWidget(text: 'get_insurance'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _motorStore!.getMotors(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 240,
        firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildMotorGet());
  }

  Widget _buildMainContent() {
    return Column(children: [
      _buildMotorBanner(),
      _buildPendingHeader(),
      Observer(
        builder: (context) {
          return _buildVehicle();
        },
      ),
      SizedBox(height: 10),
      _buildCategoryHeader(),
      _buildCategory()
    ]);
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
              Text(AppLocalizations.of(context)!.translate("pending"),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              InkWell(
                onTap: () {
                  _motorStore!.getMotors();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MotorListScreen()));
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

  Widget _buildCategory() {
    return Column(
        children: List.generate(categories.length, (index) {
      return _buildCategoryTile(categories[index]);
    }));
  }

  Widget _buildCategoryTile(String title) {
    return PrimaryCardWidget(
      img: SvgPicture.asset('assets/icons/ic_' + title + '.svg'),
      title: AppLocalizations.of(context)!.translate(title),
      caption: AppLocalizations.of(context)!.translate(title + "_description"),
    );
  }

  Widget _buildMotorBanner() {
    return CardWidget(
        img: 'assets/icons/ic_get_quotes_and_save.svg',
        headline: 'get_quotes_and_save',
        caption: 'auction_to_500_dealers',
        firstDetail: 'warranty_description_1',
        secondDetail: 'warranty_description_2');
  }

  Widget _buildCategoryHeader() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(AppLocalizations.of(context)!.translate("car_compare"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildVehicle() {
    if (_motorStore!.pendingMotorsLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return (_motorStore!.pendingMotorList != null &&
              _motorStore!.pendingMotorList!.motors!.length > 0)
          ? ListWidget(
              count: _motorStore!.pendingMotorList!.motors!.length,
              itemBuilder: (context, position) {
                return _buildMotorTile(
                    _motorStore!.pendingMotorList!.motors![position]);
              })
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_insurance_found'),
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

  Widget _buildMotorGet() {
    return Positioned(
      top: MediaQuery.of(context).size.height - 220,
      left: 20,
      width: MediaQuery.of(context).size.width - 40,
      height: 45,
      child: RoundedButtonWidget(
        buttonColor: AppColors.secondaryColor,
        buttonText:
            AppLocalizations.of(context)!.translate('get_insurance_quote'),
        textColor: Colors.white,
        onPressed: () {
          _motorStore!.searchCarResult = MotorSearchCar();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MotorQuoteScreen()));
        },
      ),
    );
  }
}
