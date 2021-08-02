import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/warranty/warranty_price_detail.dart';
import 'package:boilerplate/ui/warranty/warranty_quote.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WarrantyPricesScreen extends StatefulWidget {
  @override
  _WarrantyPricesScreenState createState() => _WarrantyPricesScreenState();
}

class _WarrantyPricesScreenState extends State<WarrantyPricesScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;

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
        appBar: AppBarWidget(text: 'your_warranty_results'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPrices();
      },
    );
  }

  Widget _buildPrices() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: new NeverScrollableScrollPhysics(),
      itemCount: _warrantyStore!.priceList!.prices!.length,
      separatorBuilder: (context, position) {
        return Container();
      },
      itemBuilder: (context, position) {
        return _buildPriceTile(position);
      },
    );
  }

  Widget _buildPriceTile(int position) {
    return InkWell(
        onTap: () {
          _warrantyStore!
              .getPrice(_warrantyStore!.priceList!.prices![position].id!);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WarrantyPriceDetailScreen()));
        },
        child: SecondaryCardWidget(
            img: Image.network(
                Endpoints.images +
                    "/" +
                    _warrantyStore!
                        .priceList!.prices![position].insurer!.code! +
                    ".png",
                width: 75),
            title: _warrantyStore!
                .priceList!.prices![position].formatPremiumPerYear,
            caption:
                AppLocalizations.of(context)!.translate("premium_per_year"),
            heading:
                AppLocalizations.of(context)!.translate("warranty_insurance"),
            firstKey:
                AppLocalizations.of(context)!.translate("duration_of_warranty"),
            secondKey: AppLocalizations.of(context)!.translate("car_type"),
            firstValue:
                _warrantyStore!.priceList!.prices![position].warrantyPeriod,
            secondValue: AppLocalizations.of(context)!.translate(
                _warrantyStore!.priceList!.prices![position].type!)));
  }
}
