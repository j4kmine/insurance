import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/motor/motor_form_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/ui/motor/motor_status.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_bar_widget.dart';
import 'package:boilerplate/widgets/body_widget.dart';
import 'package:boilerplate/widgets/error_store_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:boilerplate/widgets/secondary_card_widget.dart';
import 'package:boilerplate/widgets/secondary_textfield_widget.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class MotorCheckOutScreen extends StatefulWidget {
  @override
  _MotorCheckOutScreenState createState() => _MotorCheckOutScreenState();
}

class _MotorCheckOutScreenState extends State<MotorCheckOutScreen> {
  //stores:---------------------------------------------------------------------
  MotorStore? _motorStore;
  MotorFormStore _motorFormStore = MotorFormStore();
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardNoController = TextEditingController();
  TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController _cardCVVController = TextEditingController();
  TextEditingController _transferController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _referenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _motorStore = Provider.of<MotorStore>(context);
    if (!_motorStore!.payNowLoading) {
      _motorStore!.getPayNow(_motorStore!.motor!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(text: 'check_out'),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BodyWidget(
        firstWidget: ErrorStoreWidget(errorStore: _motorStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildBuyMotor());
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _buildPaymentDetails();
      },
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildPriceTile(),
        _buildPaymentOptions(),
        SizedBox(height: 10),
        _motorFormStore.paymentOption == 0 || _motorFormStore.paymentOption == 1
            ? _buildCreditCard()
            : _buildPayNow(),
        _motorStore!.checkoutSuccess || _motorStore!.transferSuccess
            ? _navigate()
            : Container()
      ],
    );
  }

  Widget _buildPriceTile() {
    return _motorStore!.motor != null
        ? SecondaryCardWidget(
            img: Image.network(
                Endpoints.images +
                    "/" +
                    _motorStore!.motor!.insurerCode! +
                    ".png",
                width: 75),
            title: _motorStore!.motor!.formatPrice,
            caption: '',
            heading: AppLocalizations.of(context)!.translate("motor_insurance"),
            firstKey: AppLocalizations.of(context)!.translate("ci_no"),
            secondKey: AppLocalizations.of(context)!.translate("car_type"),
            firstValue: _motorStore!.motor!.ciNo != null
                ? _motorStore!.motor!.ciNo
                : '-',
            secondValue: AppLocalizations.of(context)!
                .translate(_motorStore!.motor!.vehicle!.type))
        : Container();
  }

  Widget _buildPaymentOptions() {
    return Row(children: [
      SizedBox(width: 20),
      _buildPaymentOption(0, 'img_visa'),
      SizedBox(width: 10),
      _buildPaymentOption(1, 'img_mastercard'),
      SizedBox(width: 10),
      _buildPaymentOption(2, 'img_paynow'),
      SizedBox(width: 20),
    ]);
  }

  Widget _buildPaymentOption(int option, String img) {
    return Expanded(
        child: InkWell(
      onTap: () => _motorFormStore.paymentOption = option,
      child: Container(
          height: 42,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: _motorFormStore.paymentOption == option ? 1 : 0.5,
                  color: _motorFormStore.paymentOption == option
                      ? AppColors.primaryColor
                      : AppColors.descriptionColor)),
          child: SvgPicture.asset(
            'assets/images/' + img + '.svg',
            fit: BoxFit.scaleDown,
          )),
    ));
  }

  Widget _buildCreditCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        _buildCardName(),
        SizedBox(height: 10),
        _buildCardNo(),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildExpiryDate()),
            SizedBox(width: 10),
            Expanded(child: _buildCVV())
          ],
        ),
      ]),
    );
  }

  Widget _buildCardName() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('name'),
      hint: AppLocalizations.of(context)!.translate('enter_name'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _cardNameController,
      onChanged: (value) {
        _motorFormStore.cardName = value;
      },
    );
  }

  Widget _buildCardNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('card_no'),
      hint: AppLocalizations.of(context)!.translate('enter_card_no'),
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _cardNoController,
      onChanged: (value) {
        _motorFormStore.cardNo = value;
      },
    );
  }

  Widget _buildExpiryDate() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('expiry_date'),
      hint: Strings.expiryDateFormat,
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _cardExpiryController,
      onChanged: (value) {
        _motorFormStore.expiryDate = value;
      },
    );
  }

  Widget _buildCVV() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('cvv'),
      hint: "123",
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      textController: _cardCVVController,
      onChanged: (value) {
        _motorFormStore.cvv = value;
      },
    );
  }

  Widget _buildPayNow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        _buildRecipient(),
        SizedBox(height: 10),
        _buildAmount(),
        SizedBox(height: 10),
        _buildReferenceId(),
      ]),
    );
  }

  Widget _buildRecipient() {
    _transferController.text = _motorStore!.payNow!.uen!;
    return SecondaryTextFieldWidget(
      enabled: false,
      text: AppLocalizations.of(context)!.translate('please_transfer_to'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      suffix: Icons.copy,
      onTap: () {
        Clipboard.setData(new ClipboardData(text: _motorStore!.payNow!.uen));
        FlushbarHelper.createSuccess(
          message:
              AppLocalizations.of(context)!.translate('copied_to_clipboard'),
          duration: Duration(seconds: 3),
        )..show(context);
      },
      textController: _transferController,
    );
  }

  Widget _buildAmount() {
    _amountController.text = _motorStore!.payNow!.formatAmount!;
    return SecondaryTextFieldWidget(
        enabled: false,
        text: AppLocalizations.of(context)!.translate('amount_to_transfer'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        suffix: Icons.copy,
        onTap: () {
          Clipboard.setData(
              new ClipboardData(text: _motorStore!.payNow!.amount));
          FlushbarHelper.createSuccess(
            message:
                AppLocalizations.of(context)!.translate('copied_to_clipboard'),
            duration: Duration(seconds: 3),
          )..show(context);
        },
        textController: _amountController);
  }

  Widget _buildReferenceId() {
    _referenceController.text = _motorStore!.payNow!.reference!;
    return SecondaryTextFieldWidget(
        enabled: false,
        text: AppLocalizations.of(context)!.translate('reference_id'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        suffix: Icons.copy,
        onTap: () {
          Clipboard.setData(
              new ClipboardData(text: _motorStore!.payNow!.reference));
          FlushbarHelper.createSuccess(
            message:
                AppLocalizations.of(context)!.translate('copied_to_clipboard'),
            duration: Duration(seconds: 3),
          )..show(context);
        },
        textController: _referenceController);
  }

  Widget _buildBuyMotor() {
    return Observer(builder: (context) {
      var text = _motorStore!.motorLoading
          ? AppLocalizations.of(context)!.translate('buy_motor')
          : AppLocalizations.of(context)!.translate('buy_motor') +
              " @ " +
              _motorStore!.motor!.formatPrice!;
      if (_motorFormStore.paymentOption == 2) {
        text = AppLocalizations.of(context)!.translate('i_have_transferred');
      }
      return _motorStore!.motor != null
          ? Positioned(
              top: MediaQuery.of(context).size.height - 200,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              height: 45,
              child: RoundedButtonWidget(
                  buttonColor: AppColors.successColor,
                  buttonText: text,
                  textColor: Colors.white,
                  loading: _motorStore!.checkoutLoading ||
                      _motorStore!.transferLoading,
                  enabled: !_motorStore!.checkoutLoading &&
                      !_motorStore!.transferLoading,
                  onPressed: () {
                    DeviceUtils.hideKeyboard(context);
                    if (_motorFormStore.paymentOption == 2) {
                      _motorStore!.transfer(_motorStore!.motor!.id!);
                    } else if (_motorFormStore.canCreditCard) {
                      // _motorStore!.status = 'success';
                      final CreditCard card = CreditCard(
                          name: _motorFormStore.cardName,
                          cvc: _motorFormStore.cvv,
                          number: _motorFormStore.cardNo,
                          expMonth: int.parse(
                              _motorFormStore.expiryDate.split("/")[0]),
                          expYear: int.parse(
                              _motorFormStore.expiryDate.split("/")[1]));
                      _motorStore!.checkout(card, _motorStore!.motor!.id!);
                    } else {
                      _showErrorMessage(AppLocalizations.of(context)!
                          .translate('login_error_fill_fields'));
                    }
                  }))
          : Container();
    });
  }

  Widget _navigate() {
    Future.delayed(Duration(milliseconds: 0), () {
      _motorStore!.checkoutSuccess = false;
      _motorStore!.transferSuccess = false;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MotorStatusScreen()));
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
}
