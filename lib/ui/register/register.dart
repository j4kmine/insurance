import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/register/register_form_store.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/browser.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userNRICController = TextEditingController();
  TextEditingController _userDOBController = TextEditingController();
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();

  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyUENController = TextEditingController();
  TextEditingController _companyDOBController = TextEditingController();
  TextEditingController _companyPhoneController = TextEditingController();
  TextEditingController _companyEmailController = TextEditingController();

  TabController? _tabController;
  int _selectedTabbar = 0;

  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;
  RegisterStore? _registerStore;
  RegisterFormStore _registerFormStore = new RegisterFormStore();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
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
    return Material(child: Observer(
      builder: (context) {
        return Stack(
          children: [
            _buildRightSide(),
            Visibility(
              visible: _registerStore!.loading,
              child: CustomProgressIndicatorWidget(),
            ),
            _registerStore!.success
                ? _navigate(_registerStore!.successStore.successMessage)
                : _showErrorMessage(_registerStore!.errorStore.errorMessage)
          ],
        );
      },
    ));
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.translate('create_account'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Image(
                image: AssetImage('assets/images/img_register_bg.png'),
                height: 200),
            SizedBox(height: 20.0),
            _registerStore!.singpass ? Container() : _buildTabs(),
            _registerStore!.singpass ? Container() : SizedBox(height: 10.0),
            _buildTabView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      height: 40.0,
      child: TabBar(
        onTap: (index) {
          setState(() {
            _selectedTabbar = index;
          });
        },
        controller: _tabController,
        tabs: [
          new Tab(
            text: AppLocalizations.of(context)!.translate('for_personal'),
          ),
          new Tab(
            text: AppLocalizations.of(context)!.translate('for_corporate'),
          ),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primaryColor,
        labelPadding: EdgeInsets.all(0),
        indicator: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildTabView() {
    if (_selectedTabbar == 0) {
      return _buildPersonalPage(); //1st custom tabBarView
    } else {
      return _buildCorporatePage();
    }
  }

  Widget _buildMyInfo() {
    return InkWell(
      onTap: () {
        _registerStore!.myinfo = true;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Browser()));
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(image: AssetImage('assets/images/img_myinfo.png'))]),
    );
  }

  Widget _buildAgreementText() {
    return TermsWidget(action: "registering");
  }

  Widget _buildPersonalPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.0),
        _buildMyInfo(),
        SizedBox(height: 10.0),
        _buildNameField("name", "enter_name"),
        SizedBox(height: 20.0),
        _buildNricField("nric", "enter_nric"),
        SizedBox(height: 20.0),
        _buildDOBField("date_of_birth", Strings.dateFormat),
        SizedBox(height: 20.0),
        _buildPhoneField(),
        SizedBox(height: 20.0),
        _buildEmailField(),
        SizedBox(height: 20.0),
        _buildAgreementText(),
        SizedBox(height: 20.0),
        _buildCreateAccountButton(),
      ],
    );
  }

  Widget _buildCorporatePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.0),
        _buildCompanyNameField("name", "enter_company_name"),
        SizedBox(height: 20.0),
        _buildCompanyUENField("uen", "enter_uen"),
        SizedBox(height: 20.0),
        _buildCompanyDOBField("date_of_incorporation", Strings.dateFormat),
        SizedBox(height: 20.0),
        _buildCompanyPhoneField(),
        SizedBox(height: 20.0),
        _buildCompanyEmailField(),
        SizedBox(height: 20.0),
        _buildAgreementText(),
        SizedBox(height: 20.0),
        _buildCreateAccountButton(),
      ],
    );
  }

  Widget _buildNameField(String _name, String _placeholder) {
    if (_registerStore!.name != '') {
      _userNameController.text = _registerStore!.name;
      _registerFormStore.userName = _registerStore!.name;
    }
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate(_name),
          hint: AppLocalizations.of(context)!.translate(_placeholder),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.userName = _userNameController.text;
          },
          errorText: _registerFormStore.registerFormErrorStore.userName,
        );
      },
    );
  }

  Widget _buildDOBField(String _name, String _placeholder) {
    if (_registerStore!.dob != '') {
      _userDOBController.text = _registerStore!.dob;
      _registerFormStore.userDOB = _registerStore!.dob;
    }
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            print(picked);
            if (picked != null) {
              _registerFormStore.userDOB = picked.toString();
              _userDOBController.text =
                  DateFormat(Strings.dateFormat).format(picked);
            }
          },
          child: TextFieldWidget(
            enabled: false,
            text: AppLocalizations.of(context)!.translate(_name),
            hint: AppLocalizations.of(context)!.translate(_placeholder),
            inputType: TextInputType.text,
            iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
            textController: _userDOBController,
            inputAction: TextInputAction.next,
            errorText: _registerFormStore.registerFormErrorStore.userEmail,
          ),
        );
      },
    );
  }

  Widget _buildEmailField() {
    if (_registerStore!.email != '') {
      _userEmailController.text = _registerStore!.email;
      _registerFormStore.userEmail = _registerStore!.email;
    }
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate('email'),
          hint: AppLocalizations.of(context)!.translate('enter_email'),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.userEmail = _userEmailController.text;
          },
          errorText: _registerFormStore.registerFormErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildNricField(String _name, String _placeholder) {
    if (_registerStore!.nric != '') {
      _userNRICController.text = _registerStore!.nric;
      _registerFormStore.userNRIC = _registerStore!.nric;
    }
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          capitalization: TextCapitalization.characters,
          text: AppLocalizations.of(context)!.translate(_name),
          hint: AppLocalizations.of(context)!.translate(_placeholder),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userNRICController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.userNRIC = _userNRICController.text;
          },
          errorText: _registerFormStore.registerFormErrorStore.userNRIC,
        );
      },
    );
  }

  Widget _buildPhoneField() {
    if (_registerStore!.phone != '') {
      _userPhoneController.text = _registerStore!.phone;
      _registerFormStore.userPhone = _registerStore!.phone;
    }
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
            _registerFormStore.userPhone = _userPhoneController.text;
          },
          errorText: _registerFormStore.registerFormErrorStore.userPhone,
        );
      },
    );
  }

  Widget _buildCompanyNameField(String _name, String _placeholder) {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate(_name),
          hint: AppLocalizations.of(context)!.translate(_placeholder),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _companyNameController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.companyName = _companyNameController.text;
          },
        );
      },
    );
  }

  Widget _buildCompanyDOBField(String _name, String _placeholder) {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              _registerFormStore.companyDOB = picked.toString();
              _companyDOBController.text =
                  DateFormat(Strings.dateFormat).format(picked);
            }
          },
          child: TextFieldWidget(
            enabled: false,
            text: AppLocalizations.of(context)!.translate(_name),
            hint: AppLocalizations.of(context)!.translate(_placeholder),
            inputType: TextInputType.text,
            iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
            textController: _companyDOBController,
            inputAction: TextInputAction.next,
          ),
        );
      },
    );
  }

  Widget _buildCompanyEmailField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate('email'),
          hint: AppLocalizations.of(context)!.translate('enter_email'),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _companyEmailController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.companyEmail = _companyEmailController.text;
          },
        );
      },
    );
  }

  Widget _buildCompanyUENField(String _name, String _placeholder) {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          capitalization: TextCapitalization.characters,
          text: AppLocalizations.of(context)!.translate(_name),
          hint: AppLocalizations.of(context)!.translate(_placeholder),
          inputType: TextInputType.text,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _companyUENController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.companyUEN = _companyUENController.text;
          },
        );
      },
    );
  }

  Widget _buildCompanyPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          text: AppLocalizations.of(context)!.translate('phone') + " (+65)",
          hint: AppLocalizations.of(context)!.translate('enter_phone'),
          inputType: TextInputType.phone,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _companyPhoneController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _registerFormStore.companyPhone = _companyPhoneController.text;
          },
        );
      },
    );
  }

  Widget _buildCreateAccountButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context)!.translate('create_account'),
      buttonColor: AppColors.secondaryColor,
      textColor: Colors.white,
      onPressed: () async {
        // if (_registerFormStore.canRegister) {
        DeviceUtils.hideKeyboard(context);
        if (_selectedTabbar == 0) {
          _registerStore!.register(
              _registerFormStore.userName,
              _registerFormStore.userNRIC,
              _registerFormStore.userDOB,
              "+65 " + _registerFormStore.userPhone,
              _registerFormStore.userEmail,
              false);
        } else {
          _registerStore!.register(
              _registerFormStore.companyName,
              _registerFormStore.companyUEN,
              _registerFormStore.companyDOB,
              "+65 " + _registerFormStore.companyPhone,
              _registerFormStore.companyEmail,
              true);
        }
        /*} else {
          _showErrorMessage(AppLocalizations.of(context)
              .translate('login_error_fill_fields'));
        }*/
      },
    );
  }

  _navigate(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      _registerStore!.success = false;
      Navigator.of(context).pop();
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context)!.translate('home_tv_success'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return Container();
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userNameController.dispose();
    _userNRICController.dispose();
    _userDOBController.dispose();
    _userPhoneController.dispose();
    _userEmailController.dispose();

    _companyNameController.dispose();
    _companyUENController.dispose();
    _companyDOBController.dispose();
    _companyPhoneController.dispose();
    _companyEmailController.dispose();

    super.dispose();
  }
}
