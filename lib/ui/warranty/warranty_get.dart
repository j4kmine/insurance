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
import 'package:boilerplate/ui/warranty/warranty_list.dart';
import 'package:boilerplate/ui/warranty/warranty_quote.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/card_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/list_tile_widget.dart';
import 'package:boilerplate/widgets/list_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WarrantyGetScreen extends StatefulWidget {
  @override
  _WarrantyGetScreenState createState() => _WarrantyGetScreenState();
}

class _WarrantyGetScreenState extends State<WarrantyGetScreen> {
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
    if (!_warrantyStore!.pendingWarrantiesLoading) {
      _warrantyStore!.getPendingWarranties();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SecondaryAppBarWidget(text: 'get_warranty'),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () => _warrantyStore!.getWarranties(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 240,
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildWarrantyGet());
  }

  Widget _buildMainContent() {
    return Column(children: [
      _buildWarrantyBanner(),
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
                  _warrantyStore!.getWarranties();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WarrantyListScreen()));
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
    return GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        childAspectRatio: 1.5,
        children: List.generate(categories.length, (index) {
          return _buildCategoryTile(categories[index]);
        }));
  }

  Widget _buildCategoryTile(String title) {
    return Column(
      children: [
        SvgPicture.asset('assets/icons/ic_' + title + '.svg'),
        SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.translate(title),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWarrantyBanner() {
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
        Text(AppLocalizations.of(context)!.translate("why_carfren_warranty"),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
      ]),
    );
  }

  Widget _buildVehicle() {
    if (_warrantyStore!.pendingWarrantiesLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return (_warrantyStore!.pendingWarrantyList != null &&
              _warrantyStore!.pendingWarrantyList!.warranties!.length > 0)
          ? ListWidget(
              count: _warrantyStore!.pendingWarrantyList!.warranties!.length,
              itemBuilder: (context, position) {
                return _buildWarrantyTile(
                    _warrantyStore!.pendingWarrantyList!.warranties![position]);
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
        warranty.formatValidTill!;
    String bottomRight = warranty.formatPrice!;
    if (warranty.status == 'pending_admin_review') {
      topLeft = AppLocalizations.of(context)!.translate("purchase");
      bottomLeft = AppLocalizations.of(context)!.translate("submitted_on") +
          " " +
          warranty.formatSubmittedAt!;
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

  Widget _buildWarrantyGet() {
    return Positioned(
      top: MediaQuery.of(context).size.height - 220,
      left: 20,
      width: MediaQuery.of(context).size.width - 40,
      height: 45,
      child: RoundedButtonWidget(
        buttonColor: AppColors.secondaryColor,
        buttonText:
            AppLocalizations.of(context)!.translate('get_warranty_quote'),
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WarrantyQuoteScreen()));
        },
      ),
    );
  }
}
