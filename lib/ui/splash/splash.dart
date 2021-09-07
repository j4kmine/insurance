import 'dart:async';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(color: Colors.white),
      Column(
        children: <Widget>[
          Expanded(child: Container()),
          Image(
              image: AssetImage('assets/images/welcome.gif'),
              width: MediaQuery.of(context).size.width),
        ],
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            Image(
                image: AssetImage('assets/icons/ic_appicon.png'), height: 175),
            Text(
              AppLocalizations.of(context)!
                  .translate('one_stop_automotive_network'),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    ]);
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
