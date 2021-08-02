import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/vehicle/vehicle.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/document/document_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/ui/account/personal_info.dart';
import 'package:boilerplate/ui/login/login.dart';

import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var categories = [
    'profile',
    // 'settings',
    'privacy_policy',
    'terms_and_conditions',
    // 'help',
    // 'contact_us'
  ];

  UserStore? _userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'account'),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [_buildLogout(), _buildListView()])),
    );
  }

  Widget _buildListView() {
    return Container(
      height: MediaQuery.of(context).size.height - 220,
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, position) {
          return Container();
        },
        itemBuilder: (context, position) {
          return _buildListItem(position);
        },
      ),
    );
  }

  Widget _buildListItem(int position) {
    return InkWell(
      onTap: () async {
        if (position == 0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PersonalInfoScreen()));
        } else if (position == 1) {
          await launch(Endpoints.getPrivacy);
        } else if (position == 2) {
          await launch(Endpoints.getTerms);
        }
      },
      child: ListTile(
        contentPadding:
            EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        dense: true,
        title: Row(
          children: <Widget>[
            SvgPicture.asset(
                'assets/icons/ic_' + categories[position] + '.svg'),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate(categories[position]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.title!.copyWith(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              color: AppColors.primaryColor,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogout() {
    return Positioned(
      bottom: 20,
      left: 20,
      width: MediaQuery.of(context).size.width - 40,
      height: 45,
      child: RoundedButtonWidget(
        buttonText: AppLocalizations.of(context)!.translate('log_out'),
        buttonColor: AppColors.dangerColor,
        textColor: Colors.white,
        onPressed: () async {
          SharedPreferences.getInstance().then((preference) {
            preference.remove(Preferences.auth_token);
            preference.setBool(Preferences.is_logged_in, false);
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
        },
      ),
    );
  }
}
