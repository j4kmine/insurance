import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:boilerplate/widgets/tertiary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WarrantyStatusScreen extends StatefulWidget {
  @override
  _WarrantyStatusScreenState createState() => _WarrantyStatusScreenState();
}

class _WarrantyStatusScreenState extends State<WarrantyStatusScreen> {
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
        appBar: TertiaryAppBarWidget(text: 'transaction_details'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        height: 135,
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildPriceTile());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPaymentDetails();
      },
    );
  }

  Widget _buildPaymentDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(AppLocalizations.of(context)!.translate("payment"),
              style: TextStyle(
                  fontSize: 18,
                  color: _warrantyStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.translate(_warrantyStore!.status),
              style: TextStyle(
                  fontSize: 18,
                  color: _warrantyStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Image(
              image: AssetImage(
                  'assets/icons/ic_' + _warrantyStore!.status + '.png')),
          SizedBox(height: 30),
          Text(
              AppLocalizations.of(context)!
                  .translate(_warrantyStore!.status + "_description"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: _warrantyStore!.status != 'failed'
                      ? AppColors.primaryColor
                      : AppColors.dangerColor,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPriceTile() {
    return Positioned(
        top: MediaQuery.of(context).size.height - 320,
        width: MediaQuery.of(context).size.width,
        child: SecondaryCardWidget(
            img: Image.network(
                Endpoints.images +
                    "/" +
                    _warrantyStore!.price!.insurer!.code! +
                    ".png",
                width: 75),
            title: _warrantyStore!.price!.formatPremiumPerYear ?? "-",
            caption:
                AppLocalizations.of(context)!.translate("premium_per_year"),
            heading:
                AppLocalizations.of(context)!.translate("warranty_insurance"),
            firstKey:
                AppLocalizations.of(context)!.translate("duration_of_warranty"),
            secondKey: AppLocalizations.of(context)!.translate("car_type"),
            firstValue: _warrantyStore!.price!.warrantyPeriod ?? "-",
            secondValue: AppLocalizations.of(context)!
                .translate(_warrantyStore!.price!.type ?? "-")));
  }
}
