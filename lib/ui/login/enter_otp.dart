import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/login/login_form_store.dart';
import 'package:boilerplate/stores/login/login_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterOTPScreen extends StatefulWidget {
  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _otpController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;

  //stores:---------------------------------------------------------------------
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
          leading: SizedBox(),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 24.0),
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
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
              return _loginStore!.submitted
                  ? navigate()
                  : _showErrorMessage(_loginFormStore.errorStore.errorMessage);
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
            Text(AppLocalizations.of(context)!.translate('enter_otp'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Image(
                image: AssetImage('assets/images/img_otp_bg.png'), height: 200),
            SizedBox(height: 20.0),
            _buildOTPField(),
            SizedBox(height: 20.0),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate('otp'),
          hint: AppLocalizations.of(context)!.translate('enter_otp'),
          inputType: TextInputType.number,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _otpController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _loginFormStore.userOTP = _otpController.text;
          },
          errorText: _loginFormStore.loginFormErrorStore.userOTP,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context)!.translate('submit'),
      buttonColor: AppColors.secondaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (_loginFormStore.canSendOTP) {
          DeviceUtils.hideKeyboard(context);
          _loginStore!.sendOTP(context, _loginFormStore.userOTP);
        } else {
          _showErrorMessage(AppLocalizations.of(context)!
              .translate('login_error_fill_fields'));
        }
        /* Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterScreen()));*/
      },
    );
  }

  // General Methods:-----------------------------------------------------------
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

  Widget navigate() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _otpController.dispose();
    super.dispose();
  }
}
