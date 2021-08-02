import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/warranty/warranty_buy.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/warranty/warranty_buy.dart';
import 'package:boilerplate/ui/warranty/warranty_checkout.dart';
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

class WarrantyDetailScreen extends StatefulWidget {
  @override
  _WarrantyDetailScreenState createState() => _WarrantyDetailScreenState();
}

class _WarrantyDetailScreenState extends State<WarrantyDetailScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;
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
    _warrantyStore = Provider.of<WarrantyStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("warranty_info")),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () =>
                _warrantyStore!.getWarranty(_warrantyStore!.warranty!.id!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return BodyWidget(
          height: _warrantyStore!.warranty != null &&
                  _warrantyStore!.warranty!.status == Strings.pendingAcceptance
              ? 220
              : 120,
          firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
          secondWidget: _buildMainContent(),
          thirdWidget: _buildBuyWarranty());
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildWarranty();
      },
    );
  }

  Widget _buildWarranty() {
    if (_warrantyStore!.warrantyLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_warrantyStore!.warranty != null)
          ? _buildWarrantyDetails()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_warranty_found'),
                ),
              ),
            );
    }
  }

  Widget _buildBuyWarranty() {
    return Observer(builder: (context) {
      return _warrantyStore!.warranty != null &&
              _warrantyStore!.warranty!.status == Strings.pendingAcceptance
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
                    _warrantyStore!.checkoutSuccess = false;
                    _warrantyStore!.transferSuccess = false;
                    _warrantyStore!.status = '';
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WarrantyCheckOutScreen()));
                  }),
            )
          : Container();
    });
  }

  Widget _buildWarrantyDetails() {
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
                      _warrantyStore!.warranty!.status == 'pending_admin_review'
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
                          .translate(_warrantyStore!.warranty!.status!),
                      color: AppColors.successColor)
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 1, thickness: 2),
              SizedBox(height: 10),
              DetailWidget(
                  title: AppLocalizations.of(context)!
                      .translate("warranty_details"),
                  titles: [
                    AppLocalizations.of(context)!.translate("package"),
                    AppLocalizations.of(context)!.translate("price"),
                    AppLocalizations.of(context)!
                        .translate("max_claim_per_year"),
                    AppLocalizations.of(context)!.translate("mileage_coverage"),
                    AppLocalizations.of(context)!
                        .translate("proposed_warranty_start_date"),
                    AppLocalizations.of(context)!.translate("submitted_on"),
                  ],
                  values: [
                    _warrantyStore!.warranty!.package!,
                    _warrantyStore!.warranty!.formatPrice!,
                    _warrantyStore!.warranty!.formatMaxClaim!,
                    _warrantyStore!.warranty!.formatMileageCoverage!,
                    _warrantyStore!.warranty!.formatStartDate!,
                    _warrantyStore!.warranty!.formatSubmittedAt!,
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
                    AppLocalizations.of(context)!.translate("fuel_type"),
                    AppLocalizations.of(context)!.translate("car_category"),
                    AppLocalizations.of(context)!.translate("chassis_no"),
                    AppLocalizations.of(context)!.translate("engine_no"),
                    AppLocalizations.of(context)!.translate("engine_capacity"),
                    AppLocalizations.of(context)!
                        .translate("registration_date"),
                    AppLocalizations.of(context)!.translate("manufacture_year"),
                  ],
                  values: [
                    _warrantyStore!.warranty!.vehicle!.registrationNo!,
                    _warrantyStore!.warranty!.vehicle!.make!,
                    _warrantyStore!.warranty!.vehicle!.model!,
                    AppLocalizations.of(context)!
                        .translate(_warrantyStore!.warranty!.vehicle!.type),
                    AppLocalizations.of(context)!
                        .translate(_warrantyStore!.warranty!.vehicle!.fuel),
                    _warrantyStore!.warranty!.vehicle!.category,
                    _warrantyStore!.warranty!.vehicle!.chassisNo!,
                    _warrantyStore!.warranty!.vehicle!.engineNo,
                    _warrantyStore!.warranty!.vehicle!.formatCapacity!,
                    _warrantyStore!.warranty!.vehicle!.formatRegistrationDate!,
                    _warrantyStore!.warranty!.vehicle!.manufactureYear
                        .toString(),
                  ]),
              Divider(height: 1, thickness: 2),
              SizedBox(height: 10),
              DetailWidget(
                  title: AppLocalizations.of(context)!
                      .translate("customer_details"),
                  titles: [
                    AppLocalizations.of(context)!.translate("salutation"),
                    AppLocalizations.of(context)!.translate("name"),
                    AppLocalizations.of(context)!.translate("nric_uen_number"),
                    AppLocalizations.of(context)!.translate("email"),
                    AppLocalizations.of(context)!.translate("contact_no"),
                    AppLocalizations.of(context)!.translate("address"),
                  ],
                  values: [
                    _warrantyStore!.warranty!.proposer!.salutation!,
                    _warrantyStore!.warranty!.proposer!.name!,
                    _warrantyStore!.warranty!.proposer!.nricUen!,
                    _warrantyStore!.warranty!.proposer!.email!,
                    _warrantyStore!.warranty!.proposer!.phone!,
                    _warrantyStore!.warranty!.proposer!.address!,
                  ]),
              _buildFiles()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFiles() {
    List<String> paths = <String>[];
    List<String> types = <String>[];
    for (var i = 0; i < _warrantyStore!.warranty!.documents!.length; i++) {
      types.add(_warrantyStore!.warranty!.documents![i].type!);
      paths.add(_warrantyStore!.warranty!.documents![i].view!);
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
