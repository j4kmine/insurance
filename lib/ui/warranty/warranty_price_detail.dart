import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/vehicle/vehicle.dart';
import 'package:boilerplate/ui/warranty/warranty_buy.dart';
import 'package:boilerplate/ui/warranty/warranty_quote.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/detail_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/mini_progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_app_bar_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WarrantyPriceDetailScreen extends StatefulWidget {
  @override
  _WarrantyPriceDetailScreenState createState() =>
      _WarrantyPriceDetailScreenState();
}

class _WarrantyPriceDetailScreenState extends State<WarrantyPriceDetailScreen> {
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
        secondWidget: _buildMainContent(),
        thirdWidget: _warrantyStore!.selectedOption != '' &&
                _warrantyStore!.selectedOption != Strings.quote
            ? _buildBuyWarranty()
            : Container());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPrices();
      },
    );
  }

  Widget _buildPrices() {
    if (_warrantyStore!.priceLoading) {
      return MiniProgressIndicatorWidget();
    } else {
      return (_warrantyStore!.price != null)
          ? _buildVehicleDetails()
          : Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('no_price_found'),
                ),
              ),
            );
    }
  }

  Widget _buildVehicleDetails() {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildPriceTile(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: DetailWidget(
              title: AppLocalizations.of(context)!
                  .translate("warranty_information"),
              titles: [
                AppLocalizations.of(context)!.translate("car_make"),
                AppLocalizations.of(context)!.translate("car_model"),
                AppLocalizations.of(context)!.translate("car_category"),
                AppLocalizations.of(context)!.translate("car_capacity"),
                AppLocalizations.of(context)!.translate("fuel_type"),
                AppLocalizations.of(context)!.translate("package"),
                AppLocalizations.of(context)!.translate("max_claim_per_year"),
                AppLocalizations.of(context)!.translate("mileage_coverage"),
              ],
              values: [
                _warrantyStore!.price!.make!,
                _warrantyStore!.price!.model!,
                _warrantyStore!.price!.category!,
                _warrantyStore!.price!.capacity.toString(),
                AppLocalizations.of(context)!
                    .translate(_warrantyStore!.price!.fuel!),
                _warrantyStore!.price!.package!,
                _warrantyStore!.price!.formatMaxClaim!,
                _warrantyStore!.price!.formatMileageCoverage!,
              ]),
        )
      ],
    );
  }

  Widget _buildPriceTile() {
    return SecondaryCardWidget(
        img: Image.network(
            Endpoints.images +
                "/" +
                _warrantyStore!.price!.insurer!.code! +
                ".png",
            width: 75),
        title: _warrantyStore!.price!.formatPremiumPerYear,
        caption: AppLocalizations.of(context)!.translate("premium_per_year"),
        heading: AppLocalizations.of(context)!.translate("warranty_insurance"),
        firstKey:
            AppLocalizations.of(context)!.translate("duration_of_warranty"),
        secondKey: AppLocalizations.of(context)!.translate("car_type"),
        firstValue: _warrantyStore!.price!.warrantyPeriod,
        secondValue: AppLocalizations.of(context)!
            .translate(_warrantyStore!.price!.type!));
  }

  Widget _buildBuyWarranty() {
    return Positioned(
        top: MediaQuery.of(context).size.height - 200,
        left: 20,
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: Observer(builder: (context) {
          return RoundedButtonWidget(
              buttonColor: AppColors.successColor,
              buttonText: _warrantyStore!.priceLoading
                  ? AppLocalizations.of(context)!.translate('buy_warranty')
                  : AppLocalizations.of(context)!.translate('buy_warranty') +
                      " @ " +
                      _warrantyStore!.price!.formatPrice!,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WarrantyBuyScreen()));
              });
        }));
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context)!.translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
