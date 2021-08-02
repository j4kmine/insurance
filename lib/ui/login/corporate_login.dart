import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/login/login_form_store.dart';
import 'package:boilerplate/stores/login/login_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/login/enter_otp.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorporateLoginScreen extends StatefulWidget {
  @override
  _CorporateLoginScreenState createState() => _CorporateLoginScreenState();
}

class _CorporateLoginScreenState extends State<CorporateLoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userNRICController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;
  LoginFormStore _loginFormStore = LoginFormStore();
  LoginStore? _loginStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _loginStore = Provider.of<LoginStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
          iconTheme: IconThemeData(
        color: _themeStore!.darkMode
            ? Colors.black54
            : Colors.white, //change your color here
      )),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          _buildRightSide(),
          Observer(
            builder: (context) {
              return _loginStore!.success
                  ? navigate(context)
                  : _showErrorMessage(_loginStore!.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _loginStore!.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.translate('corporate_login'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Image(
                image: AssetImage('assets/images/img_login_bg.png'),
                height: 200),
            SizedBox(height: 20.0),
            _buildNricField(),
            SizedBox(height: 20.0),
            _buildPhoneField(),
            SizedBox(height: 20.0),
            _buildSendOTPButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNricField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          capitalization: TextCapitalization.characters,
          text: AppLocalizations.of(context)!.translate('uen'),
          hint: AppLocalizations.of(context)!.translate('enter_uen'),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userNRICController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _loginFormStore.userNRIC = _userNRICController.text;
          },
          errorText: _loginFormStore.loginFormErrorStore.userNRIC,
        );
      },
    );
  }

  Widget _buildPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate('phone') + " (+65)",
          hint: AppLocalizations.of(context)!.translate('enter_phone'),
          inputType: TextInputType.phone,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _loginFormStore.userPhone = _userPhoneController.text;
          },
          errorText: _loginFormStore.loginFormErrorStore.userPhone,
        );
      },
    );
  }

  Widget _buildSendOTPButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context)!.translate('login_btn_send_otp'),
      buttonColor: AppColors.secondaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (_loginFormStore.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _loginStore!.login(context, _loginFormStore.userNRIC,
              "+65 " + _loginFormStore.userPhone);
        } else {
          _showErrorMessage(AppLocalizations.of(context)!
              .translate('login_error_fill_fields'));
        }
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EnterOTPScreen()));
    });
    return Container();
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userNRICController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }
}
