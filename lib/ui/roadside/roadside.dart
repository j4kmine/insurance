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
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadSideScreen extends StatefulWidget {
  @override
  _RoadSideScreenState createState() => _RoadSideScreenState();
}

class _RoadSideScreenState extends State<RoadSideScreen> {
  //stores:---------------------------------------------------------------------

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SecondaryAppBarWidget(text: 'roadside_assistance'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
      height: 160,
      firstWidget: Container(),
      secondWidget: _buildMainContent(),
      thirdWidget: Container(),
    );
  }

  Widget _buildMainContent() {
    return Column(children: [
      SizedBox(height: 20),
      Image(
        image: AssetImage('assets/images/img_roadside.png'),
      ),
      SizedBox(height: 20),
      InkWell(
        onTap: () => launch("tel://6598879899"),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.translate("call_now"),
                style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("+65 9887 9899",
                style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Image(image: AssetImage('assets/icons/ic_phone.png')),
          ],
        ),
      ),
      SizedBox(height: 20),
    ]);
  }
}
