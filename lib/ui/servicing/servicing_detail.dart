import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/ui/servicing/servicing_reschedule.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/files_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ServicingDetailScreen extends StatefulWidget {
  @override
  _ServicingDetailScreenState createState() => _ServicingDetailScreenState();
}

class _ServicingDetailScreenState extends State<ServicingDetailScreen> {
  //stores:---------------------------------------------------------------------
  ServicingStore? _servicingStore;
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
    _servicingStore = Provider.of<ServicingStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            text: AppLocalizations.of(context)!.translate("servicing_info")),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () =>
                _servicingStore!.getService(_servicingStore!.service!.id!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return BodyWidget(
          height: _servicingStore!.service != null &&
                  _servicingStore!.service!.status == Strings.upcoming
              ? 220
              : 120,
          firstWidget:
              ErrorStoreWidget(errorStore: _servicingStore!.errorStore),
          secondWidget: _buildMainContent(),
          thirdWidget: _buildServicingAction());
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildServicing();
      },
    );
  }

  Widget _buildServicing() {
    if (_servicingStore!.serviceLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_servicingStore!.service != null)
          ? _buildServicingDetails()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_servicing_found'),
                ),
              ),
            );
    }
  }

  Widget _buildServicingAction() {
    return Observer(builder: (context) {
      return _servicingStore!.service != null &&
              _servicingStore!.service!.status == Strings.upcoming
          ? Positioned(
              top: MediaQuery.of(context).size.height - 200,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              height: 45,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: RoundedButtonWidget(
                        loading: _servicingStore!.updateLoading,
                        enabled: !_servicingStore!.updateLoading,
                        buttonColor: AppColors.dangerColor,
                        buttonText:
                            AppLocalizations.of(context)!.translate('cancel'),
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to cancel appointment?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("YES"),
                                    onPressed: () {
                                      //Put your code here which you want to execute on Yes button click.
                                      _servicingStore!.cancelService(
                                          _servicingStore!.service!.id!);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("NO"),
                                    onPressed: () {
                                      //Put your code here which you want to execute on No button click.
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: RoundedButtonWidget(
                          loading: _servicingStore!.updateLoading,
                          enabled: !_servicingStore!.updateLoading,
                          buttonColor: AppColors.secondaryColor,
                          buttonText: AppLocalizations.of(context)!
                              .translate('reschedule'),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ServicingRescheduleScreen()));
                          })),
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildServicingDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.translate("car_servicing"),
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                StatusWidget(
                    title: AppLocalizations.of(context)!
                        .translate(_servicingStore!.service!.status!),
                    color: _servicingStore!.service!.status == 'cancelled'
                        ? AppColors.dangerColor
                        : AppColors.successColor)
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 1, thickness: 2),
            SizedBox(height: 10),
            DetailWidget(
                title: AppLocalizations.of(context)!
                    .translate("servicing_details"),
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
                ]),
            SizedBox(height: 10),
            _buildFiles()
          ]),
        )
      ],
    );
  }

  Widget _buildFiles() {
    List<String> paths = <String>[];
    List<String> types = <String>[];
    if (_servicingStore!.service!.documents != null) {
      for (var i = 0; i < _servicingStore!.service!.documents!.length; i++) {
        types.add(_servicingStore!.service!.documents![i].type == null
            ? 'file'
            : _servicingStore!.service!.documents![i].type!);
        paths.add(_servicingStore!.service!.documents![i].view!);
      }
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
