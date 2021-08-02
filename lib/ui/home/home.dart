import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/accident/accident_report.dart';
import 'package:boilerplate/ui/motor/motor_get.dart';
import 'package:boilerplate/ui/roadside/roadside.dart';
import 'package:boilerplate/ui/servicing/servicing_book.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/warranty/warranty_get.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  VehicleStore? _vehicleStore;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var categories = [
    'book_servicing',
    'get_insurance',
    'get_warranty',
    'report_accident',
    'roadside_assistance'
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

    // check to see if already called api
    if (!_vehicleStore!.vehicleSummaryLoading) {
      _vehicleStore!.getVehicleSummary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(text: 'home'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _vehicleStore!.getVehicleSummary(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _vehicleStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Column(children: [
      Observer(
        builder: (context) {
          return _buildBanner();
        },
      ),
      _buildCategory(),
      _buildVehicleHeader(),
      Observer(
        builder: (context) {
          return _buildVehicle();
        },
      ),
      SizedBox(height: 10),
    ]);
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
        if (title == 'get_insurance') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MotorGetScreen()));
        } else if (title == 'get_warranty') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WarrantyGetScreen()));
        } else if (title == 'book_servicing') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServicingBookScreen()));
        } else if (title == 'roadside_assistance') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RoadSideScreen()));
        } else if (title == 'report_accident') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReportAccidentScreen()));
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

  Widget _buildBanner() {
    // To change to banner loading
    return Container(
      height: 130,
      child: _vehicleStore!.vehicleSummaryLoading
          ? MiniProgressIndicatorWidget()
          : GridView.count(
              childAspectRatio: 130 / 245,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              children: List.generate(2, (index) {
                return Image(
                  image: AssetImage(
                      'assets/images/img_banner_' + index.toString() + '.png'),
                );
              })),
    );
  }

  Widget _buildVehicleHeader() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(AppLocalizations.of(context)!.translate("my_vehicles"),
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Divider(height: 1, thickness: 2)
      ]),
    );
  }

  Widget _buildVehicle() {
    if (_vehicleStore!.vehicleSummaryLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return (_vehicleStore!.vehicleSummary != null &&
              _vehicleStore!.vehicleSummary!.owned != null &&
              _vehicleStore!.vehicleSummary!.grantedAccess != null &&
              (_vehicleStore!.vehicleSummary!.owned!.length > 0 ||
                  _vehicleStore!.vehicleSummary!.grantedAccess!.length > 0))
          ? GridView.count(
              physics: new NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: 0.8,
              crossAxisCount: 4,
              children: List.generate(
                  _vehicleStore!.vehicleSummary!.owned!.length +
                      _vehicleStore!.vehicleSummary!.grantedAccess!.length,
                  (index) {
                if (index < _vehicleStore!.vehicleSummary!.owned!.length) {
                  return _buildVehicleTile(
                      _vehicleStore!.vehicleSummary!.owned![index], 1);
                } else {
                  return _buildVehicleTile(
                      _vehicleStore!.vehicleSummary!.grantedAccess![
                          index - _vehicleStore!.vehicleSummary!.owned!.length],
                      0);
                }
              }))
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .translate('home_tv_no_post_found'),
                ),
              ),
            );
    }
  }

  Widget _buildVehicleTile(Vehicle vehicle, int owned) {
    return InkWell(
      onTap: () {
        _vehicleStore!.getVehicle(vehicle.id!);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VehicleScreen()));
      },
      child: Column(
        children: [
          SizedBox(height: 10),
          SvgPicture.asset('assets/icons/ic_vehicle.svg'),
          SizedBox(height: 8),
          Text(
              vehicle.registrationNo != null
                  ? vehicle.registrationNo! +
                      "\n (" +
                      AppLocalizations.of(context)!
                          .translate(owned == 1 ? 'owner' : 'user') +
                      ")"
                  : '-' +
                      "\n (" +
                      AppLocalizations.of(context)!
                          .translate(owned == 1 ? 'owner' : 'user') +
                      ")",
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
