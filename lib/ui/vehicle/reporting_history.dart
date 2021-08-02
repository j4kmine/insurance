import 'package:boilerplate/models/accident/accident.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/accident/accident_detail.dart';
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

class ReportingHistoryScreen extends StatefulWidget {
  @override
  _ReportingHistoryScreenState createState() => _ReportingHistoryScreenState();
}

class _ReportingHistoryScreenState extends State<ReportingHistoryScreen> {
  //stores:---------------------------------------------------------------------
  AccidentStore? _accidentStore;
  VehicleStore? _vehicleStore;
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
    _accidentStore = Provider.of<AccidentStore>(context);
    _vehicleStore = Provider.of<VehicleStore>(context);

    // check to see if already called api
    if (!_accidentStore!.vehicleAccidentsLoading) {
      _accidentStore!
          .getVehicleAccidents(_vehicleStore!.vehicle!.registrationNo!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'reporting_history'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _accidentStore!
                .getVehicleAccidents(_vehicleStore!.vehicle!.registrationNo!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _accidentStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_accidentStore!.vehicleAccidentsLoading) {
          return CustomProgressIndicatorWidget();
        } else {
          return (_accidentStore!.vehicleAccidentList != null &&
                  _accidentStore!.vehicleAccidentList!.accidents!.length > 0)
              ? ListWidget(
                  count: _accidentStore!.vehicleAccidentList!.accidents!.length,
                  itemBuilder: (context, position) {
                    return _buildAccidentTile(_accidentStore!
                        .vehicleAccidentList!.accidents![position]);
                  })
              : Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('no_report_found'),
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildAccidentTile(Accident accident) {
    String topLeft = accident.refNo;
    String topRight = accident.vehicle!.registrationNo!;
    String bottomLeft = accident.workshop!.name!;
    String bottomRight = accident.createdAt!;
    return ListTileWidget(
        onTap: () {
          _accidentStore!.getAccident(accident.id!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AccidentDetailScreen()));
        },
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight);
  }
}
