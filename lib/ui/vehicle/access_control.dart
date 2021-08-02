import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/models/accident/accident.dart';
import 'package:boilerplate/models/customer/customer.dart';
import 'package:boilerplate/models/vehicle/access.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/accident/accident_detail.dart';
import 'package:boilerplate/ui/vehicle/access_control_create.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AccessControlScreen extends StatefulWidget {
  @override
  _AccessControlScreenState createState() => _AccessControlScreenState();
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  //stores:---------------------------------------------------------------------
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
    _vehicleStore = Provider.of<VehicleStore>(context);

    // check to see if already called api
    if (!_vehicleStore!.accessLoading) {
      _vehicleStore!.getAccess(_vehicleStore!.vehicleId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'access_control'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () =>
                _vehicleStore!.getAccess(_vehicleStore!.vehicleId!),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _vehicleStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildAddUser());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_vehicleStore!.accessLoading || _vehicleStore!.deleteLoading) {
          return CustomProgressIndicatorWidget();
        } else {
          return (_vehicleStore!.access != null)
              ? Column(
                  children: [
                    ListWidget(
                        count: _vehicleStore!.access!.owners!.length +
                            _vehicleStore!.access!.users!.length,
                        itemBuilder: (context, position) {
                          if (_vehicleStore!.access!.owners!.length >
                              position) {
                            return _buildAccidentTile(
                                _vehicleStore!.access!.owners![position], true);
                          } else {
                            return _buildAccidentTile(
                                _vehicleStore!.access!.users![position -
                                    _vehicleStore!.access!.owners!.length],
                                false);
                          }
                        }),
                    _vehicleStore!.deleteSuccess
                        ? _showSuccessMessage(
                            _vehicleStore!.successStore.successMessage)
                        : Container()
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('no_access_control_found'),
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildAccidentTile(Customer customer, bool owner) {
    String topLeft = customer.name!;
    String topRight = owner
        ? AppLocalizations.of(context)!.translate("owner")
        : AppLocalizations.of(context)!.translate("user");
    String bottomLeft = customer.nricUen!;
    String bottomRight = customer.phone!;
    return ListTileWidget(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        dropdown: true,
        selected: (str) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Are you sure you want to delete user?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        //Put your code here which you want to execute on Yes button click.
                        _vehicleStore!.deleteAccess(
                            customer!.nricUen!, _vehicleStore!.vehicleId!);
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
            ));
  }

  _showSuccessMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context)!.translate('home_tv_success'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
      _vehicleStore!.deleteSuccess = false;
    });

    return SizedBox.shrink();
  }

  Widget _buildAddUser() {
    return Observer(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: RoundedButtonWidget(
            buttonColor: AppColors.secondaryColor,
            buttonText: AppLocalizations.of(context)!.translate('add_user'),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccessControlCreateScreen()));
            }),
      );
    });
  }
}
