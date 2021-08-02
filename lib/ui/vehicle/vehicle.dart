import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/models/document/document_list.dart';
import 'package:boilerplate/models/vehicle/access.dart';
import 'package:boilerplate/stores/document/document_store.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/vehicle/access_control.dart';
import 'package:boilerplate/ui/vehicle/insurance_policy.dart';
import 'package:boilerplate/ui/vehicle/reporting_history.dart';
import 'package:boilerplate/ui/vehicle/servicing_history.dart';
import 'package:boilerplate/ui/vehicle/warranty_booklet.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  //stores:---------------------------------------------------------------------
  VehicleStore? _vehicleStore;
  DocumentStore? _documentStore;
  ServicingStore? _servicingStore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var categories = [
    'insurance_policy',
    'warranty_booklet',
    'servicing_history',
    'reporting_history',
    'access_control'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _vehicleStore = Provider.of<VehicleStore>(context);
    _documentStore = Provider.of<DocumentStore>(context);
    _servicingStore = Provider.of<ServicingStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(text: 'vehicle_info'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () =>
                _vehicleStore!.getVehicle(_vehicleStore!.vehicleId!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _vehicleStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _vehicleStore!.vehicleLoading
            ? CustomProgressIndicatorWidget()
            : _buildVehicleContainer();
      },
    );
  }

  Widget _buildVehicleContainer() {
    return _vehicleStore!.vehicle != null
        ? Column(children: [
            _buildVehicle(),
            _buildCategoryHeader(),
            _buildCategory(),
          ])
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildVehicle() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            _buildVehicleDetails(),
            Divider(height: 1, thickness: 2),
            _buildOtherInfoContent(),
            Divider(height: 1, thickness: 2),
          ],
        ));
  }

  Widget _buildVehicleDetails() {
    return DetailWidget(
        title: AppLocalizations.of(context)!.translate("vehicle_details"),
        titles: [
          AppLocalizations.of(context)!.translate("vehicle_no"),
          AppLocalizations.of(context)!.translate("vehicle_model"),
          AppLocalizations.of(context)!.translate("coe_expiry"),
          AppLocalizations.of(context)!.translate("vehicle_make"),
          AppLocalizations.of(context)!.translate("vehicle_first_reg_date"),
          AppLocalizations.of(context)!.translate("vehicle_road_tax_exp_date")
        ],
        values: [
          _vehicleStore!.vehicle!.registrationNo!,
          _vehicleStore!.vehicle!.model!,
          _vehicleStore!.vehicle!.coeExpiryDate,
          _vehicleStore!.vehicle!.make!,
          _vehicleStore!.vehicle!.formatRegistrationDate!,
          _vehicleStore!.vehicle!.taxExpiryDate
        ]);
  }

  Widget _buildOtherInfoContent() {
    return DetailWidget(
        title: AppLocalizations.of(context)!.translate("other_information"),
        titles: [
          AppLocalizations.of(context)!.translate("warranty_validity"),
          AppLocalizations.of(context)!.translate("insurance_validity"),
          AppLocalizations.of(context)!.translate("last_servicing"),
        ],
        values: [
          _vehicleStore!.vehicle!.warrantyValidity,
          _vehicleStore!.vehicle!.motorValidity,
          _vehicleStore!.vehicle!.lastServicing
        ]);
  }

  Widget _buildCategoryHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      child: Text(AppLocalizations.of(context)!.translate("vehicle_management"),
          style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCategory() {
    return GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        // Remove nested scrolling
        primary: true,
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        children: List.generate(categories.length, (index) {
          return _buildCategoryTile(categories[index]);
        }));
  }

  Widget _buildCategoryTile(String title) {
    return InkWell(
      onTap: () {
        if (title == 'insurance_policy') {
          _documentStore!.documentList = DocumentList();
          _documentStore!.getVehicleInsurance(_vehicleStore!.vehicle!.id!);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InsuranceScreen()));
        } else if (title == 'warranty_booklet') {
          _documentStore!.documentList = DocumentList();
          _documentStore!.getVehicleWarranty(_vehicleStore!.vehicle!.id!);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => WarrantyScreen()));
        } else if (title == 'servicing_history') {
          _servicingStore!
              .getVehicleServices(_vehicleStore!.vehicle!.registrationNo!);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ServicingHistoryScreen()));
        } else if (title == 'reporting_history') {
          _servicingStore!
              .getVehicleServices(_vehicleStore!.vehicle!.registrationNo!);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReportingHistoryScreen()));
        } else if (title == 'access_control') {
          _vehicleStore!.access = Access();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AccessControlScreen()));
        }
      },
      child: Column(
        children: [
          SvgPicture.asset('assets/icons/ic_' + title + '.svg'),
          SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.translate(title),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
