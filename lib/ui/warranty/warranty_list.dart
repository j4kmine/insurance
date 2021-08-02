import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/models/warranty/warranty.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/warranty/warranty_detail.dart';
import 'package:boilerplate/ui/warranty/warranty_quote.dart';
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

class WarrantyListScreen extends StatefulWidget {
  @override
  _WarrantyListScreenState createState() => _WarrantyListScreenState();
}

class _WarrantyListScreenState extends State<WarrantyListScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;
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
    _warrantyStore = Provider.of<WarrantyStore>(context);

    // check to see if already called api
    if (!_warrantyStore!.warrantiesLoading) {
      _warrantyStore!.getWarranties();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'all_warranties'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _warrantyStore!.getWarranties(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildWarranties();
      },
    );
  }

  Widget _buildWarranties() {
    if (_warrantyStore!.warrantiesLoading) {
      return CustomProgressIndicatorWidget();
    } else {
      return (_warrantyStore!.warrantyList != null &&
              _warrantyStore!.warrantyList!.warranties!.length > 0)
          ? ListWidget(
              count: _warrantyStore!.warrantyList!.warranties!.length,
              itemBuilder: (context, position) {
                return _buildWarrantyTile(
                    _warrantyStore!.warrantyList!.warranties![position]);
              })
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

  Widget _buildWarrantyTile(Warranty warranty) {
    String topLeft = AppLocalizations.of(context)!.translate("price_enquiry");
    String topRight = AppLocalizations.of(context)!.translate(warranty.status!);
    String bottomLeft = AppLocalizations.of(context)!.translate("valid_till") +
        " " +
        warranty.endDate!;
    String bottomRight = warranty.formatPrice!;
    if (warranty.status == 'pending_admin_review') {
      topLeft = AppLocalizations.of(context)!.translate("purchase");
      bottomLeft = AppLocalizations.of(context)!.translate("submitted_on") +
          " " +
          warranty.updatedAt!;
    }

    if (warranty.vehicle != null) {
      topLeft += ": " + warranty.vehicle!.registrationNo!;
    }
    return ListTileWidget(
        onTap: () {
          _warrantyStore!.getWarranty(warranty.id!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WarrantyDetailScreen()));
        },
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight);
  }
}
