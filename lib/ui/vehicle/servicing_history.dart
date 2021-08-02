import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/servicing/servicing_detail.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ServicingHistoryScreen extends StatefulWidget {
  @override
  _ServicingHistoryScreenState createState() => _ServicingHistoryScreenState();
}

class _ServicingHistoryScreenState extends State<ServicingHistoryScreen> {
  //stores:---------------------------------------------------------------------
  ServicingStore? _servicingStore;
  VehicleStore? _vehicleStore;
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
    _servicingStore = Provider.of<ServicingStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);

    // check to see if already called api
    if (!_servicingStore!.vehicleServicesLoading) {
      _servicingStore!
          .getVehicleServices(_vehicleStore!.vehicle!.registrationNo!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'servicing_history'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _servicingStore!
                .getVehicleServices(_vehicleStore!.vehicle!.registrationNo!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _servicingStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_servicingStore!.servicesLoading) {
          return CustomProgressIndicatorWidget();
        } else {
          return (_servicingStore!.vehicleServiceList != null &&
                  _servicingStore!.vehicleServiceList!.services!.length > 0)
              ? ListWidget(
                  count: _servicingStore!.vehicleServiceList!.services!.length,
                  itemBuilder: (context, position) {
                    return _buildServicingTile(_servicingStore!
                        .vehicleServiceList!.services![position]);
                  })
              : Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('no_servicing_found'),
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildServicingTile(Service servicing) {
    String topLeft = AppLocalizations.of(context)!.translate("car_servicing");
    String topRight =
        AppLocalizations.of(context)!.translate(servicing.status!);
    String bottomLeft = servicing.workshop!.name!;
    String bottomRight = servicing.formatAppointmentDate.toString();

    if (servicing.vehicle != null) {
      topLeft += ": " + servicing.vehicle!.registrationNo!;
    }
    return ListTileWidget(
        onTap: () {
          _servicingStore!.getService(servicing.id!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServicingDetailScreen()));
        },
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight);
  }
}
