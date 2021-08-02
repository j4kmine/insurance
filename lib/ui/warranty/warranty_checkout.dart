import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/stores/warranty/warranty_form_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/warranty/warranty_status.dart';
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

class WarrantyCheckOutScreen extends StatefulWidget {
  @override
  _WarrantyCheckOutScreenState createState() => _WarrantyCheckOutScreenState();
}

class _WarrantyCheckOutScreenState extends State<WarrantyCheckOutScreen> {
  //stores:---------------------------------------------------------------------
  WarrantyStore? _warrantyStore;
  WarrantyFormStore _warrantyFormStore = WarrantyFormStore();
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
    _warrantyStore = Provider.of<WarrantyStore>(context);
    if (!_warrantyStore!.payNowLoading) {
      _warrantyStore!.getPayNow(_warrantyStore!.warranty!.id!);
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
        firstWidget: ErrorStoreWidget(errorStore: _warrantyStore!.errorStore),
        secondWidget: _buildMainContent(),
        thirdWidget: _buildBuyWarranty());
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
        _warrantyFormStore.paymentOption == 0 ||
                _warrantyFormStore.paymentOption == 1
            ? _buildCreditCard()
            : _buildPayNow(),
        _warrantyStore!.checkoutSuccess ? _navigate() : Container()
      ],
    );
  }

  Widget _buildPriceTile() {
    return _warrantyStore!.warranty != null
        ? SecondaryCardWidget(
            img: Image.network(
                Endpoints.images +
                    "/" +
                    _warrantyStore!.warranty!.insurerCode! +
                    ".png",
                width: 75),
            title: _warrantyStore!.warranty!.formatPremiumPerYear,
            caption:
                AppLocalizations.of(context)!.translate("premium_per_year"),
            heading:
                AppLocalizations.of(context)!.translate("warranty_insurance"),
            firstKey:
                AppLocalizations.of(context)!.translate("duration_of_warranty"),
            secondKey: AppLocalizations.of(context)!.translate("car_type"),
            firstValue: _warrantyStore!.warranty!.warrantyPeriod,
            secondValue: AppLocalizations.of(context)!
                .translate(_warrantyStore!.warranty!.vehicle!.type))
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
      onTap: () => _warrantyFormStore.paymentOption = option,
      child: Container(
          height: 42,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: _warrantyFormStore.paymentOption == option ? 1 : 0.5,
                  color: _warrantyFormStore.paymentOption == option
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
        _warrantyFormStore.cardName = value;
      },
    );
  }

  Widget _buildCardNo() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('card_no'),
      hint: AppLocalizations.of(context)!.translate('enter_card_no'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _cardNoController,
      onChanged: (value) {
        _warrantyFormStore.cardNo = value;
      },
    );
  }

  Widget _buildExpiryDate() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('expiry_date'),
      hint: Strings.expiryDateFormat,
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _cardExpiryController,
      onChanged: (value) {
        _warrantyFormStore.expiryDate = value;
      },
    );
  }

  Widget _buildCVV() {
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('cvv'),
      hint: "123",
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      textController: _cardCVVController,
      onChanged: (value) {
        _warrantyFormStore.cvv = value;
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
    _transferController.text = _warrantyStore!.payNow!.uen!;
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('please_transfer_to'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      suffix: Icons.copy,
      onTap: () {
        Clipboard.setData(
            new ClipboardData(text: _warrantyStore!.payNow!.amount));
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
    _amountController.text = _warrantyStore!.payNow!.formatAmount!;
    return SecondaryTextFieldWidget(
      text: AppLocalizations.of(context)!.translate('amount_to_transfer'),
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      suffix: Icons.copy,
      onTap: () {
        Clipboard.setData(
            new ClipboardData(text: _warrantyStore!.payNow!.amount));
        FlushbarHelper.createSuccess(
          message:
              AppLocalizations.of(context)!.translate('copied_to_clipboard'),
          duration: Duration(seconds: 3),
        )..show(context);
      },
      textController: _amountController,
    );
  }

  Widget _buildReferenceId() {
    _referenceController.text = _warrantyStore!.payNow!.reference!;
    return SecondaryTextFieldWidget(
        text: AppLocalizations.of(context)!.translate('reference_id'),
        inputType: TextInputType.text,
        inputAction: TextInputAction.next,
        suffix: Icons.copy,
        onTap: () {
          Clipboard.setData(
              new ClipboardData(text: _warrantyStore!.payNow!.reference));
          FlushbarHelper.createSuccess(
            message:
                AppLocalizations.of(context)!.translate('copied_to_clipboard'),
            duration: Duration(seconds: 3),
          )..show(context);
        },
        textController: _referenceController);
  }

  Widget _buildBuyWarranty() {
    return Observer(builder: (context) {
      return _warrantyStore!.warranty != null
          ? Positioned(
              top: MediaQuery.of(context).size.height - 200,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              height: 45,
              child: RoundedButtonWidget(
                  buttonColor: AppColors.successColor,
                  buttonText: _warrantyStore!.warrantyLoading
                      ? AppLocalizations.of(context)!.translate('buy_warranty')
                      : AppLocalizations.of(context)!
                              .translate('buy_warranty') +
                          " @ " +
                          _warrantyStore!.warranty!.formatPrice!,
                  textColor: Colors.white,
                  loading: _warrantyStore!.checkoutLoading,
                  enabled: !_warrantyStore!.checkoutLoading,
                  onPressed: () {
                    DeviceUtils.hideKeyboard(context);
                    if (_warrantyFormStore.paymentOption == 2) {
                      _warrantyStore!.transfer(_warrantyStore!.warranty!.id!);
                    } else if (_warrantyFormStore.canCreditCard) {
                      // _warrantyStore!.status = 'success';
                      final CreditCard card = CreditCard(
                          // number: '4111111111111111',
                          // expMonth: 08,
                          // expYear: 22,
                          name: _warrantyFormStore.cardName,
                          cvc: _warrantyFormStore.cvv,
                          number: _warrantyFormStore.cardNo,
                          expMonth: int.parse(
                              _warrantyFormStore.expiryDate.split("/")[0]),
                          expYear: int.parse(
                              _warrantyFormStore.expiryDate.split("/")[1]));
                      _warrantyStore!
                          .checkout(card, _warrantyStore!.warranty!.id!);
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
      _warrantyStore!.checkoutSuccess = false;
      _warrantyStore!.transferSuccess = false;
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WarrantyStatusScreen()));
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
