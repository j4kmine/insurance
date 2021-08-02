import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color borderColor;
  final Color textColor;
  final Widget? img;
  final VoidCallback? onPressed;

  const PrimaryButtonWidget(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white,
      this.onPressed,
      this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(top: 14, bottom: 14),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText!,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(fontWeight: FontWeight.bold, color: textColor),
          ),
          img != null ? SizedBox(width: 4) : Container(),
          img != null ? img! : Container()
        ],
      ),
    );
  }
}
