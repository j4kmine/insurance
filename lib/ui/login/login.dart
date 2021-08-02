import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/browser.dart';
import 'package:boilerplate/ui/login/corporate_login.dart';
import 'package:boilerplate/ui/register/register.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/terms_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;
  RegisterStore? _registerStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _registerStore = Provider.of<RegisterStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[_buildRightSide()],
      ),
    );
  }

  Widget _buildRightSide() {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Image(
                  image: AssetImage('assets/icons/ic_appicon.png'),
                  height: 175),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _buildSignPassButton(),
                  ),
                  SizedBox(width: 10),
                  Expanded(flex: 1, child: _buildCorpPassButton())
                ],
              ),
              SizedBox(height: 20.0),
              _buildAgreementText(),
              SizedBox(height: 20.0),
              _buildCreateAccountButton(),
              SizedBox(height: 20.0),
              Image(
                  image: AssetImage('assets/images/img_login_bg.png'),
                  height: 200),
              _registerStore!.redirect ? _navigate() : Container()
            ],
          ),
        ),
      );
    });
  }

  _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _registerStore!.redirect = false;
      _registerStore!.singpass = true;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
    });
  }

  Widget _buildAgreementText() {
    return TermsWidget();
  }

  Widget _buildCreateAccountButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context)!.translate('create_account'),
      buttonColor: AppColors.secondaryColor,
      textColor: Colors.white,
      onPressed: () async {
        _registerStore!.nric = '';
        _registerStore!.singpass = false;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
    );
  }

  Widget _buildSignPassButton() {
    return RoundedButtonWidget(
      buttonHeading: AppLocalizations.of(context)!.translate('personal'),
      buttonText:
          AppLocalizations.of(context)!.translate('login_btn_sing_pass'),
      buttonColor: AppColors.dangerColor,
      textColor: Colors.white,
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Browser()));
      },
    );
  }

  Widget _buildCorpPassButton() {
    return RoundedButtonWidget(
      buttonHeading: AppLocalizations.of(context)!.translate('corporate'),
      buttonText: AppLocalizations.of(context)!.translate('login'),
      buttonColor: AppColors.primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CorporateLoginScreen()));
      },
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
